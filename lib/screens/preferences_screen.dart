// SGReady Final Year Project
// Developed by: Nicholas Ho
//
// The SGReady-specific preferences screen, preference handling and settings
// interactions in this file were developed by me.
//
// Flutter and Riverpod are external frameworks/packages used for the interface
// and state management. The notification functionality uses SGReady's
// NotificationService together with the notification packages used by the app.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/app_localizations.dart';
import '../models/user_preferences.dart';
import '../providers/app_providers.dart';
import '../services/notification_service.dart';

/// Lets users manage the preferences that personalise SGReady,
/// including reminders, accessibility, language and appearance.
class PreferencesScreen extends ConsumerStatefulWidget {
  const PreferencesScreen({super.key});

  @override
  ConsumerState<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends ConsumerState<PreferencesScreen> {
  UserPreferences? _preferences;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();

    // Load the user's saved preferences when the screen first opens.
    // The values are then kept locally while the user makes changes.
    Future.microtask(() async {
      final preferences = await ref.read(userPreferencesProvider.future);

      if (!mounted) {
        return;
      }

      setState(() {
        _preferences = preferences;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final preferences = _preferences;
    final themeMode = ref.watch(themeModeProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.preferences),
      ),
      body: preferences == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  l10n.personaliseSGReady,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.preferencesDescription,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 20),

                // Changes on this screen update the local copy first. They are only
                // saved permanently when the user presses the Save Preferences button.
                _SectionCard(
                  title: l10n.homeRegion,
                  subtitle: l10n.homeRegionDescription,
                  child: DropdownButtonFormField<String>(
                    initialValue: preferences.homeRegion,
                    items: [
                      DropdownMenuItem(
                        value: 'Central',
                        child: Text(l10n.central),
                      ),
                      DropdownMenuItem(
                        value: 'North',
                        child: Text(l10n.north),
                      ),
                      DropdownMenuItem(
                        value: 'South',
                        child: Text(l10n.south),
                      ),
                      DropdownMenuItem(
                        value: 'East',
                        child: Text(l10n.east),
                      ),
                      DropdownMenuItem(
                        value: 'West',
                        child: Text(l10n.west),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }

                      setState(() {
                        _preferences = preferences.copyWith(
                          homeRegion: value,
                        );
                      });
                    },
                  ),
                ),
                const SizedBox(height: 14),
                _SectionCard(
                  title: l10n.outdoorActivity,
                  subtitle: l10n.outdoorActivityDescription,
                  child: RadioGroup<OutdoorActivityLevel>(
                    groupValue: preferences.outdoorActivityLevel,
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }

                      setState(() {
                        _preferences = preferences.copyWith(
                          outdoorActivityLevel: value,
                        );
                      });
                    },
                    child: Column(
                      children: OutdoorActivityLevel.values.map(
                        (level) {
                          return RadioListTile<OutdoorActivityLevel>(
                            contentPadding: EdgeInsets.zero,
                            value: level,
                            title: Text(
                              _activityLabel(
                                level,
                                l10n,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                _SectionCard(
                  title: l10n.usuallyOutdoors,
                  subtitle: l10n.usuallyOutdoorsDescription,
                  child: Column(
                    children: OutdoorTime.values.map(
                      (time) {
                        final selected =
                            preferences.outdoorTimes.contains(time);

                        return CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          value: selected,
                          title: Text(
                            _outdoorTimeLabel(
                              time,
                              l10n,
                            ),
                          ),
                          onChanged: (value) {
                            final updatedTimes = <OutdoorTime>{
                              ...preferences.outdoorTimes,
                            };

                            if (value == true) {
                              updatedTimes.add(time);
                            } else {
                              updatedTimes.remove(time);
                            }

                            setState(() {
                              _preferences = preferences.copyWith(
                                outdoorTimes: updatedTimes,
                              );
                            });
                          },
                        );
                      },
                    ).toList(),
                  ),
                ),
                const SizedBox(height: 14),
                _SectionCard(
                  title: l10n.preparednessReminders,
                  subtitle: l10n.preparednessRemindersDescription,
                  child: Column(
                    children: [
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        value: preferences.preparednessRemindersEnabled,
                        title: Text(
                          l10n.enableReminders,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _preferences = preferences.copyWith(
                              preparednessRemindersEnabled: value,
                            );
                          });
                        },
                      ),
                      if (preferences.preparednessRemindersEnabled) ...[
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            l10n.notificationSchedule,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        RadioGroup<NotificationScheduleMode>(
                          groupValue: preferences.notificationScheduleMode,
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }

                            setState(() {
                              _preferences = preferences.copyWith(
                                notificationScheduleMode: value,
                              );
                            });
                          },
                          child: Column(
                            children: [
                              RadioListTile<NotificationScheduleMode>(
                                contentPadding: EdgeInsets.zero,
                                value: NotificationScheduleMode.daytime,
                                title: Text(
                                  l10n.daytimeOnly,
                                ),
                                subtitle: Text(
                                  l10n.daytimeOnlyDescription,
                                ),
                              ),
                              RadioListTile<NotificationScheduleMode>(
                                contentPadding: EdgeInsets.zero,
                                value: NotificationScheduleMode.allDay,
                                title: Text(
                                  l10n.twentyFourHours,
                                ),
                                subtitle: Text(
                                  l10n.twentyFourHoursDescription,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                _SectionCard(
                  title: l10n.accessibility,
                  subtitle: l10n.accessibilityDescription,
                  child: Column(
                    children: [
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        secondary: const Icon(
                          Icons.text_fields_outlined,
                        ),
                        title: Text(
                          l10n.largerText,
                        ),
                        subtitle: Text(
                          l10n.largerTextDescription,
                        ),
                        value: preferences.largerTextEnabled,
                        onChanged: (value) {
                          setState(() {
                            _preferences = preferences.copyWith(
                              largerTextEnabled: value,
                            );
                          });
                        },
                      ),
                      const Divider(),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        secondary: const Icon(
                          Icons.touch_app_outlined,
                        ),
                        title: Text(
                          l10n.largerControls,
                        ),
                        subtitle: Text(
                          l10n.largerControlsDescription,
                        ),
                        value: preferences.largerControlsEnabled,
                        onChanged: (value) {
                          setState(() {
                            _preferences = preferences.copyWith(
                              largerControlsEnabled: value,
                            );
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                _SectionCard(
                  title: l10n.language,
                  subtitle: l10n.languageDescription,
                  child: DropdownButtonFormField<String>(
                    initialValue: preferences.languageCode,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.language_rounded,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 'en',
                        child: Text(
                          l10n.english,
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'zh',
                        child: Text(
                          l10n.simplifiedChinese,
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'ms',
                        child: Text(
                          l10n.malay,
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }

                      setState(() {
                        _preferences = preferences.copyWith(
                          languageCode: value,
                        );
                      });
                    },
                  ),
                ),
                const SizedBox(height: 14),
                _SectionCard(
                  title: l10n.appearance,
                  subtitle: l10n.appearanceDescription,
                  child: RadioGroup<ThemeMode>(
                    groupValue: themeMode,
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }

                      // Apply the appearance change straight away so the user can
                      // immediately see the selected theme.
                      ref
                          .read(
                            themeModeProvider.notifier,
                          )
                          .setThemeMode(value);
                    },
                    child: Column(
                      children: [
                        RadioListTile<ThemeMode>(
                          contentPadding: EdgeInsets.zero,
                          value: ThemeMode.system,
                          secondary: const Icon(
                            Icons.settings_suggest_outlined,
                          ),
                          title: Text(
                            l10n.systemDefault,
                          ),
                          subtitle: Text(
                            l10n.systemDefaultDescription,
                          ),
                        ),
                        RadioListTile<ThemeMode>(
                          contentPadding: EdgeInsets.zero,
                          value: ThemeMode.light,
                          secondary: const Icon(
                            Icons.light_mode_outlined,
                          ),
                          title: Text(
                            l10n.light,
                          ),
                          subtitle: Text(
                            l10n.lightDescription,
                          ),
                        ),
                        RadioListTile<ThemeMode>(
                          contentPadding: EdgeInsets.zero,
                          value: ThemeMode.dark,
                          secondary: const Icon(
                            Icons.dark_mode_outlined,
                          ),
                          title: Text(
                            l10n.dark,
                          ),
                          subtitle: Text(
                            l10n.darkDescription,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _isSaving ? null : _savePreferences,
                  icon: _isSaving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(
                          Icons.save_outlined,
                        ),
                  label: Text(
                    _isSaving ? l10n.saving : l10n.savePreferences,
                  ),
                ),
              ],
            ),
    );
  }

  /// Saves the updated preferences and refreshes the app state
  /// that depends on them.
  Future<void> _savePreferences() async {
    final preferences = _preferences;

    if (preferences == null || _isSaving) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      // Save the updated settings using the preferences service.
      final preferencesService = ref.read(userPreferencesServiceProvider);

      await preferencesService.savePreferences(
        preferences,
      );

      // Update the selected region used by the environmental data screens
      // so they follow the user's saved home region.
      final selectedRegion = regionFromPreference(
        preferences.homeRegion,
      );

      ref.read(selectedRegionProvider.notifier).state = selectedRegion;

      // If reminders were turned off, remove any preparedness
      // notifications that may already have been scheduled.
      if (!preferences.preparednessRemindersEnabled) {
        await NotificationService.instance.cancelWeatherPreparedness();
        await NotificationService.instance.cancelDailyTaskReminder();
      }

      // Reload the parts of SGReady that depend on these preferences.
      // This lets changes such as the user's routine affect the daily plan.
      ref.invalidate(userPreferencesProvider);
      ref.invalidate(missionContextProvider);
      ref.invalidate(dailyTasksProvider);

      if (!mounted) {
        return;
      }

      final l10n = AppLocalizations.of(context)!;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n.preferencesSaved,
          ),
        ),
      );
    } catch (_) {
      if (!mounted) {
        return;
      }

      final l10n = AppLocalizations.of(context)!;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n.unableToSavePreferences,
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  String _activityLabel(
    OutdoorActivityLevel level,
    AppLocalizations l10n,
  ) {
    switch (level) {
      case OutdoorActivityLevel.low:
        return l10n.low;
      case OutdoorActivityLevel.moderate:
        return l10n.moderate;
      case OutdoorActivityLevel.high:
        return l10n.high;
    }
  }

  String _outdoorTimeLabel(
    OutdoorTime time,
    AppLocalizations l10n,
  ) {
    switch (time) {
      case OutdoorTime.morning:
        return l10n.morning;
      case OutdoorTime.midday:
        return l10n.midday;
      case OutdoorTime.evening:
        return l10n.evening;
    }
  }
}

/// Reusable layout for grouping related preference settings.
class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}
