// SGReady Final Year Project
// Developed by: Nicholas Ho
//
// The SGReady-specific progress tracking, points, streaks, badge awarding,
// daily task progress and Firestore persistence in this file were developed by me.
//
// Cloud Firestore is an external Firebase service used to store the user's
// progress. Dart's StreamController is used to send progress updates to
// other parts of the application.

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/daily_task.dart';
import '../models/gamification.dart';

/// Loads, updates, and stores the user's progress in Firestore.
class UserProgressService {
  UserProgressService({
    required this.userId,
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final String userId;
  final FirebaseFirestore _firestore;

  final StreamController<UserProgress> _controller =
      StreamController<UserProgress>.broadcast();

  // Keep the latest progress in memory so the app does not need to
  // read from Firestore every time progress is needed.
  UserProgress _cache = const UserProgress();
  bool _isInitialized = false;
  bool _isDisposed = false;

  DocumentReference<Map<String, dynamic>> get _userDocument {
    return _firestore.collection('users').doc(userId);
  }

  /// Loads the user's saved progress from Firestore. If no progress
  /// exists yet, a new empty progress record is created.
  Future<void> init() async {
    if (_isInitialized) {
      return;
    }

    final snapshot = await _userDocument.get();
    final data = snapshot.data();
    final progressData = data?['progress'];

    if (progressData is Map) {
      _cache = UserProgress.fromMap(
        Map<String, dynamic>.from(
          progressData,
        ),
      );
    } else {
      _cache = const UserProgress();

      await _userDocument.set(
        {
          'progress': _cache.toMap(),
        },
        SetOptions(
          merge: true,
        ),
      );
    }

    _isInitialized = true;

    if (!_isDisposed) {
      _controller.add(_cache);
    }
  }

  /// Provides the current progress first and then sends any later
  /// progress updates to listening parts of the app.
  Stream<UserProgress> watchProgress() async* {
    await init();

    yield _cache;

    yield* _controller.stream;
  }

  Future<UserProgress> getProgress() async {
    await init();

    return _cache;
  }

  /// Saves updated progress to Firestore and updates the local
  /// copy used by the rest of the app.
  Future<void> _persist(
    UserProgress progress,
  ) async {
    await init();

    await _userDocument.set(
      {
        'progress': progress.toMap(),
      },
      SetOptions(
        merge: true,
      ),
    );

    _cache = progress;

    if (!_isDisposed) {
      _controller.add(progress);
    }
  }

  // ---------------------------------------------------------------------------
  // Emergency kit and preparedness checklist
  // ---------------------------------------------------------------------------

  Future<UserProgress> setChecklistItemCompleted(
    ChecklistItem item,
    bool isCompleted,
  ) async {
    await init();

    final alreadyCompleted = _cache.completedChecklistIds.contains(item.id);

    if (alreadyCompleted == isCompleted) {
      return _cache;
    }

    final completedIds = [
      ..._cache.completedChecklistIds,
    ];

    var updatedPoints = _cache.points;

    // Add the item's points when it is completed, or remove them
    // if the user changes the item back to incomplete.
    if (isCompleted) {
      completedIds.add(item.id);
      updatedPoints += item.points;
    } else {
      completedIds.remove(item.id);
      updatedPoints = (updatedPoints - item.points).clamp(
        0,
        1 << 31,
      );
    }

    final badges = _awardBadges(
      currentBadgeIds: _cache.earnedBadgeIds,
      checklistIds: completedIds,
      quizIds: _cache.completedQuizIds,
      streak: _cache.streakDays,
    );

    final updated = _cache.copyWith(
      points: updatedPoints,
      completedChecklistIds: completedIds,
      earnedBadgeIds: badges,
    );

    await _persist(updated);
    return updated;
  }

  Future<UserProgress> completeChecklistItem(
    ChecklistItem item,
  ) {
    return setChecklistItemCompleted(
      item,
      true,
    );
  }

  // ---------------------------------------------------------------------------
  // Quizzes
  // ---------------------------------------------------------------------------

  Future<UserProgress> completeQuiz(
    String quizId,
    int score,
    int total, {
    int maxPoints = 50,
  }) async {
    await init();

    if (_cache.completedQuizIds.contains(quizId)) {
      return _cache;
    }

    final safeScore = score.clamp(0, total);

    // Convert the quiz result into points based on the percentage
    // of questions the user answered correctly.
    final pointsEarned =
        total > 0 ? ((safeScore / total) * maxPoints).round() : 0;

    final completedQuizIds = [
      ..._cache.completedQuizIds,
      quizId,
    ];

    final updatedPoints = _cache.points + pointsEarned;

    final badges = _awardBadges(
      currentBadgeIds: _cache.earnedBadgeIds,
      checklistIds: _cache.completedChecklistIds,
      quizIds: completedQuizIds,
      streak: _cache.streakDays,
    );

    final updated = _cache.copyWith(
      points: updatedPoints,
      completedQuizIds: completedQuizIds,
      earnedBadgeIds: badges,
    );

    await _persist(updated);
    return updated;
  }

  Future<UserProgress> completeScenario({
    required String scenarioId,
    required int points,
  }) async {
    await init();

    if (_cache.completedScenarioIds.contains(scenarioId)) {
      return _cache;
    }

    final completedScenarioIds = [
      ..._cache.completedScenarioIds,
      scenarioId,
    ];

    final updatedPoints = _cache.points + points;

    final updated = _cache.copyWith(
      points: updatedPoints,
      completedScenarioIds: completedScenarioIds,
    );

    await _persist(updated);

    return updated;
  }

  // ---------------------------------------------------------------------------
  // Daily check-in
  // ---------------------------------------------------------------------------

  Future<UserProgress> recordDailyCheckIn({
    DateTime? currentTime,
  }) async {
    await init();

    final now = currentTime ?? DateTime.now();

    if (_cache.hasCheckedInOn(now)) {
      return _cache;
    }

    final previousCheckIn = _cache.lastCheckInAt;
    var newStreak = 1;

    // Continue the streak when the previous check-in was yesterday.
    // Otherwise, the new streak starts again from one day.
    if (previousCheckIn != null) {
      final previousDate = _dateOnly(
        previousCheckIn,
      );

      final currentDate = _dateOnly(now);

      final difference = currentDate.difference(previousDate).inDays;

      if (difference == 1) {
        newStreak = _cache.streakDays + 1;
      }
    }

    // Give a larger bonus for every seventh day of the streak.
    final bonusPoints = newStreak % 7 == 0 ? 25 : 5;

    final updatedPoints = _cache.points + bonusPoints;

    final badges = _awardBadges(
      currentBadgeIds: _cache.earnedBadgeIds,
      checklistIds: _cache.completedChecklistIds,
      quizIds: _cache.completedQuizIds,
      streak: newStreak,
    );

    final updated = _cache.copyWith(
      streakDays: newStreak,
      points: updatedPoints,
      earnedBadgeIds: badges,
      lastCheckInAt: now,
    );

    await _persist(updated);
    return updated;
  }

  // ---------------------------------------------------------------------------
  // Today's tasks
  // ---------------------------------------------------------------------------

  /// Ensures the stored daily-task state belongs to [currentTime].
  ///
  /// If the saved task date is from an earlier day, task progress and the
  /// reward status are reset.
  Future<UserProgress> prepareDailyTasks({
    DateTime? currentTime,
  }) async {
    await init();

    final now = currentTime ?? DateTime.now();

    if (_cache.hasDailyTaskDataFor(now)) {
      return _cache;
    }

    final previousTaskDate = _cache.dailyTaskDate;
    var updatedStreak = _cache.streakDays;

    if (previousTaskDate != null) {
      final dayDifference = _dateOnly(now)
          .difference(
            _dateOnly(previousTaskDate),
          )
          .inDays;

      final previousDayWasCompleted = _cache.dailyTaskRewardClaimed;

      // Keep the streak only when yesterday's daily tasks were completed.
      if (dayDifference != 1 || !previousDayWasCompleted) {
        updatedStreak = 0;
      }
    }

    final updated = _cache.copyWith(
      streakDays: updatedStreak,
      dailyTaskDate: now,
      dailyTaskProgress: const {},
      dailyTaskRewardClaimed: false,
    );

    await _persist(updated);
    return updated;
  }

  /// Sets progress for one daily task.
  ///
  /// Checkbox tasks use values 0 or 1. Counter tasks may use values between
  /// 0 and the task's target.
  Future<UserProgress> setDailyTaskProgress({
    required DailyTask task,
    required int progress,
    DateTime? currentTime,
  }) async {
    await prepareDailyTasks(
      currentTime: currentTime,
    );

    final safeProgress = progress.clamp(
      0,
      task.target,
    );

    final existingProgress = _cache.dailyTaskProgressFor(task.id);

    if (existingProgress == safeProgress) {
      return _cache;
    }

    final updatedProgress = <String, int>{
      ..._cache.dailyTaskProgress,
      task.id: safeProgress,
    };

    final updated = _cache.copyWith(
      dailyTaskProgress: updatedProgress,
    );

    await _persist(updated);
    return updated;
  }

  /// Marks a checkbox task as completed or incomplete.
  Future<UserProgress> setDailyTaskCompleted({
    required DailyTask task,
    required bool isCompleted,
    DateTime? currentTime,
  }) {
    return setDailyTaskProgress(
      task: task,
      progress: isCompleted ? task.target : 0,
      currentTime: currentTime,
    );
  }

  /// Increases a counter task by [amount].
  Future<UserProgress> incrementDailyTask({
    required DailyTask task,
    int amount = 1,
    DateTime? currentTime,
  }) async {
    await prepareDailyTasks(
      currentTime: currentTime,
    );

    final currentProgress = _cache.dailyTaskProgressFor(task.id);

    return setDailyTaskProgress(
      task: task,
      progress: currentProgress + amount,
      currentTime: currentTime,
    );
  }

  /// Decreases a counter task by [amount].
  Future<UserProgress> decrementDailyTask({
    required DailyTask task,
    int amount = 1,
    DateTime? currentTime,
  }) async {
    await prepareDailyTasks(
      currentTime: currentTime,
    );

    final currentProgress = _cache.dailyTaskProgressFor(task.id);

    return setDailyTaskProgress(
      task: task,
      progress: currentProgress - amount,
      currentTime: currentTime,
    );
  }

  /// Returns whether all tasks in [tasks] have reached their target.
  Future<bool> areAllDailyTasksCompleted(
    List<DailyTask> tasks, {
    DateTime? currentTime,
  }) async {
    await prepareDailyTasks(
      currentTime: currentTime,
    );

    if (tasks.isEmpty) {
      return false;
    }

    return tasks.every(
      (task) => _cache.isDailyTaskCompleted(
        taskId: task.id,
        target: task.target,
      ),
    );
  }

  /// Awards the daily-task reward once all tasks have been completed.
  ///
  /// The reward is the sum of the point values assigned to today's tasks.
  Future<UserProgress> claimDailyTaskReward({
    required List<DailyTask> tasks,
    DateTime? currentTime,
  }) async {
    final now = currentTime ?? DateTime.now();

    await prepareDailyTasks(
      currentTime: now,
    );

    if (_cache.dailyTaskRewardClaimed) {
      return _cache;
    }

    final allCompleted = tasks.isNotEmpty &&
        tasks.every(
          (task) => _cache.isDailyTaskCompleted(
            taskId: task.id,
            target: task.target,
          ),
        );

    if (!allCompleted) {
      throw StateError(
        'All daily tasks must be completed before claiming the reward.',
      );
    }

    final rewardPoints = tasks.fold<int>(
      0,
      (total, task) => total + task.points,
    );

    // Completing the full daily plan counts as another day
    // towards the user's preparedness streak.
    final newStreak = _cache.streakDays + 1;
    final updatedPoints = _cache.points + rewardPoints;

    final badges = _awardBadges(
      currentBadgeIds: _cache.earnedBadgeIds,
      checklistIds: _cache.completedChecklistIds,
      quizIds: _cache.completedQuizIds,
      streak: newStreak,
    );

    final completedDates = [
      ..._cache.completedDailyPlanDates,
    ];

    final alreadyRecordedToday = completedDates.any(
      (date) =>
          date.year == now.year &&
          date.month == now.month &&
          date.day == now.day,
    );

    if (!alreadyRecordedToday) {
      completedDates.add(
        DateTime(
          now.year,
          now.month,
          now.day,
        ),
      );
    }

    final updated = _cache.copyWith(
      points: updatedPoints,
      streakDays: newStreak,
      earnedBadgeIds: badges,
      dailyTaskRewardClaimed: true,
      dailyTaskDate: now,
      completedDailyPlanDates: completedDates,
    );

    await _persist(updated);
    return updated;
  }

  // ---------------------------------------------------------------------------
  // Badges
  // ---------------------------------------------------------------------------

  // Check the user's completed activities and streak, then award
  // any badges whose requirements have now been reached.
  List<String> _awardBadges({
    required List<String> currentBadgeIds,
    required List<String> checklistIds,
    required List<String> quizIds,
    required int streak,
  }) {
    final earnedBadgeIds = [
      ...currentBadgeIds,
    ];

    void award(String badgeId) {
      if (!earnedBadgeIds.contains(badgeId)) {
        earnedBadgeIds.add(badgeId);
      }
    }

    if (checklistIds.isNotEmpty) {
      award('first_check');
    }

    if (quizIds.contains('haze_1') && quizIds.contains('haze_2')) {
      award('haze_hero');
    }

    if (quizIds.contains('uv_1') && quizIds.contains('uv_2')) {
      award('uv_guardian');
    }

    final floodChecklistIds = defaultChecklist
        .where(
          (item) => item.category == 'Flood',
        )
        .map(
          (item) => item.id,
        );

    if (floodChecklistIds.isNotEmpty &&
        floodChecklistIds.every(
          checklistIds.contains,
        )) {
      award('flood_ready');
    }

    if (streak >= 7) {
      award('streak_7');
    }

    return List.unmodifiable(
      earnedBadgeIds,
    );
  }

  // ---------------------------------------------------------------------------
  // Utility methods
  // ---------------------------------------------------------------------------

  DateTime _dateOnly(DateTime value) {
    return DateTime(
      value.year,
      value.month,
      value.day,
    );
  }

  Future<void> resetProgress() async {
    await init();

    await _persist(
      const UserProgress(),
    );
  }

  void dispose() {
    if (_isDisposed) {
      return;
    }

    _isDisposed = true;
    _controller.close();
  }
}