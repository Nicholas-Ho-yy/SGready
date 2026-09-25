/// Defines how a daily task is completed by the user.
///
/// Checkbox tasks are completed once, while counter tasks track
/// repeated actions such as drinking several glasses of water.
enum DailyTaskType {
  checkbox,
  counter,
}

/// Represents a preparedness activity that can appear in the user's daily plan.
///
/// Each task contains the information needed for display and progress tracking,
/// including its category, XP reward and completion requirements.
class DailyTask {
  const DailyTask({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.points,
    required this.reason,
    required this.estimatedTime,
    this.type = DailyTaskType.checkbox,
    this.target = 1,
    this.unitLabel,
    this.contentKey,
  });

  final String id;
  final String title;
  final String description;
  final String category;
  final int points;
  final DailyTaskType type;
  final String reason;
  final String estimatedTime;

  /// Number of repetitions required for a counter task.
  ///
  /// For example, a target of 6 represents drinking six glasses of water.
  final int target;

  /// Optional unit shown alongside the progress of a counter task,
  /// such as "glasses" or "times".
  final String? unitLabel;

  /// Optional key used when the same task ID can have different
  /// user-facing content.
  ///
  /// This does not affect task progress or completion tracking.
  final String? contentKey;

  bool get isCheckbox {
    return type == DailyTaskType.checkbox;
  }

  bool get isCounter {
    return type == DailyTaskType.counter;
  }
}
