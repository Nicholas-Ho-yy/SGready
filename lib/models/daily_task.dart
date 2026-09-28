// SGReady Final Year Project
// Developed by: Nicholas Ho
//
// This file was developed by me for SGReady. It defines the structure used
// for the daily preparedness tasks shown to the user.
//
// The enum and class syntax used here are standard Dart language features.

/// Defines how a daily task is completed by the user.
///
/// A checkbox task only needs to be completed once, while a counter task
/// keeps track of repeated actions, for example drinking a few glasses
/// of water.
enum DailyTaskType {
  checkbox,
  counter,
}

/// Stores the information needed for a daily preparedness task.
///
/// I created this model so that the different daily tasks can use the same
/// structure even if their content and completion method is different.
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

  // Basic information that is displayed for the task.
  final String id;
  final String title;
  final String description;
  final String category;
  final int points;
  final DailyTaskType type;
  final String reason;
  final String estimatedTime;

  /// Number of times a counter task needs to be completed.
  ///
  /// For example, a target of 6 means the user should drink six glasses
  /// of water.
  final int target;

  /// Optional word shown together with the counter value, such as
  /// "glasses" or "times".
  final String? unitLabel;

  /// Used when the same task ID may display different content.
  ///
  /// This only changes the content shown to the user and does not change
  /// how the task progress is tracked.
  final String? contentKey;

  // These helper getters make it easier for other parts of the app to check
  // which type of task they are working with.
  bool get isCheckbox {
    return type == DailyTaskType.checkbox;
  }

  bool get isCounter {
    return type == DailyTaskType.counter;
  }
}
