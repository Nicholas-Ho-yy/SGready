// SGReady Final Year Project
// Developed by: Nicholas Ho
//
// The SGReady-specific preference model and logic in this file were
// developed by me. This file does not contain any externally adapted
// or generated code.

/// Describes how frequently the user expects to be active outdoors.
enum OutdoorActivityLevel {
  low,
  moderate,
  high,
}

/// Represents the parts of the day when the user is usually outdoors.
enum OutdoorTime {
  morning,
  midday,
  evening,
}

/// Controls when SGReady is allowed to provide weather and
/// preparedness notifications.
enum NotificationScheduleMode {
  daytime,
  allDay,
}

/// Stores the user's personalisation and accessibility preferences.
///
/// These settings are persisted between sessions and are used to tailor
/// preparedness content, notifications and the app's presentation.
class UserPreferences {
  const UserPreferences({
    this.homeRegion = 'Central',
    this.outdoorActivityLevel = OutdoorActivityLevel.moderate,
    this.outdoorTimes = const {
      OutdoorTime.midday,
    },
    this.preparednessRemindersEnabled = true,
    this.reminderHour = 8,
    this.reminderMinute = 0,
    this.notificationScheduleMode = NotificationScheduleMode.daytime,
    this.largerTextEnabled = false,
    this.largerControlsEnabled = false,
    this.languageCode = 'en',
  });

  final String homeRegion;
  final OutdoorActivityLevel outdoorActivityLevel;
  final Set<OutdoorTime> outdoorTimes;
  final bool preparednessRemindersEnabled;
  final int reminderHour;
  final int reminderMinute;
  final NotificationScheduleMode notificationScheduleMode;
  final bool largerTextEnabled;
  final bool largerControlsEnabled;
  final String languageCode;

  // Create a new copy of the user's preferences with the changed settings,
  // while keeping the existing value for anything that was not changed.
  UserPreferences copyWith({
    String? homeRegion,
    OutdoorActivityLevel? outdoorActivityLevel,
    Set<OutdoorTime>? outdoorTimes,
    bool? preparednessRemindersEnabled,
    int? reminderHour,
    int? reminderMinute,
    NotificationScheduleMode? notificationScheduleMode,
    bool? largerTextEnabled,
    bool? largerControlsEnabled,
    String? languageCode,
  }) {
    return UserPreferences(
      homeRegion: homeRegion ?? this.homeRegion,
      outdoorActivityLevel: outdoorActivityLevel ?? this.outdoorActivityLevel,
      outdoorTimes: outdoorTimes ?? this.outdoorTimes,
      preparednessRemindersEnabled:
          preparednessRemindersEnabled ?? this.preparednessRemindersEnabled,
      reminderHour: reminderHour ?? this.reminderHour,
      reminderMinute: reminderMinute ?? this.reminderMinute,
      notificationScheduleMode:
          notificationScheduleMode ?? this.notificationScheduleMode,
      largerTextEnabled: largerTextEnabled ?? this.largerTextEnabled,
      largerControlsEnabled:
          largerControlsEnabled ?? this.largerControlsEnabled,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  // Convert the user's preferences into a map so they can be saved.
  // Enum values are stored using their names so they can be restored later.
  Map<String, dynamic> toMap() {
    return {
      'homeRegion': homeRegion,
      'outdoorActivityLevel': outdoorActivityLevel.name,
      'outdoorTimes': outdoorTimes.map((time) => time.name).toList(),
      'preparednessRemindersEnabled': preparednessRemindersEnabled,
      'reminderHour': reminderHour,
      'reminderMinute': reminderMinute,
      'notificationScheduleMode': notificationScheduleMode.name,
      'largerTextEnabled': largerTextEnabled,
      'largerControlsEnabled': largerControlsEnabled,
      'languageCode': languageCode,
    };
  }

  // Restore the user's preferences from the previously saved data.
  //
  // If a setting is missing or no longer recognised, I use a default value.
  // This also helps older saved preferences continue working if new settings
  // are added to the app later.
  factory UserPreferences.fromMap(
    Map<String, dynamic> map,
  ) {
    final activityName = map['outdoorActivityLevel'] as String?;

    final scheduleModeName = map['notificationScheduleMode'] as String?;

    final outdoorTimeNames =
        (map['outdoorTimes'] as List?)?.whereType<String>().toSet() ??
            const <String>{};

    // Match the saved enum names back to the enum values used by the app.
    return UserPreferences(
      homeRegion: map['homeRegion'] as String? ?? 'Central',
      outdoorActivityLevel: OutdoorActivityLevel.values.firstWhere(
        (level) => level.name == activityName,
        orElse: () => OutdoorActivityLevel.moderate,
      ),
      outdoorTimes: OutdoorTime.values
          .where(
            (time) => outdoorTimeNames.contains(
              time.name,
            ),
          )
          .toSet(),
      preparednessRemindersEnabled:
          map['preparednessRemindersEnabled'] as bool? ?? true,
      reminderHour: map['reminderHour'] as int? ?? 8,
      reminderMinute: map['reminderMinute'] as int? ?? 0,
      notificationScheduleMode: NotificationScheduleMode.values.firstWhere(
        (mode) => mode.name == scheduleModeName,
        orElse: () => NotificationScheduleMode.daytime,
      ),
      largerTextEnabled: map['largerTextEnabled'] as bool? ?? false,
      largerControlsEnabled: map['largerControlsEnabled'] as bool? ?? false,
      languageCode: map['languageCode'] as String? ?? 'en',
    );
  }
}
