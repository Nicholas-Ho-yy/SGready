/// Represents an achievement that can be earned through
/// preparedness activities in SGReady.
class Badge {
  const Badge({
    required this.id,
    required this.title,
    required this.description,
    required this.iconName,
    required this.pointsRequired,
  });

  final String id;
  final String title;
  final String description;
  final String iconName;
  final int pointsRequired;
}

/// Stores a quiz question together with its possible answers,
/// correct answer and the feedback shown to the user.
class QuizQuestion {
  const QuizQuestion({
    required this.id,
    required this.topic,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });

  final String id;
  final String topic;
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  bool isCorrect(int selectedIndex) {
    return selectedIndex == correctIndex;
  }
}

/// Distinguishes physical emergency-kit items from other
/// preparedness actions in the checklist.
enum ChecklistItemType {
  kitItem,
  preparednessAction,
}

/// Represents an item or preparedness action that users can
/// complete as part of the emergency-kit checklist.
class ChecklistItem {
  const ChecklistItem({
    required this.id,
    required this.category,
    required this.label,
    required this.points,
    required this.type,
  });

  final String id;
  final String category;
  final String label;
  final int points;
  final ChecklistItemType type;

  bool get isKitItem {
    return type == ChecklistItemType.kitItem;
  }

  bool get isPreparednessAction {
    return type == ChecklistItemType.preparednessAction;
  }
}

/// Holds the user's overall preparedness progress.
///
/// This includes XP, streaks, completed activities, badges and
/// daily-task progress. The same model is also converted to and
/// from a map when progress is stored in Firestore.
class UserProgress {
  const UserProgress({
    this.points = 0,
    this.streakDays = 0,
    this.completedChecklistIds = const [],
    this.completedQuizIds = const [],
    this.earnedBadgeIds = const [],
    this.lastCheckInAt,
    this.dailyTaskDate,
    this.dailyTaskProgress = const {},
    this.dailyTaskRewardClaimed = false,
    this.completedDailyPlanDates = const [],
    this.completedScenarioIds = const [],
  });

  final int points;
  final int streakDays;

  final List<String> completedChecklistIds;
  final List<String> completedQuizIds;
  final List<String> earnedBadgeIds;
  final List<String> completedScenarioIds;

  final DateTime? lastCheckInAt;

  final DateTime? dailyTaskDate;
  final Map<String, int> dailyTaskProgress;
  final bool dailyTaskRewardClaimed;
  final List<DateTime> completedDailyPlanDates;

  /// Converts accumulated XP into a level, with each 100 XP
  /// advancing the user by one level.
  int get level => (points ~/ 100) + 1;

  /// Calculates how much of the preparedness checklist has been completed.
  /// Only IDs that still exist in the current checklist are counted.
  int get checklistCompletionPercentage {
    if (defaultChecklist.isEmpty) {
      return 0;
    }

    final validCompletedItems = completedChecklistIds
        .where(
          (id) => defaultChecklist.any(
            (item) => item.id == id,
          ),
        )
        .toSet()
        .length;

    return ((validCompletedItems / defaultChecklist.length) * 100)
        .clamp(0, 100)
        .round();
  }

  /// Calculates quiz completion based on valid completed question IDs.
  int get quizCompletionPercentage {
    if (defaultQuizzes.isEmpty) {
      return 0;
    }

    final validCompletedQuizIds = completedQuizIds
        .where(
          (id) => defaultQuizzes.any(
            (question) => question.id == id,
          ),
        )
        .toSet()
        .length;

    return ((validCompletedQuizIds / defaultQuizzes.length) * 100)
        .clamp(0, 100)
        .round();
  }

  /// Calculates the percentage of currently available badges earned.
  int get badgeCompletionPercentage {
    if (defaultBadges.isEmpty) {
      return 0;
    }

    final validEarnedBadgeIds = earnedBadgeIds
        .where(
          (id) => defaultBadges.any(
            (badge) => badge.id == id,
          ),
        )
        .toSet()
        .length;

    return ((validEarnedBadgeIds / defaultBadges.length) * 100)
        .clamp(0, 100)
        .round();
  }

  /// Converts the current streak into an engagement percentage.
  /// A seven-day streak reaches the maximum engagement score.
  int get engagementPercentage {
    if (streakDays <= 0) {
      return 0;
    }

    return ((streakDays / 7) * 100).clamp(0, 100).round();
  }

  /// Combines the main areas of user progress into one Preparedness Score.
  ///
  /// Checklist completion contributes 40%, quiz completion 30%,
  /// engagement 20%, and earned badges 10%. Keeping each component
  /// on the same 0–100 scale makes the weighted score easier to compare
  /// and keeps the final result between 0 and 100.
  int get preparednessScore {
    final checklistContribution = checklistCompletionPercentage * 0.40;

    final quizContribution = quizCompletionPercentage * 0.30;

    final engagementContribution = engagementPercentage * 0.20;

    final badgeContribution = badgeCompletionPercentage * 0.10;

    return (checklistContribution +
            quizContribution +
            engagementContribution +
            badgeContribution)
        .clamp(0, 100)
        .round();
  }

  bool hasCompletedChecklistItem(String id) {
    return completedChecklistIds.contains(id);
  }

  bool hasCompletedQuiz(String id) {
    return completedQuizIds.contains(id);
  }

  bool hasCompletedScenario(String id) {
    return completedScenarioIds.contains(id);
  }

  bool hasEarnedBadge(String id) {
    return earnedBadgeIds.contains(id);
  }

  bool hasCheckedInOn(DateTime date) {
    final lastCheckIn = lastCheckInAt;

    if (lastCheckIn == null) {
      return false;
    }

    return lastCheckIn.year == date.year &&
        lastCheckIn.month == date.month &&
        lastCheckIn.day == date.day;
  }

  bool hasDailyTaskDataFor(DateTime date) {
    final savedDate = dailyTaskDate;

    if (savedDate == null) {
      return false;
    }

    return savedDate.year == date.year &&
        savedDate.month == date.month &&
        savedDate.day == date.day;
  }

  int dailyTaskProgressFor(String taskId) {
    return dailyTaskProgress[taskId] ?? 0;
  }

  bool isDailyTaskCompleted({
    required String taskId,
    required int target,
  }) {
    return dailyTaskProgressFor(taskId) >= target;
  }

  /// Creates an updated copy of the user's progress while keeping
  /// any values that have not changed.
  UserProgress copyWith({
    int? points,
    int? streakDays,
    List<String>? completedChecklistIds,
    List<String>? completedQuizIds,
    List<String>? completedScenarioIds,
    List<String>? earnedBadgeIds,
    DateTime? lastCheckInAt,
    DateTime? dailyTaskDate,
    Map<String, int>? dailyTaskProgress,
    bool? dailyTaskRewardClaimed,
    List<DateTime>? completedDailyPlanDates,
  }) {
    return UserProgress(
      points: points ?? this.points,
      streakDays: streakDays ?? this.streakDays,
      completedChecklistIds: List.unmodifiable(
        completedChecklistIds ?? this.completedChecklistIds,
      ),
      completedQuizIds: List.unmodifiable(
        completedQuizIds ?? this.completedQuizIds,
      ),
      completedScenarioIds: List.unmodifiable(
        completedScenarioIds ?? this.completedScenarioIds,
      ),
      earnedBadgeIds: List.unmodifiable(
        earnedBadgeIds ?? this.earnedBadgeIds,
      ),
      lastCheckInAt: lastCheckInAt ?? this.lastCheckInAt,
      dailyTaskDate: dailyTaskDate ?? this.dailyTaskDate,
      dailyTaskProgress: Map.unmodifiable(
        dailyTaskProgress ?? this.dailyTaskProgress,
      ),
      dailyTaskRewardClaimed:
          dailyTaskRewardClaimed ?? this.dailyTaskRewardClaimed,
      completedDailyPlanDates: List.unmodifiable(
        completedDailyPlanDates ?? this.completedDailyPlanDates,
      ),
    );
  }

  /// Converts the user's progress into a Firestore-friendly map.
  Map<String, dynamic> toMap() {
    return {
      'points': points,
      'streakDays': streakDays,
      'completedChecklistIds': completedChecklistIds,
      'completedQuizIds': completedQuizIds,
      'completedScenarioIds': completedScenarioIds,
      'earnedBadgeIds': earnedBadgeIds,
      'lastCheckInAt': lastCheckInAt?.toIso8601String(),
      'dailyTaskDate': dailyTaskDate?.toIso8601String(),
      'dailyTaskProgress': dailyTaskProgress,
      'dailyTaskRewardClaimed': dailyTaskRewardClaimed,
      'completedDailyPlanDates': completedDailyPlanDates
          .map((date) => date.toIso8601String())
          .toList(),
    };
  }

  /// Rebuilds user progress from data previously stored in Firestore.
  /// Missing values fall back to safe defaults for new or older accounts.
  factory UserProgress.fromMap(Map<String, dynamic> map) {
    return UserProgress(
      points: (map['points'] as num?)?.toInt() ?? 0,
      streakDays: (map['streakDays'] as num?)?.toInt() ?? 0,
      completedChecklistIds: _toStringList(
        map['completedChecklistIds'],
      ),
      completedQuizIds: _toStringList(
        map['completedQuizIds'],
      ),
      completedScenarioIds: _toStringList(
        map['completedScenarioIds'],
      ),
      earnedBadgeIds: _toStringList(
        map['earnedBadgeIds'],
      ),
      lastCheckInAt: _parseDateTime(
        map['lastCheckInAt'],
      ),
      dailyTaskDate: _parseDateTime(
        map['dailyTaskDate'],
      ),
      dailyTaskProgress: _toIntMap(
        map['dailyTaskProgress'],
      ),
      dailyTaskRewardClaimed: map['dailyTaskRewardClaimed'] as bool? ?? false,
      completedDailyPlanDates: _toDateTimeList(
        map['completedDailyPlanDates'],
      ),
    );
  }

  // These helpers safely convert loosely typed Firestore values back into
  // the strongly typed collections used by UserProgress.
  static List<String> _toStringList(dynamic value) {
    if (value is! List) {
      return const [];
    }

    return List.unmodifiable(
      value.whereType<String>(),
    );
  }

  static Map<String, int> _toIntMap(dynamic value) {
    if (value is! Map) {
      return const {};
    }

    final result = <String, int>{};

    for (final entry in value.entries) {
      final key = entry.key;
      final progress = entry.value;

      if (key is String && progress is num) {
        result[key] = progress.toInt();
      }
    }

    return Map.unmodifiable(result);
  }

  static List<DateTime> _toDateTimeList(
    dynamic value,
  ) {
    if (value is! List) {
      return const [];
    }

    final dates = <DateTime>[];

    for (final item in value) {
      if (item is String) {
        final parsed = DateTime.tryParse(item);

        if (parsed != null) {
          dates.add(parsed);
        }
      }
    }

    return List.unmodifiable(dates);
  }

  static DateTime? _parseDateTime(dynamic value) {
    if (value is! String || value.trim().isEmpty) {
      return null;
    }

    return DateTime.tryParse(value);
  }
}

// -----------------------------------------------------------------------------
// Default gamification content
// -----------------------------------------------------------------------------

/// Badges that users can earn through preparedness activities.
const defaultBadges = [
  Badge(
    id: 'first_check',
    title: 'First Step',
    description: 'Complete your first preparedness checklist item.',
    iconName: 'check_circle',
    pointsRequired: 10,
  ),
  Badge(
    id: 'haze_hero',
    title: 'Haze Hero',
    description: 'Complete both haze preparedness questions.',
    iconName: 'masks',
    pointsRequired: 50,
  ),
  Badge(
    id: 'uv_guardian',
    title: 'UV Guardian',
    description: 'Complete both UV protection questions.',
    iconName: 'wb_sunny',
    pointsRequired: 50,
  ),
  Badge(
    id: 'flood_ready',
    title: 'Flood Ready',
    description: 'Complete all flood preparedness checklist items.',
    iconName: 'water_drop',
    pointsRequired: 75,
  ),
  Badge(
    id: 'streak_7',
    title: 'Week Warrior',
    description: 'Maintain a seven-day daily check-in streak.',
    iconName: 'local_fire_department',
    pointsRequired: 100,
  ),
];

/// Preparedness items used by the emergency-kit checklist.
const defaultChecklist = [
  ChecklistItem(
    id: 'haze_mask',
    category: 'Haze',
    label: 'Keep N95 masks at home and in your bag',
    points: 15,
    type: ChecklistItemType.kitItem,
  ),
  ChecklistItem(
    id: 'haze_meds',
    category: 'Haze',
    label: 'Stock inhaler or allergy medication if needed',
    points: 15,
    type: ChecklistItemType.kitItem,
  ),
  ChecklistItem(
    id: 'uv_sunscreen',
    category: 'UV',
    label: 'Keep SPF 30+ sunscreen available',
    points: 10,
    type: ChecklistItemType.kitItem,
  ),
  ChecklistItem(
    id: 'uv_hat',
    category: 'UV',
    label: 'Keep a hat and sunglasses ready',
    points: 10,
    type: ChecklistItemType.kitItem,
  ),
  ChecklistItem(
    id: 'heat_water',
    category: 'Heat',
    label: 'Keep a reusable water bottle ready',
    points: 10,
    type: ChecklistItemType.kitItem,
  ),
  ChecklistItem(
    id: 'flood_bag',
    category: 'Flood',
    label: 'Prepare a grab bag with a torch and power bank',
    points: 20,
    type: ChecklistItemType.kitItem,
  ),
  ChecklistItem(
    id: 'flood_alerts',
    category: 'Flood',
    label: 'Save official flood-alert channels on your phone',
    points: 15,
    type: ChecklistItemType.preparednessAction,
  ),
  ChecklistItem(
    id: 'flood_route',
    category: 'Flood',
    label: 'Identify an alternative route away from flood-prone areas',
    points: 20,
    type: ChecklistItemType.preparednessAction,
  ),
];

/// Question bank covering SGReady's main environmental preparedness topics.
const defaultQuizzes = [
  QuizQuestion(
    id: 'haze_1',
    topic: 'Haze',
    question:
        'When the 24-hour PSI enters the Unhealthy range, what should healthy people reduce?',
    options: [
      'Drinking water',
      'Prolonged or strenuous outdoor activity',
      'Indoor activities',
      'Sleeping',
    ],
    correctIndex: 1,
    explanation:
        'When air quality enters the Unhealthy range, prolonged or strenuous outdoor activity should be reduced.',
  ),
  QuizQuestion(
    id: 'haze_2',
    topic: 'Haze',
    question: 'Which mask is designed to filter fine haze particles?',
    options: [
      'Surgical mask',
      'N95 respirator',
      'Cloth mask',
      'No mask is required',
    ],
    correctIndex: 1,
    explanation:
        'A properly fitted N95 respirator is designed to filter fine particles more effectively than surgical or cloth masks.',
  ),
  QuizQuestion(
    id: 'haze_3',
    topic: 'Haze',
    question:
        'Why should you check air-quality conditions before prolonged outdoor activity during haze?',
    options: [
      'Air quality can change throughout the day',
      'PSI only measures temperature',
      'Haze only affects visibility',
      'Outdoor activity improves air quality',
    ],
    correctIndex: 0,
    explanation:
        'Air quality can change, so checking current conditions helps you decide whether to adjust prolonged outdoor activities.',
  ),
  QuizQuestion(
    id: 'haze_4',
    topic: 'Haze',
    question:
        'What is a sensible way to reduce haze exposure when air quality worsens?',
    options: [
      'Spend more time outdoors',
      'Increase strenuous outdoor exercise',
      'Reduce unnecessary prolonged outdoor exposure',
      'Keep all outdoor plans unchanged',
    ],
    correctIndex: 2,
    explanation:
        'Reducing unnecessary prolonged outdoor exposure can help limit exposure when air quality worsens.',
  ),
  QuizQuestion(
    id: 'haze_5',
    topic: 'Haze',
    question:
        'If you still need to go outside during hazy conditions, what should you continue doing?',
    options: [
      'Ignore later air-quality updates',
      'Monitor current air-quality information and relevant advisories',
      'Assume conditions will remain unchanged',
      'Stay outside longer to adapt to the haze',
    ],
    correctIndex: 1,
    explanation:
        'Continue monitoring current air-quality information because conditions and relevant recommendations may change.',
  ),
  QuizQuestion(
    id: 'uv_1',
    topic: 'UV',
    question: 'UV Index 8–10 belongs to which category?',
    options: [
      'Low',
      'Moderate',
      'Very High',
      'Extreme',
    ],
    correctIndex: 2,
    explanation:
        'A UV Index of 8–10 is categorised as Very High and requires strong sun protection.',
  ),
  QuizQuestion(
    id: 'uv_2',
    topic: 'UV',
    question: 'When is UV exposure typically strongest in Singapore?',
    options: [
      'Early morning',
      'Around midday',
      'Evening',
      'Night',
    ],
    correctIndex: 1,
    explanation:
        'UV radiation is generally strongest around midday, so additional protection is important during this period.',
  ),
  QuizQuestion(
    id: 'uv_3',
    topic: 'UV',
    question:
        'What is a good way to reduce UV exposure when spending time outdoors?',
    options: [
      'Seek shade when possible',
      'Stay in direct sunlight for longer',
      'Only protect yourself when it feels hot',
      'Avoid drinking water',
    ],
    correctIndex: 0,
    explanation:
        'Seeking shade can help reduce direct exposure to ultraviolet radiation while outdoors.',
  ),
  QuizQuestion(
    id: 'uv_4',
    topic: 'UV',
    question:
        'Which combination provides better protection when UV levels are high?',
    options: [
      'Sunscreen, suitable clothing and shade',
      'Drinking water only',
      'A surgical mask and gloves',
      'Staying in direct sunlight',
    ],
    correctIndex: 0,
    explanation:
        'Using multiple forms of sun protection, including sunscreen, suitable clothing and shade, helps reduce UV exposure.',
  ),
  QuizQuestion(
    id: 'uv_5',
    topic: 'UV',
    question: 'Why should you still consider UV protection on a cloudy day?',
    options: [
      'UV radiation can still reach you through cloud cover',
      'Clouds always increase the UV Index',
      'UV radiation only exists when it rains',
      'Sun protection is only needed on clear days',
    ],
    correctIndex: 0,
    explanation:
        'Cloud cover does not completely block ultraviolet radiation, so UV protection may still be necessary.',
  ),
  QuizQuestion(
    id: 'flood_1',
    topic: 'Flood',
    question: 'What should you do when a road ahead is covered by flood water?',
    options: [
      'Drive through quickly',
      'Turn around and use another route',
      'Stop in the middle of the flooded road',
      'Open the vehicle windows',
    ],
    correctIndex: 1,
    explanation:
        'Do not enter flood water. Turn around and use a safer alternative route.',
  ),
  QuizQuestion(
    id: 'flood_2',
    topic: 'Flood',
    question: 'Why should you avoid walking through flood water?',
    options: [
      'It may contain hidden hazards or strong currents',
      'Flood water is always too cold',
      'Walking makes the flood rise faster',
      'It is only unsafe at night',
    ],
    correctIndex: 0,
    explanation:
        'Flood water can hide hazards and may be deeper or faster-moving than it appears.',
  ),
  QuizQuestion(
    id: 'flood_3',
    topic: 'Flood',
    question:
        'Heavy rain is continuing and you need to travel. What should you do before leaving?',
    options: [
      'Take your usual route without checking',
      'Check current weather and flood information',
      'Choose the lowest-lying route',
      'Wait until you are driving to check conditions',
    ],
    correctIndex: 1,
    explanation:
        'Checking current weather and flood information can help you avoid affected areas and plan a safer route.',
  ),
  QuizQuestion(
    id: 'flood_4',
    topic: 'Flood',
    question: 'What should you do if you encounter a flooded pedestrian path?',
    options: [
      'Enter the water slowly',
      'Follow others through the water',
      'Avoid the flooded area and use a safer route',
      'Run through it quickly',
    ],
    correctIndex: 2,
    explanation:
        'Avoid entering flooded areas because water depth, currents and hidden hazards may be difficult to judge.',
  ),
  QuizQuestion(
    id: 'flood_5',
    topic: 'Flood',
    question:
        'Why is it useful to continue monitoring conditions during heavy rain?',
    options: [
      'Flood conditions can change quickly',
      'It makes the rain stop sooner',
      'Weather information only applies indoors',
      'Flood conditions remain the same throughout the day',
    ],
    correctIndex: 0,
    explanation:
        'Heavy rain and flood conditions can change, so updated information can help you adjust your plans.',
  ),
  QuizQuestion(
    id: 'heat_1',
    topic: 'Heat',
    question:
        'What is a good way to reduce heat stress during prolonged outdoor activity?',
    options: [
      'Take regular breaks in a cooler or shaded area',
      'Avoid taking breaks',
      'Wear additional heavy clothing',
      'Stay in direct sunlight continuously',
    ],
    correctIndex: 0,
    explanation:
        'Regular cooling breaks in a shaded or cooler area can help reduce heat stress during prolonged outdoor activity.',
  ),
  QuizQuestion(
    id: 'heat_2',
    topic: 'Heat',
    question: 'What should you do to stay hydrated during hot weather?',
    options: [
      'Wait until you feel extremely thirsty before drinking',
      'Drink water regularly',
      'Avoid water during outdoor activities',
      'Only drink after completing all activities',
    ],
    correctIndex: 1,
    explanation:
        'Drinking water regularly helps maintain hydration during hot conditions and outdoor activity.',
  ),
  QuizQuestion(
    id: 'heat_3',
    topic: 'Heat',
    question:
        'When possible, how should you plan strenuous outdoor activities during very hot conditions?',
    options: [
      'Choose cooler periods of the day',
      'Always exercise around midday',
      'Increase the duration of the activity',
      'Avoid checking weather conditions',
    ],
    correctIndex: 0,
    explanation:
        'Planning strenuous activities during cooler periods can help reduce unnecessary heat exposure.',
  ),
  QuizQuestion(
    id: 'heat_4',
    topic: 'Heat',
    question:
        'Why is it useful to monitor heat conditions before and during outdoor activities?',
    options: [
      'Conditions can change and may require you to adjust your plans',
      'Heat conditions never change during the day',
      'Weather information only matters when it rains',
      'Monitoring conditions makes your body cooler',
    ],
    correctIndex: 0,
    explanation:
        'Monitoring current conditions helps you decide when to reduce activity, take additional breaks or adjust your plans.',
  ),
  QuizQuestion(
    id: 'heat_5',
    topic: 'Heat',
    question:
        'You begin feeling unwell while exercising in very hot conditions. What is the safest response?',
    options: [
      'Continue exercising at the same intensity',
      'Exercise harder so you can finish sooner',
      'Stop the activity and move to a cooler or shaded place',
      'Stay in direct sunlight and wait',
    ],
    correctIndex: 2,
    explanation:
        'If you begin feeling unwell in the heat, stop the activity and move to a cooler or shaded location rather than continuing to exert yourself.',
  ),
];
