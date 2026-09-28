// SGReady Final Year Project
// Developed by: Nicholas Ho
//
// The SGReady-specific profile screen, progress display, badge tracking,
// weekly activity and profile interactions in this file were developed by me.
//
// Flutter and Riverpod are external frameworks/packages used for the interface
// and state management. Firebase Authentication is used for account sign-out,
// while image_picker is an external package used to select profile photos.

import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../l10n/app_localizations.dart';
import '../models/gamification.dart' as gamification;
import '../providers/app_providers.dart';

import 'preferences_screen.dart';
import 'rewards_screen.dart';

/// Shows the user's preparedness progress, rewards, badges
/// and account settings.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressState = ref.watch(userProgressProvider);
    final l10n = AppLocalizations.of(context)!;

    return progressState.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            l10n.profileLoadProgressError,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      data: (progress) {
        return _ProfileContent(progress: progress);
      },
    );
  }
}

/// Shows which daily preparedness plans the user completed
/// over the past seven days.
class _WeeklyActivityCard extends StatelessWidget {
  const _WeeklyActivityCard({
    required this.progress,
    required this.completedPlanOn,
  });

  final gamification.UserProgress progress;
  final bool Function(DateTime date) completedPlanOn;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final today = DateTime.now();

    // Build the last seven calendar days, including today, so the user
    // can quickly see which daily preparedness plans they completed.
    final days = List.generate(
      7,
      (index) {
        final offset = 6 - index;

        return DateTime(
          today.year,
          today.month,
          today.day,
        ).subtract(
          Duration(days: offset),
        );
      },
    );

    final completedThisWeek = days.where(completedPlanOn).length;

    const weekdayLabels = [
      'M',
      'T',
      'W',
      'T',
      'F',
      'S',
      'S',
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l10n.profileWeeklyActivity,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Text(
                  l10n.profileWeeklyDaysCompleted(
                    completedThisWeek,
                  ),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              l10n.profileWeeklyActivityDescription,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                days.length,
                (index) {
                  final day = days[index];
                  final completed = completedPlanOn(day);

                  final weekday = weekdayLabels[day.weekday - 1];

                  return Column(
                    children: [
                      Text(
                        weekday,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 7),
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: completed
                              ? Colors.green.withValues(
                                  alpha: 0.12,
                                )
                              : Theme.of(context)
                                  .colorScheme
                                  .surfaceContainerHighest,
                          border: Border.all(
                            color: completed
                                ? Colors.green
                                : Colors.grey.withValues(
                                    alpha: 0.25,
                                  ),
                          ),
                        ),
                        child: Icon(
                          completed
                              ? Icons.check_rounded
                              : Icons.remove_rounded,
                          size: 18,
                          color:
                              completed ? Colors.green : Colors.grey.shade500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${day.day}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                const Icon(
                  Icons.local_fire_department_rounded,
                  size: 18,
                  color: Colors.orange,
                ),
                const SizedBox(width: 7),
                Text(
                  l10n.profileCurrentStreak(
                    progress.streakDays,
                  ),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Builds the main profile view using the user's saved
/// progress, rewards and account information.
class _ProfileContent extends ConsumerWidget {
  const _ProfileContent({
    required this.progress,
  });

  final gamification.UserProgress progress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final profilePhoto = ref.watch(profilePhotoProvider);

    // Each level uses 100 XP. These values work out how far the user
    // has progressed through their current level and what is left.
    final currentLevelStart = (progress.level - 1) * 100;
    final nextLevelTarget = progress.level * 100;
    final pointsIntoLevel = progress.points - currentLevelStart;
    final levelProgress = (pointsIntoLevel / 100).clamp(0.0, 1.0);
    final pointsRemaining = nextLevelTarget - progress.points;

    // Find the next badge that the user has not earned yet.
    final nextBadge = _nextBadgeProgress(progress);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          l10n.profileYourProgress,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.profileProgressDescription,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _ProfileAvatar(
                  photoBytes: profilePhoto,
                  level: progress.level,
                  onTap: () => _showProfilePhotoOptions(
                    context,
                    ref,
                    hasPhoto: profilePhoto != null,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.profileLevel(
                    progress.level,
                  ),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.profileXpStreak(
                    progress.points,
                    progress.streakDays,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withValues(alpha: 0.20),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              l10n.profileProgressToLevel(
                                progress.level + 1,
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          Text(
                            l10n.profileXpProgress(
                              pointsIntoLevel,
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: levelProgress,
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.profileXpToLevel(
                          pointsRemaining,
                          progress.level + 1,
                        ),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: progress.dailyTaskRewardClaimed
                        ? Colors.green.withValues(alpha: 0.10)
                        : Theme.of(context)
                            .colorScheme
                            .primaryContainer
                            .withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        progress.dailyTaskRewardClaimed
                            ? Icons.check_circle_rounded
                            : Icons.calendar_today_outlined,
                        color: progress.dailyTaskRewardClaimed
                            ? Colors.green
                            : Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              progress.dailyTaskRewardClaimed
                                  ? l10n.profileTodayPlanCompleted
                                  : l10n.profileTodayPlanNotCompleted,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              progress.dailyTaskRewardClaimed
                                  ? l10n.profileTodayPlanCompletedDescription
                                  : l10n
                                      .profileTodayPlanNotCompletedDescription,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        _RewardsPreviewCard(
          currentXp: progress.points,
        ),
        if (nextBadge != null) ...[
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .surfaceContainerHighest
                  .withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.profileNextBadge,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      _iconForBadge(
                        nextBadge.badge.iconName,
                      ),
                      color: Colors.amber.shade700,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _localizedBadgeTitle(
                          l10n,
                          nextBadge.badge.id,
                          nextBadge.badge.title,
                        ),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    Text(
                      '${nextBadge.current} / ${nextBadge.target}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  value: nextBadge.target == 0
                      ? 0
                      : nextBadge.current / nextBadge.target,
                  minHeight: 7,
                  borderRadius: BorderRadius.circular(20),
                ),
                const SizedBox(height: 8),
                Text(
                  _localizedBadgeDescription(
                    l10n,
                    nextBadge.badge.id,
                    nextBadge.badge.description,
                  ),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 16),
        _WeeklyActivityCard(
          progress: progress,
          completedPlanOn: (date) => _completedPlanOn(progress, date),
        ),
        const SizedBox(height: 16),
        _PreparednessScoreCard(progress: progress),
        const SizedBox(height: 16),
        Text(
          l10n.profileBadges,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        ...gamification.defaultBadges.map((badge) {
          final earned = progress.hasEarnedBadge(badge.id);
          final scheme = Theme.of(context).colorScheme;

          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            color: earned
                ? null
                : scheme.surfaceContainerHighest.withValues(alpha: 0.45),
            child: ListTile(
              leading: Icon(
                _iconForBadge(badge.iconName),
                color: earned ? Colors.amber.shade700 : scheme.onSurfaceVariant,
              ),
              title: Text(
                _localizedBadgeTitle(
                  l10n,
                  badge.id,
                  badge.title,
                ),
                style: TextStyle(
                  color: scheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                _localizedBadgeDescription(
                  l10n,
                  badge.id,
                  badge.description,
                ),
                style: TextStyle(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              trailing: earned
                  ? const Icon(
                      Icons.verified,
                      color: Colors.green,
                    )
                  : Text(
                      '${badge.pointsRequired} XP',
                      style: TextStyle(
                        color: scheme.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
            ),
          );
        }),
        const SizedBox(height: 16),
        Text(
          l10n.profileSettings,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 8),
        Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const PreferencesScreen(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    child: Icon(
                      Icons.tune_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.profilePreferences,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          l10n.profilePreferencesDescription,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.chevron_right_rounded,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          l10n.profileAccount,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 8),
        Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () async {
              // Ask for confirmation first so the user does not accidentally
              // sign out by tapping the account option.
              final shouldLogout = await showDialog<bool>(
                context: context,
                builder: (dialogContext) {
                  return AlertDialog(
                    title: Text(
                      l10n.profileLogoutDialogTitle,
                    ),
                    content: Text(
                      l10n.profileLogoutDialogDescription,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(
                            dialogContext,
                          ).pop(false);
                        },
                        child: Text(
                          l10n.profileCancel,
                        ),
                      ),
                      FilledButton(
                        onPressed: () {
                          Navigator.of(
                            dialogContext,
                          ).pop(true);
                        },
                        child: Text(
                          l10n.profileLogout,
                        ),
                      ),
                    ],
                  );
                },
              );

              if (shouldLogout != true) {
                return;
              }

              await FirebaseAuth.instance.signOut();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.errorContainer,
                    child: Icon(
                      Icons.logout_rounded,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.profileLogout,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          l10n.profileLogoutDescription,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.chevron_right_rounded,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  /// Lets the user choose a profile photo from their device
  /// and saves the selected image locally.
  Future<void> _pickProfilePhoto(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final l10n = AppLocalizations.of(context)!;

    try {
      final picker = ImagePicker();

      // image_picker opens the device gallery. The image is reduced in
      // size and quality so a very large photo does not need to be stored.
      final image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxWidth: 600,
        maxHeight: 600,
      );

      if (image == null) {
        return;
      }

      final bytes = await image.readAsBytes();

      await ref.read(profilePhotoProvider.notifier).savePhoto(bytes);
    } catch (_) {
      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n.profilePhotoSelectError,
          ),
        ),
      );
    }
  }

  /// Opens the profile photo options for choosing, changing
  /// or removing the current image.
  void _showProfilePhotoOptions(
    BuildContext context,
    WidgetRef ref, {
    required bool hasPhoto,
  }) {
    final l10n = AppLocalizations.of(context)!;

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 12,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.photo_library_outlined,
                  ),
                  title: Text(
                    hasPhoto
                        ? l10n.profileChangePhoto
                        : l10n.profileChoosePhoto,
                  ),
                  onTap: () {
                    Navigator.of(sheetContext).pop();

                    _pickProfilePhoto(
                      context,
                      ref,
                    );
                  },
                ),
                if (hasPhoto)
                  ListTile(
                    leading: const Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.red,
                    ),
                    title: Text(
                      l10n.profileRemovePhoto,
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    onTap: () async {
                      Navigator.of(sheetContext).pop();

                      await ref
                          .read(
                            profilePhotoProvider.notifier,
                          )
                          .removePhoto();
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Finds the next unearned badge and calculates the user's
  /// current progress towards unlocking it.
  ({
    gamification.Badge badge,
    int current,
    int target,
  })? _nextBadgeProgress(
    gamification.UserProgress progress,
  ) {

    // Go through the badges in order and skip the ones already earned.
    // The first badge left is used as the user's next badge target.
    for (final badge in gamification.defaultBadges) {
      if (progress.hasEarnedBadge(badge.id)) {
        continue;
      }

      // Different badges use different progress rules, such as completing
      // quizzes, checklist items or maintaining a streak.
      switch (badge.id) {
        case 'first_check':
          return (
            badge: badge,
            current: progress.completedChecklistIds.isEmpty ? 0 : 1,
            target: 1,
          );

        case 'haze_hero':
          final completed = [
            'haze_1',
            'haze_2',
          ]
              .where(
                progress.completedQuizIds.contains,
              )
              .length;

          return (
            badge: badge,
            current: completed,
            target: 2,
          );

        case 'uv_guardian':
          final completed = [
            'uv_1',
            'uv_2',
          ]
              .where(
                progress.completedQuizIds.contains,
              )
              .length;

          return (
            badge: badge,
            current: completed,
            target: 2,
          );

        case 'flood_ready':
          final floodItems = gamification.defaultChecklist
              .where(
                (item) => item.category == 'Flood',
              )
              .toList();

          final completed = floodItems
              .where(
                (item) => progress.completedChecklistIds.contains(item.id),
              )
              .length;

          return (
            badge: badge,
            current: completed,
            target: floodItems.length,
          );

        case 'streak_7':
          return (
            badge: badge,
            current: progress.streakDays.clamp(0, 7),
            target: 7,
          );
      }
    }

    return null;
  }

  // Check whether the user completed a daily plan on this exact
  // calendar date. The time of day is ignored for this comparison.
  bool _completedPlanOn(
    gamification.UserProgress progress,
    DateTime date,
  ) {
    return progress.completedDailyPlanDates.any(
      (completedDate) =>
          completedDate.year == date.year &&
          completedDate.month == date.month &&
          completedDate.day == date.day,
    );
  }

  String _localizedBadgeTitle(
    AppLocalizations l10n,
    String badgeId,
    String fallback,
  ) {
    switch (badgeId) {
      case 'first_check':
        return l10n.profileBadgeFirstCheckTitle;
      case 'haze_hero':
        return l10n.profileBadgeHazeHeroTitle;
      case 'uv_guardian':
        return l10n.profileBadgeUvGuardianTitle;
      case 'flood_ready':
        return l10n.profileBadgeFloodReadyTitle;
      case 'streak_7':
        return l10n.profileBadgeStreak7Title;
      default:
        return fallback;
    }
  }

  String _localizedBadgeDescription(
    AppLocalizations l10n,
    String badgeId,
    String fallback,
  ) {
    switch (badgeId) {
      case 'first_check':
        return l10n.profileBadgeFirstCheckDescription;
      case 'haze_hero':
        return l10n.profileBadgeHazeHeroDescription;
      case 'uv_guardian':
        return l10n.profileBadgeUvGuardianDescription;
      case 'flood_ready':
        return l10n.profileBadgeFloodReadyDescription;
      case 'streak_7':
        return l10n.profileBadgeStreak7Description;
      default:
        return fallback;
    }
  }

  IconData _iconForBadge(String name) {
    switch (name) {
      case 'masks':
        return Icons.masks;
      case 'wb_sunny':
        return Icons.wb_sunny;
      case 'water_drop':
        return Icons.water_drop;
      case 'local_fire_department':
        return Icons.local_fire_department;
      default:
        return Icons.check_circle;
    }
  }
}

/// Displays the user's profile photo with an option to update it.
class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({
    required this.photoBytes,
    required this.level,
    required this.onTap,
  });

  final Uint8List? photoBytes;
  final int level;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: scheme.primaryContainer,
              border: Border.all(
                color: scheme.primary.withValues(
                  alpha: 0.25,
                ),
                width: 2,
              ),
              image: photoBytes != null
                  ? DecorationImage(
                      image: MemoryImage(photoBytes!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: photoBytes == null
                ? Icon(
                    Icons.person_rounded,
                    size: 42,
                    color: scheme.primary,
                  )
                : null,
          ),
          Positioned(
            right: -2,
            bottom: -2,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: scheme.primary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: scheme.surface,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.camera_alt_rounded,
                size: 15,
                color: scheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Summarises the user's XP and progress towards their next reward.
class _RewardsPreviewCard extends StatelessWidget {
  const _RewardsPreviewCard({
    required this.currentXp,
  });

  final int currentXp;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    // Find the next prototype reward milestone based on the user's XP.
    // Null means all of the currently available rewards are unlocked.
    final nextRewardXp = currentXp < 500
        ? 500
        : currentXp < 1000
            ? 1000
            : currentXp < 1500
                ? 1500
                : null;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => RewardsScreen(
                currentXp: currentXp,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF1CC),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.redeem_rounded,
                  color: Color(0xFFE99B00),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.profileRewards,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      l10n.profileLifetimeXp(
                        currentXp,
                      ),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: scheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      nextRewardXp == null
                          ? l10n.profileAllRewardsUnlocked
                          : l10n.profileXpUntilNextReward(
                              nextRewardXp - currentXp,
                            ),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Breaks down the user's Preparedness Score across its
/// checklist, quiz, engagement and badge components.
class _PreparednessScoreCard extends StatelessWidget {
  const _PreparednessScoreCard({
    required this.progress,
  });

  final gamification.UserProgress progress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final score = progress.preparednessScore;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.shield_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l10n.profilePreparednessScore,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Text(
                  '$score%',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            LinearProgressIndicator(
              value: score / 100,
              minHeight: 10,
              borderRadius: BorderRadius.circular(20),
            ),
            const SizedBox(height: 18),
            _ScoreBreakdownRow(
              icon: Icons.checklist,
              label: l10n.profileScoreChecklist,
              value: progress.checklistCompletionPercentage,
              weight: '40%',
            ),
            const SizedBox(height: 10),
            _ScoreBreakdownRow(
              icon: Icons.quiz_outlined,
              label: l10n.profileScoreQuizzes,
              value: progress.quizCompletionPercentage,
              weight: '30%',
            ),
            const SizedBox(height: 10),
            _ScoreBreakdownRow(
              icon: Icons.local_fire_department_outlined,
              label: l10n.profileScoreEngagement,
              value: progress.engagementPercentage,
              weight: '20%',
            ),
            const SizedBox(height: 10),
            _ScoreBreakdownRow(
              icon: Icons.emoji_events_outlined,
              label: l10n.profileScoreBadges,
              value: progress.badgeCompletionPercentage,
              weight: '10%',
            ),
          ],
        ),
      ),
    );
  }
}

/// Reusable row for displaying one part of the Preparedness Score.
class _ScoreBreakdownRow extends StatelessWidget {
  const _ScoreBreakdownRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.weight,
  });

  final IconData icon;
  final String label;
  final int value;
  final String weight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.secondary,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(label),
        ),
        Text(
          '$value%',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '($weight)',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }
}
