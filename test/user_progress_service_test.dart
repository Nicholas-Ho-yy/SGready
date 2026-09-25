import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sg_env_ready/models/daily_task.dart';
import 'package:sg_env_ready/services/user_progress_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late UserProgressService service;
  late FakeFirebaseFirestore firestore;

  const testTask = DailyTask(
    id: 'test_daily_task',
    title: 'Test task',
    description: 'Used for streak testing.',
    reason: 'Test only.',
    estimatedTime: '1 minute',
    category: 'Test',
    points: 10,
  );

  setUp(() async {
    firestore = FakeFirebaseFirestore();

    service = UserProgressService(
      userId: 'test-user',
      firestore: firestore,
    );

    await service.init();
  });

  tearDown(() {
    service.dispose();
  });

  test('streak increases on consecutive completed days', () async {
    final day1 = DateTime(2026, 8, 20);
    final day2 = DateTime(2026, 8, 21);
    final day3 = DateTime(2026, 8, 22);

    await service.prepareDailyTasks(
      currentTime: day1,
    );

    await service.setDailyTaskCompleted(
      task: testTask,
      isCompleted: true,
      currentTime: day1,
    );

    var progress = await service.claimDailyTaskReward(
      tasks: const [testTask],
      currentTime: day1,
    );

    expect(progress.streakDays, 1);

    await service.prepareDailyTasks(
      currentTime: day2,
    );

    await service.setDailyTaskCompleted(
      task: testTask,
      isCompleted: true,
      currentTime: day2,
    );

    progress = await service.claimDailyTaskReward(
      tasks: const [testTask],
      currentTime: day2,
    );

    expect(progress.streakDays, 2);

    await service.prepareDailyTasks(
      currentTime: day3,
    );

    await service.setDailyTaskCompleted(
      task: testTask,
      isCompleted: true,
      currentTime: day3,
    );

    progress = await service.claimDailyTaskReward(
      tasks: const [testTask],
      currentTime: day3,
    );

    expect(progress.streakDays, 3);
  });

  test('missing a day resets the streak', () async {
    final day1 = DateTime(2026, 8, 20);
    final day3 = DateTime(2026, 8, 22);

    await service.prepareDailyTasks(
      currentTime: day1,
    );

    await service.setDailyTaskCompleted(
      task: testTask,
      isCompleted: true,
      currentTime: day1,
    );

    var progress = await service.claimDailyTaskReward(
      tasks: const [testTask],
      currentTime: day1,
    );

    expect(progress.streakDays, 1);

    // Day 21 is skipped completely.

    await service.prepareDailyTasks(
      currentTime: day3,
    );

    expect(
      (await service.getProgress()).streakDays,
      0,
    );

    await service.setDailyTaskCompleted(
      task: testTask,
      isCompleted: true,
      currentTime: day3,
    );

    progress = await service.claimDailyTaskReward(
      tasks: const [testTask],
      currentTime: day3,
    );

    expect(progress.streakDays, 1);
  });

  test('new day resets daily mission progress but keeps long-term progress',
      () async {
    final day1 = DateTime(2026, 8, 22);
    final day2 = DateTime(2026, 8, 23);

    const task = DailyTask(
      id: 'test_daily_task',
      title: 'Test task',
      description: 'Used for daily reset testing.',
      reason: 'Test only.',
      estimatedTime: '1 minute',
      category: 'Test',
      points: 20,
    );

    // DAY 1
    await service.prepareDailyTasks(
      currentTime: day1,
    );

    await service.setDailyTaskCompleted(
      task: task,
      isCompleted: true,
      currentTime: day1,
    );

    final day1Progress = await service.claimDailyTaskReward(
      tasks: const [task],
      currentTime: day1,
    );

    expect(
      day1Progress.dailyTaskRewardClaimed,
      true,
    );

    expect(
      day1Progress.dailyTaskProgressFor(task.id),
      1,
    );

    final pointsAfterDay1 = day1Progress.points;

    final streakAfterDay1 = day1Progress.streakDays;

    // DAY 2
    await service.prepareDailyTasks(
      currentTime: day2,
    );

    final day2Progress = await service.getProgress();

    // Daily mission should reset.
    expect(
      day2Progress.dailyTaskProgressFor(task.id),
      0,
    );

    expect(
      day2Progress.dailyTaskRewardClaimed,
      false,
    );

    // Long-term progress should remain.
    expect(
      day2Progress.points,
      pointsAfterDay1,
    );

    expect(
      day2Progress.streakDays,
      streakAfterDay1,
    );
  });

  test('progress does not leak between different daily tasks', () async {
    final day1 = DateTime(2026, 8, 22);
    final day2 = DateTime(2026, 8, 23);

    const sunscreenTask = DailyTask(
      id: 'apply_sunscreen',
      title: 'Apply sunscreen',
      description: 'Test sunscreen task.',
      reason: 'Test only.',
      estimatedTime: '30 seconds',
      category: 'UV',
      points: 10,
      type: DailyTaskType.counter,
      target: 4,
      unitLabel: 'steps',
    );

    const rainTask = DailyTask(
      id: 'rain_preparation',
      title: 'Prepare for heavy rain',
      description: 'Test rain task.',
      reason: 'Test only.',
      estimatedTime: '2 minutes',
      category: 'Rain',
      points: 20,
      type: DailyTaskType.counter,
      target: 4,
      unitLabel: 'steps',
    );

    // Day 1: make sunscreen 75% complete.
    await service.prepareDailyTasks(
      currentTime: day1,
    );

    await service.setDailyTaskProgress(
      task: sunscreenTask,
      progress: 3,
      currentTime: day1,
    );

    var progress = await service.getProgress();

    expect(
      progress.dailyTaskProgressFor('apply_sunscreen'),
      3,
    );

    // Day 2: start a new mission.
    await service.prepareDailyTasks(
      currentTime: day2,
    );

    progress = await service.getProgress();

    // Yesterday's sunscreen progress must be gone.
    expect(
      progress.dailyTaskProgressFor('apply_sunscreen'),
      0,
    );

    // New rain task should start at zero.
    expect(
      progress.dailyTaskProgressFor('rain_preparation'),
      0,
    );

    // Rain progress should work independently.
    await service.setDailyTaskProgress(
      task: rainTask,
      progress: 2,
      currentTime: day2,
    );

    progress = await service.getProgress();

    expect(
      progress.dailyTaskProgressFor('rain_preparation'),
      2,
    );

    expect(
      progress.dailyTaskProgressFor('apply_sunscreen'),
      0,
    );
  });

  test('completed daily plans are recorded in history', () async {
    final day1 = DateTime(2026, 8, 22);
    final day2 = DateTime(2026, 8, 23);

    const task = DailyTask(
      id: 'history_test_task',
      title: 'History test task',
      description: 'Used for history testing.',
      reason: 'Test only.',
      estimatedTime: '1 minute',
      category: 'Test',
      points: 10,
    );

    await service.prepareDailyTasks(
      currentTime: day1,
    );

    await service.setDailyTaskCompleted(
      task: task,
      isCompleted: true,
      currentTime: day1,
    );

    await service.claimDailyTaskReward(
      tasks: const [task],
      currentTime: day1,
    );

    await service.prepareDailyTasks(
      currentTime: day2,
    );

    await service.setDailyTaskCompleted(
      task: task,
      isCompleted: true,
      currentTime: day2,
    );

    final progress = await service.claimDailyTaskReward(
      tasks: const [task],
      currentTime: day2,
    );

    expect(
      progress.completedDailyPlanDates.length,
      2,
    );

    expect(
      progress.completedDailyPlanDates.any(
        (date) => date.year == 2026 && date.month == 8 && date.day == 22,
      ),
      true,
    );

    expect(
      progress.completedDailyPlanDates.any(
        (date) => date.year == 2026 && date.month == 8 && date.day == 23,
      ),
      true,
    );
  });
}
