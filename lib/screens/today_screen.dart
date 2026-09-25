import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/app_localizations.dart';
import '../models/daily_task.dart';
import '../models/user_preferences.dart';
import '../providers/app_providers.dart';
import '../widget/daily_mission_card.dart';

/// Shows the user's personalised daily preparedness plan based on
/// current conditions, preferences and progress.
class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    final dailyTasksAsync = ref.watch(dailyTasksProvider);
    final progressAsync = ref.watch(userProgressProvider);
    final missionContextAsync = ref.watch(missionContextProvider);
    final preferencesAsync = ref.watch(userPreferencesProvider);

    final largerControlsEnabled =
        preferencesAsync.valueOrNull?.largerControlsEnabled ?? false;

    final progressService = ref.read(userProgressServiceProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(snapshotProvider);
        await ref.read(snapshotProvider.future);
      },
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          Text(
            l10n.todayTitle,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.todayDescription,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 16),
          preferencesAsync.when(
            data: (preferences) {
              return _PersonalisationCard(
                preferences: preferences,
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (error, stackTrace) => const SizedBox.shrink(),
          ),
          const SizedBox(height: 16),
          dailyTasksAsync.when(
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: CircularProgressIndicator(),
              ),
            ),
            error: (error, stackTrace) => _TodayErrorCard(
              message: l10n.todayPlanError,
            ),
            data: (tasks) {
              return progressAsync.when(
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (error, stackTrace) => _TodayErrorCard(
                  message: l10n.todayProgressError,
                ),
                data: (progress) {
                  return missionContextAsync.when(
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    error: (error, stackTrace) => _TodayErrorCard(
                      message: l10n.todayEnvironmentError,
                    ),
                    data: (missionContext) {
                      return DailyMissionCard(
                        tasks: tasks,
                        progress: progress,
                        missionContext: missionContext,
                        largerControlsEnabled: largerControlsEnabled,
                        onCheckboxChanged: (
                          DailyTask task,
                          bool isCompleted,
                        ) async {
                          await progressService.setDailyTaskCompleted(
                            task: task,
                            isCompleted: isCompleted,
                          );
                        },
                        onIncrementCounter: (DailyTask task) async {
                          await progressService.incrementDailyTask(
                            task: task,
                          );
                        },
                        onDecrementCounter: (DailyTask task) async {
                          await progressService.decrementDailyTask(
                            task: task,
                          );
                        },
                        onClaimReward: () async {
                          final rewardXp = tasks.fold<int>(
                            0,
                            (total, task) => total + task.points,
                          );

                          final confirmed = await _showClaimRewardDialog(
                            context,
                            rewardXp: rewardXp,
                          );

                          if (!confirmed || !context.mounted) {
                            return;
                          }

                          try {
                            final beforePoints = progress.points;

                            final updated =
                                await progressService.claimDailyTaskReward(
                              tasks: tasks,
                            );

                            if (!context.mounted) {
                              return;
                            }

                            final earned = updated.points - beforePoints;

                            await _showPlanCompleteDialog(
                              context,
                              earnedXp: earned,
                            );
                          } catch (_) {
                            if (!context.mounted) {
                              return;
                            }

                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(
                              SnackBar(
                                content: Text(
                                  l10n.completeTasksBeforeClaiming,
                                ),
                              ),
                            );
                          }
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Asks the user to confirm before claiming the XP earned
/// from completing today's preparedness plan.
Future<bool> _showClaimRewardDialog(
  BuildContext context, {
  required int rewardXp,
}) async {
  final scheme = Theme.of(context).colorScheme;

  final l10n = AppLocalizations.of(context)!;

  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        icon: Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: Colors.amber.withValues(
              alpha: 0.14,
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.stars_rounded,
            size: 30,
            color: Colors.amber.shade700,
          ),
        ),
        title: Text(
          l10n.claimTodayReward,
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.claimRewardDescription,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                    height: 1.4,
                  ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(
                  alpha: 0.12,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '+$rewardXp XP',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(
                dialogContext,
              ).pop(false);
            },
            child: Text(
              l10n.notYet,
            ),
          ),
          FilledButton.icon(
            onPressed: () {
              Navigator.of(
                dialogContext,
              ).pop(true);
            },
            icon: const Icon(
              Icons.stars_rounded,
              size: 18,
            ),
            label: Text(
              l10n.claimXp(rewardXp),
            ),
          ),
        ],
      );
    },
  );

  return confirmed ?? false;
}

/// Celebrates a completed daily plan and shows the XP
/// earned from the completed tasks.
Future<void> _showPlanCompleteDialog(
  BuildContext context, {
  required int earnedXp,
}) async {
  final scheme = Theme.of(context).colorScheme;

  final l10n = AppLocalizations.of(context)!;

  await showGeneralDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierLabel: l10n.planComplete,
    barrierColor: Colors.black.withValues(alpha: 0.55),
    transitionDuration: const Duration(milliseconds: 350),
    pageBuilder: (
      context,
      animation,
      secondaryAnimation,
    ) {
      return SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 340,
                padding: const EdgeInsets.fromLTRB(
                  24,
                  28,
                  24,
                  22,
                ),
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: scheme.outlineVariant,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 82,
                      height: 82,
                      decoration: BoxDecoration(
                        color: scheme.primary.withValues(
                          alpha: 0.10,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.shield_outlined,
                            size: 48,
                            color: scheme.primary,
                          ),
                          Positioned(
                            right: 12,
                            bottom: 12,
                            child: Container(
                              padding: const EdgeInsets.all(
                                2,
                              ),
                              decoration: BoxDecoration(
                                color: scheme.surface,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check_circle_rounded,
                                size: 24,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      l10n.planComplete,
                      textAlign: TextAlign.center,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l10n.planCompleteDescription,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: scheme.onSurfaceVariant,
                            height: 1.35,
                          ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 11,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber.withValues(
                          alpha: 0.14,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.stars_rounded,
                            size: 24,
                            color: Colors.amber.shade700,
                          ),
                          const SizedBox(width: 7),
                          Text(
                            '+$earnedXp XP',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          l10n.awesome,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (
      context,
      animation,
      secondaryAnimation,
      child,
    ) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutBack,
      );

      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween<double>(
            begin: 0.82,
            end: 1,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}

/// Displays an error when part of today's preparedness plan
/// cannot be loaded.
class _TodayErrorCard extends StatelessWidget {
  const _TodayErrorCard({
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.red.withValues(alpha: 0.12) : Colors.red.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              isDark ? Colors.red.withValues(alpha: 0.35) : Colors.red.shade100,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: isDark ? Colors.red.shade300 : Colors.red.shade600,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

/// Summarises how the user's routine and outdoor preferences
/// influence today's preparedness focus.
class _PersonalisationCard extends StatelessWidget {
  const _PersonalisationCard({
    required this.preferences,
  });

  final UserPreferences preferences;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    final highOutdoorActivity =
        preferences.outdoorActivityLevel == OutdoorActivityLevel.high;

    final usuallyOutdoorsAtMidday = preferences.outdoorTimes.contains(
      OutdoorTime.midday,
    );

    // Build a short summary of the user's usual outdoor routine.
    final routineItems = <_PersonalisationItem>[];

    if (highOutdoorActivity) {
      routineItems.add(
        _PersonalisationItem(
          icon: Icons.directions_run_outlined,
          label: l10n.youSpendMoreTimeOutdoors,
        ),
      );
    } else {
      routineItems.add(
        _PersonalisationItem(
          icon: Icons.directions_walk_outlined,
          label: l10n.moderatelyActiveOutdoors,
        ),
      );
    }

    if (usuallyOutdoorsAtMidday) {
      routineItems.add(
        _PersonalisationItem(
          icon: Icons.wb_sunny_outlined,
          label: l10n.usuallyOutdoorsAtMidday,
        ),
      );
    }

    // Use that routine to highlight the most relevant preparedness areas.
    final focusItems = <_PersonalisationItem>[];

    if (highOutdoorActivity) {
      focusItems.add(
        _PersonalisationItem(
          icon: Icons.air_rounded,
          label: l10n.todayFocusAirQuality,
        ),
      );

      focusItems.add(
        _PersonalisationItem(
          icon: Icons.thermostat_outlined,
          label: l10n.todayFocusHeatSafety,
        ),
      );
    }

    if (usuallyOutdoorsAtMidday) {
      focusItems.add(
        _PersonalisationItem(
          icon: Icons.wb_sunny_outlined,
          label: l10n.todayFocusHeatSafety,
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.secondaryContainer.withValues(
          alpha: 0.32,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: scheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.auto_awesome_rounded,
                  size: 20,
                  color: scheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n.personalisedForYou,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          _SectionLabel(
            label: l10n.yourRoutine,
            color: scheme.onSurfaceVariant,
          ),

          const SizedBox(height: 10),

          ...routineItems.map(
            (item) => _PersonalisationRow(
              item: item,
            ),
          ),

          // Only show a separate focus section when
          // preferences actually create a specific focus.
          if (focusItems.isNotEmpty) ...[
            const SizedBox(height: 14),
            Divider(
              color: scheme.outlineVariant.withValues(
                alpha: 0.6,
              ),
            ),
            const SizedBox(height: 12),
            _SectionLabel(
              label: l10n.todaysFocus,
              color: scheme.onSurfaceVariant,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: focusItems
                  .map(
                    (item) => _FocusChip(
                      item: item,
                    ),
                  )
                  .toList(),
            ),
          ] else ...[
            const SizedBox(height: 12),
            Text(
              l10n.todayPlanAdapts,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                    height: 1.35,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Stores the icon and text used for a personalised routine
/// or preparedness focus item.
class _PersonalisationItem {
  const _PersonalisationItem({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.1,
          ),
    );
  }
}

class _PersonalisationRow extends StatelessWidget {
  const _PersonalisationRow({
    required this.item,
  });

  final _PersonalisationItem item;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 9,
      ),
      child: Row(
        children: [
          Icon(
            item.icon,
            size: 20,
            color: scheme.primary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              item.label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FocusChip extends StatelessWidget {
  const _FocusChip({
    required this.item,
  });

  final _PersonalisationItem item;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(
          alpha: 0.09,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            item.icon,
            size: 17,
            color: scheme.primary,
          ),
          const SizedBox(width: 6),
          Text(
            item.label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
