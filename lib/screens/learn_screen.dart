import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/app_localizations.dart';
import '../models/gamification.dart';
import '../providers/app_providers.dart';
import 'cpr_aed_screen.dart';
import 'emergency_contacts_screen.dart';
import 'flash_flood_safety_screen.dart';

/// Brings together SGReady's preparedness learning features,
/// including the emergency kit, quizzes and scenario challenges.
class LearnScreen extends ConsumerStatefulWidget {
  const LearnScreen({super.key});

  @override
  ConsumerState<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends ConsumerState<LearnScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.learnTitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.learnDescription,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const EmergencyContactsScreen(),
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
                      color: Theme.of(context).colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      Icons.emergency_outlined,
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.learnEmergencyHelp,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          l10n.learnEmergencyHelpDescription,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
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

        const SizedBox(height: 10),

        // The Learn section is split into the emergency kit,
        // quizzes and scenarios.
        TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: const Icon(Icons.backpack_outlined),
              text: l10n.learnTabMyKit,
            ),
            Tab(
              icon: const Icon(Icons.quiz_outlined),
              text: l10n.learnTabQuizzes,
            ),
            Tab(
              icon: const Icon(Icons.sports_esports_outlined),
              text: l10n.learnTabScenarios,
            ),
          ],
        ),

        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              _ChecklistTab(),
              _QuizListTab(),
              _ScenarioListTab(),
            ],
          ),
        ),
      ],
    );
  }
}

/// Loads the user's saved progress before displaying their emergency kit.
class _ChecklistTab extends ConsumerWidget {
  const _ChecklistTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final progressState = ref.watch(userProgressProvider);

    return progressState.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => _ProgressErrorView(
        message: l10n.learnKitProgressError,
        onRetry: () {
          ref.invalidate(userProgressProvider);
        },
      ),
      data: (progress) {
        return _EmergencyKitContent(progress: progress);
      },
    );
  }
}

/// Builds the emergency kit and highlights items that are especially
/// relevant to the current environmental conditions.
class _EmergencyKitContent extends ConsumerWidget {
  const _EmergencyKitContent({
    required this.progress,
  });

  final UserProgress progress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final groupedItems = <String, List<ChecklistItem>>{};

    for (final item in defaultChecklist) {
      groupedItems.putIfAbsent(
        item.category,
        () => <ChecklistItem>[],
      );

      groupedItems[item.category]!.add(item);
    }

    final riskState = ref.watch(riskSummaryProvider);
    final recommendedCategories = <String>{};

    riskState.whenData((risk) {
      for (final recommendation in risk.recommendations) {
        switch (recommendation.category.toLowerCase()) {
          case 'haze':
            recommendedCategories.add('Haze');
            break;
          case 'uv':
            recommendedCategories.add('UV');
            recommendedCategories.add('Heat');
            break;
          case 'flood':
            recommendedCategories.add('Flood');
            break;
        }
      }
    });

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          l10n.learnMyEmergencyKit,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.learnEmergencyKitDescription,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 16),
        _KitOverviewCard(progress: progress),
        if (recommendedCategories.isNotEmpty) ...[
          const SizedBox(height: 16),
          _RecommendedTodayCard(
            categories: recommendedCategories,
            progress: progress,
          ),
        ],
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.learnQuickSkills,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Text(
              l10n.learnLearnInMinutes,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _QuickSkillCard(
                icon: Icons.favorite_outline_rounded,
                title: l10n.learnCprAed,
                subtitle: l10n.learnLifeSavingBasics,
                duration: l10n.learnVideoGuide,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const CprAedScreen(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _QuickSkillCard(
                icon: Icons.flood_outlined,
                title: l10n.learnFlashFloodSafety,
                subtitle: l10n.learnHeavyRainFloodSafety,
                duration: l10n.learnQuickGuide,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const FlashFloodSafetyScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          l10n.learnPreparednessCategories,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 10),
        ...groupedItems.entries.map(
          (entry) => _KitCategoryCard(
            category: entry.key,
            items: entry.value,
            progress: progress,
          ),
        ),
      ],
    );
  }
}

/// Reusable card that opens one of the short preparedness guides.
class _QuickSkillCard extends StatelessWidget {
  const _QuickSkillCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String duration;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: scheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: scheme.onPrimaryContainer,
                  size: 23,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                      height: 1.25,
                    ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.play_circle_outline_rounded,
                    size: 17,
                    color: scheme.primary,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    duration,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: scheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 20,
                    color: scheme.onSurfaceVariant,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Summarises how much of the user's emergency kit has been prepared.
class _KitOverviewCard extends StatelessWidget {
  const _KitOverviewCard({
    required this.progress,
  });

  final UserProgress progress;

  @override
  Widget build(BuildContext context) {
    final completed = progress.completedChecklistIds.length;
    final total = defaultChecklist.length;
    final percentage = progress.checklistCompletionPercentage;

    final l10n = AppLocalizations.of(context)!;
    final status = _kitStatus(percentage, l10n);
    final statusColor = _kitStatusColor(percentage);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.backpack_outlined,
                    color: statusColor,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.learnKitReady(percentage),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        status,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '$completed / $total',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: total == 0 ? 0 : completed / total,
              minHeight: 10,
              borderRadius: BorderRadius.circular(20),
              color: statusColor,
            ),
            const SizedBox(height: 10),
            Text(
              percentage == 100
                  ? l10n.learnKitComplete
                  : l10n.learnKitItemsRemaining(total - completed),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  static String _kitStatus(
    int percentage,
    AppLocalizations l10n,
  ) {
    if (percentage >= 100) {
      return l10n.learnKitStatusEmergencyReady;
    }

    if (percentage >= 75) {
      return l10n.learnKitStatusWellPrepared;
    }

    if (percentage >= 50) {
      return l10n.learnKitStatusGettingPrepared;
    }

    if (percentage >= 25) {
      return l10n.learnKitStatusBasicPreparation;
    }

    return l10n.learnKitStatusNeedsAttention;
  }

  static Color _kitStatusColor(int percentage) {
    if (percentage >= 75) return Colors.green;
    if (percentage >= 50) return Colors.teal;
    if (percentage >= 25) return Colors.orange;
    return Colors.red;
  }
}

/// Suggests unfinished kit items that are relevant to the
/// current environmental conditions.
class _RecommendedTodayCard extends StatelessWidget {
  const _RecommendedTodayCard({
    required this.categories,
    required this.progress,
  });

  final Set<String> categories;
  final UserProgress progress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final recommendedItems = defaultChecklist
        .where(
          (item) =>
              categories.contains(item.category) &&
              !progress.hasCompletedChecklistItem(item.id),
        )
        .take(3)
        .toList();

    if (recommendedItems.isEmpty) {
      return Card(
        color: Colors.green.withValues(alpha: 0.08),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(
                Icons.verified_outlined,
                color: Colors.green,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n.learnRecommendedComplete,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      color: Colors.orange.withValues(alpha: 0.08),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.auto_awesome,
                  color: Colors.orange,
                ),
                const SizedBox(width: 10),
                Text(
                  l10n.learnRecommendedToday,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              l10n.learnRecommendedBasedOnConditions,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            ...recommendedItems.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.star_outline,
                      size: 19,
                      color: Colors.orange,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _localizedItemTitle(item, l10n),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _localizedItemTitle(
    ChecklistItem item,
    AppLocalizations l10n,
  ) {
    switch (item.id) {
      case 'haze_mask':
        return l10n.kitHazeMaskTitle;
      case 'haze_meds':
        return l10n.kitHazeMedsTitle;
      case 'uv_sunscreen':
        return l10n.kitUvSunscreenTitle;
      case 'uv_hat':
        return l10n.kitUvHatTitle;
      case 'heat_water':
        return l10n.kitHeatWaterTitle;
      case 'flood_bag':
        return l10n.kitFloodBagTitle;
      case 'flood_alerts':
        return l10n.kitFloodAlertsTitle;
      case 'flood_route':
        return l10n.kitFloodRouteTitle;
      default:
        return item.label;
    }
  }
}

/// Groups emergency kit items by preparedness category and
/// lets the user update their completion status.
class _KitCategoryCard extends ConsumerWidget {
  const _KitCategoryCard({
    required this.category,
    required this.items,
    required this.progress,
  });

  final String category;
  final List<ChecklistItem> items;
  final UserProgress progress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final service = ref.read(userProgressServiceProvider);

    final completedCount = items
        .where(
          (item) => progress.hasCompletedChecklistItem(item.id),
        )
        .length;

    final percentage =
        items.isEmpty ? 0 : ((completedCount / items.length) * 100).round();

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        initiallyExpanded: completedCount < items.length,
        leading: CircleAvatar(
          backgroundColor: _categoryColor(category).withValues(alpha: 0.12),
          child: Icon(
            _categoryIcon(category),
            color: _categoryColor(category),
          ),
        ),
        title: Text(
          _localizedCategory(category, l10n),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          l10n.learnCategoryProgress(
            completedCount,
            items.length,
            percentage,
          ),
        ),
        trailing: percentage == 100
            ? const Icon(
                Icons.verified,
                color: Colors.green,
              )
            : null,
        children: [
          const Divider(height: 1),
          ...items.map((item) {
            final completed = progress.hasCompletedChecklistItem(item.id);

            return _KitItemTile(
              item: item,
              completed: completed,
              onChanged: (value) async {
                try {
                  await service.setChecklistItemCompleted(
                    item,
                    value,
                  );

                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(
                          value
                              ? l10n.learnItemAddedMessage(
                                  _localizedItemTitle(item, l10n),
                                )
                              : l10n.learnItemRemovedMessage(
                                  _localizedItemTitle(item, l10n),
                                ),
                        ),
                      ),
                    );
                } catch (_) {
                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        l10n.learnItemUpdateError,
                      ),
                    ),
                  );
                }
              },
            );
          }),
        ],
      ),
    );
  }

  String _localizedItemTitle(
    ChecklistItem item,
    AppLocalizations l10n,
  ) {
    switch (item.id) {
      case 'haze_mask':
        return l10n.kitHazeMaskTitle;
      case 'haze_meds':
        return l10n.kitHazeMedsTitle;
      case 'uv_sunscreen':
        return l10n.kitUvSunscreenTitle;
      case 'uv_hat':
        return l10n.kitUvHatTitle;
      case 'heat_water':
        return l10n.kitHeatWaterTitle;
      case 'flood_bag':
        return l10n.kitFloodBagTitle;
      case 'flood_alerts':
        return l10n.kitFloodAlertsTitle;
      case 'flood_route':
        return l10n.kitFloodRouteTitle;
      default:
        return item.label;
    }
  }

  String _localizedCategory(
    String category,
    AppLocalizations l10n,
  ) {
    switch (category.toLowerCase()) {
      case 'haze':
        return l10n.learnCategoryHaze;
      case 'uv':
        return l10n.learnCategoryUv;
      case 'heat':
        return l10n.learnCategoryHeat;
      case 'flood':
        return l10n.learnCategoryFlood;
      default:
        return category;
    }
  }

  IconData _categoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'haze':
        return Icons.masks_outlined;
      case 'uv':
        return Icons.wb_sunny_outlined;
      case 'heat':
        return Icons.thermostat_outlined;
      case 'flood':
        return Icons.water_drop_outlined;
      default:
        return Icons.backpack_outlined;
    }
  }

  Color _categoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'haze':
        return Colors.blueGrey;
      case 'uv':
        return Colors.orange;
      case 'heat':
        return Colors.red;
      case 'flood':
        return Colors.blue;
      default:
        return Colors.teal;
    }
  }
}

/// Displays an emergency kit item and lets the user add or remove it
/// from their preparedness checklist.
class _KitItemTile extends StatelessWidget {
  const _KitItemTile({
    required this.item,
    required this.completed,
    required this.onChanged,
  });

  final ChecklistItem item;
  final bool completed;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: completed
              ? Colors.green.withValues(alpha: 0.06)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Icon(
                completed ? Icons.check_circle : Icons.radio_button_unchecked,
                size: 22,
                color: completed ? Colors.green : scheme.outline,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _shortTitle(item.id, item.label, l10n),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    _shortDescription(item.id, l10n),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 9),
                  Row(
                    children: [
                      Icon(
                        completed ? Icons.check_rounded : Icons.stars_outlined,
                        size: 16,
                        color: completed ? Colors.green : Colors.orange,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          completed
                              ? l10n.learnAddedXp(item.points)
                              : l10n.learnXp(item.points),
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: completed
                                ? Colors.green
                                : scheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  tooltip: l10n.learnWhyThisMatters,
                  onPressed: () {
                    _showItemDetails(context, item);
                  },
                  icon: const Icon(
                    Icons.info_outline,
                    size: 21,
                  ),
                ),
                FilledButton.tonal(
                  onPressed: () {
                    onChanged(!completed);
                  },
                  style: FilledButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                  ),
                  child: Text(
                    completed ? l10n.learnAdded : l10n.learnAdd,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _shortTitle(
    String id,
    String fallback,
    AppLocalizations l10n,
  ) {
    switch (id) {
      case 'haze_mask':
        return l10n.kitHazeMaskTitle;

      case 'haze_meds':
        return l10n.kitHazeMedsTitle;

      case 'uv_sunscreen':
        return l10n.kitUvSunscreenTitle;

      case 'uv_hat':
        return l10n.kitUvHatTitle;

      case 'heat_water':
        return l10n.kitHeatWaterTitle;

      case 'flood_bag':
        return l10n.kitFloodBagTitle;

      case 'flood_alerts':
        return l10n.kitFloodAlertsTitle;

      case 'flood_route':
        return l10n.kitFloodRouteTitle;

      default:
        return fallback;
    }
  }

  String _shortDescription(
    String id,
    AppLocalizations l10n,
  ) {
    switch (id) {
      case 'haze_mask':
        return l10n.kitHazeMaskDescription;

      case 'haze_meds':
        return l10n.kitHazeMedsDescription;

      case 'uv_sunscreen':
        return l10n.kitUvSunscreenDescription;

      case 'uv_hat':
        return l10n.kitUvHatDescription;

      case 'heat_water':
        return l10n.kitHeatWaterDescription;

      case 'flood_bag':
        return l10n.kitFloodBagDescription;

      case 'flood_alerts':
        return l10n.kitFloodAlertsDescription;

      case 'flood_route':
        return l10n.kitFloodRouteDescription;

      default:
        return l10n.kitDefaultDescription;
    }
  }

  void _showItemDetails(
    BuildContext context,
    ChecklistItem item,
  ) {
    final l10n = AppLocalizations.of(context)!;

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            8,
            20,
            28,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _shortTitle(item.id, item.label, l10n),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Chip(
                label: Text(
                  _localizedCategory(item.category, l10n),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                _itemExplanation(item.id, l10n),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(
                    Icons.stars_outlined,
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n.learnEarnXpWhenAdded(item.points),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  String _itemExplanation(
    String id,
    AppLocalizations l10n,
  ) {
    switch (id) {
      case 'haze_mask':
        return l10n.kitHazeMaskExplanation;

      case 'haze_meds':
        return l10n.kitHazeMedsExplanation;

      case 'uv_sunscreen':
        return l10n.kitUvSunscreenExplanation;

      case 'uv_hat':
        return l10n.kitUvHatExplanation;

      case 'heat_water':
        return l10n.kitHeatWaterExplanation;

      case 'flood_bag':
        return l10n.kitFloodBagExplanation;

      case 'flood_alerts':
        return l10n.kitFloodAlertsExplanation;

      case 'flood_route':
        return l10n.kitFloodRouteExplanation;

      default:
        return l10n.kitDefaultExplanation;
    }
  }

  String _localizedCategory(
    String category,
    AppLocalizations l10n,
  ) {
    switch (category.toLowerCase()) {
      case 'haze':
        return l10n.learnCategoryHaze;
      case 'uv':
        return l10n.learnCategoryUv;
      case 'heat':
        return l10n.learnCategoryHeat;
      case 'flood':
        return l10n.learnCategoryFlood;
      default:
        return category;
    }
  }
}

/// Shows the available quiz topics and the user's overall
/// quiz completion progress.
class _QuizListTab extends ConsumerWidget {
  const _QuizListTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    final progress =
        ref.watch(userProgressProvider).valueOrNull ?? const UserProgress();

    final topics = defaultQuizzes
        .map((question) => question.topic)
        .toSet()
        .toList()
      ..sort();

    final totalQuestions = defaultQuizzes.length;

    final completedQuestions = defaultQuizzes
        .where(
          (question) => progress.hasCompletedQuiz(question.id),
        )
        .length;

    final quizProgress =
        totalQuestions == 0 ? 0.0 : completedQuestions / totalQuestions;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          l10n.learnKnowledgeQuizzes,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.learnKnowledgeQuizzesDescription,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.quiz_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        l10n.learnQuizProgress,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    Text(
                      '$completedQuestions / $totalQuestions',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  value: quizProgress,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(20),
                ),
                const SizedBox(height: 8),
                Text(
                  completedQuestions == totalQuestions
                      ? l10n.learnAllQuizQuestionsCompleted
                      : l10n.learnQuizQuestionsRemaining(
                          totalQuestions - completedQuestions,
                        ),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        ...topics.map((topic) {
          final questions = defaultQuizzes
              .where((question) => question.topic == topic)
              .toList();

          final completedQuestions = questions
              .where(
                (question) => progress.hasCompletedQuiz(question.id),
              )
              .length;

          final completed = completedQuestions == questions.length;

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: CircleAvatar(
                child: Icon(_topicIcon(topic)),
              ),
              title: Text(
                l10n.learnQuizTopicTitle(
                  _localizedQuizTopic(topic, l10n),
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                completed
                    ? l10n.learnCompleted
                    : l10n.learnQuizQuestionsCompleted(
                        completedQuestions,
                        questions.length,
                      ),
              ),
              trailing: Icon(
                completed ? Icons.check_circle : Icons.chevron_right,
                color: completed ? Colors.green : null,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => QuizScreen(
                      topic: topic,
                      questions: questions,
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }

  String _localizedQuizTopic(
    String topic,
    AppLocalizations l10n,
  ) {
    switch (topic.toLowerCase()) {
      case 'haze':
        return l10n.learnCategoryHaze;
      case 'uv':
        return l10n.learnCategoryUv;
      case 'heat':
        return l10n.learnCategoryHeat;
      case 'flood':
        return l10n.learnCategoryFlood;
      default:
        return topic;
    }
  }

  IconData _topicIcon(String topic) {
    switch (topic.toLowerCase()) {
      case 'haze':
        return Icons.masks_outlined;
      case 'uv':
        return Icons.wb_sunny_outlined;
      case 'flood':
        return Icons.water_drop_outlined;
      case 'heat':
        return Icons.thermostat_outlined;
      default:
        return Icons.school_outlined;
    }
  }
}

/// Shows the available preparedness scenarios and the user's
/// overall scenario completion progress.
class _ScenarioListTab extends ConsumerWidget {
  const _ScenarioListTab();

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final l10n = AppLocalizations.of(context)!;

    final progress =
        ref.watch(userProgressProvider).valueOrNull ?? const UserProgress();

    const scenarios = [
      _flashFloodScenario,
      _hazeScenario,
      _heatUvScenario,
    ];

    final completedCount = scenarios
        .where(
          (scenario) => progress.hasCompletedScenario(
            scenario.id,
          ),
        )
        .length;

    final scenarioProgress = completedCount / scenarios.length;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          l10n.scenarioChallenges,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.scenarioChallengesDescription,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.emoji_events_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        l10n.scenarioProgress,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    Text(
                      '$completedCount / ${scenarios.length}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  value: scenarioProgress,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(20),
                ),
                const SizedBox(height: 8),
                Text(
                  completedCount == scenarios.length
                      ? l10n.scenarioAllCompleted
                      : l10n.scenarioRemaining(
                          scenarios.length - completedCount,
                        ),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        ...scenarios.map(
          (scenario) {
            final completed = progress.hasCompletedScenario(
              scenario.id,
            );

            return Card(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                leading: CircleAvatar(
                  backgroundColor: scenario.color.withValues(
                    alpha: 0.12,
                  ),
                  child: Icon(
                    scenario.icon,
                    color: scenario.color,
                  ),
                ),
                title: Text(
                  _localizedScenarioTitle(
                    scenario,
                    l10n,
                  ),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 3),
                    Text(
                      _localizedScenarioDescription(
                        scenario,
                        l10n,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          completed
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          size: 16,
                          color: completed ? Colors.green : Colors.grey,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          completed
                              ? l10n.scenarioCompleted
                              : l10n.scenarioNotCompleted,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: completed
                                ? Colors.green
                                : Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          l10n.scenarioRewardXp(
                            scenario.rewardPoints,
                          ),
                          style: TextStyle(
                            fontSize: 12,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => _ScenarioScreen(
                        scenario: scenario,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

String _localizedScenarioTitle(
  _Scenario scenario,
  AppLocalizations l10n,
) {
  switch (scenario.id) {
    case 'flash_flood_route':
      return l10n.scenarioFlashFloodTitle;

    case 'haze_outdoor_activity':
      return l10n.scenarioHazeTitle;

    case 'heat_uv_outdoor_activity':
      return l10n.scenarioHeatUvTitle;

    default:
      return scenario.title;
  }
}

String _localizedScenarioDescription(
  _Scenario scenario,
  AppLocalizations l10n,
) {
  switch (scenario.id) {
    case 'flash_flood_route':
      return l10n.scenarioFlashFloodDescription;

    case 'haze_outdoor_activity':
      return l10n.scenarioHazeDescription;

    case 'heat_uv_outdoor_activity':
      return l10n.scenarioHeatUvDescription;

    default:
      return scenario.description;
  }
}

/// Stores the content and reward details for a preparedness scenario.
class _Scenario {
  const _Scenario({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.rewardPoints,
    required this.steps,
  });

  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final int rewardPoints;
  final List<_ScenarioStep> steps;
}

enum _ScenarioVisual {
  floodedRoad,
  alternativeRoute,
  heavyRainDriving,
  hazeOutdoor,
  hazeIndoor,
  hazeProtection,
  heatOutdoor,
  heatBreak,
  heatMonitoring,
}

/// Represents one decision point within a preparedness scenario.
class _ScenarioStep {
  const _ScenarioStep({
    required this.visual,
    required this.situation,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.correctFeedback,
    required this.incorrectFeedback,
  });

  final _ScenarioVisual visual;
  final String situation;
  final String question;
  final List<String> options;
  final int correctIndex;
  final String correctFeedback;
  final String incorrectFeedback;
}

/// Displays the illustration that matches the current scenario step.
class _ScenarioVisualCard extends StatelessWidget {
  const _ScenarioVisualCard({
    required this.visual,
  });

  final _ScenarioVisual visual;

  @override
  Widget build(BuildContext context) {
    switch (visual) {
      case _ScenarioVisual.floodedRoad:
      case _ScenarioVisual.alternativeRoute:
      case _ScenarioVisual.heavyRainDriving:
        return _buildScenarioImage(
          'assets/scenarios/flood.png',
          Colors.blue.shade50,
        );

      case _ScenarioVisual.hazeOutdoor:
      case _ScenarioVisual.hazeIndoor:
      case _ScenarioVisual.hazeProtection:
        return _buildScenarioImage(
          'assets/scenarios/haze.png',
          Colors.blueGrey.shade50,
        );

      case _ScenarioVisual.heatOutdoor:
      case _ScenarioVisual.heatBreak:
      case _ScenarioVisual.heatMonitoring:
        return _buildScenarioImage(
          'assets/scenarios/heat.png',
          Colors.orange.shade50,
        );
    }
  }

  Widget _buildScenarioImage(
    String assetPath,
    Color backgroundColor,
  ) {
    return Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: Transform.scale(
        scale: 1.45,
        child: Image.asset(
          assetPath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

const _flashFloodScenario = _Scenario(
  id: 'flash_flood_route',
  title: 'Flash Flood on Your Route',
  description: 'Make decisions while travelling during sudden flooding.',
  icon: Icons.flood_outlined,
  color: Colors.blue,
  rewardPoints: 25,
  steps: [
    _ScenarioStep(
      visual: _ScenarioVisual.floodedRoad,
      situation: 'You are travelling home during heavy rain. '
          'The road ahead is covered by flood water and '
          'you cannot tell how deep it is.',
      question: 'What should you do?',
      options: [
        'Drive through quickly before the water rises further.',
        'Turn around and use another route.',
        'Stop in the flooded section and wait.',
        'Open the windows and continue slowly.',
      ],
      correctIndex: 1,
      correctFeedback:
          'Good decision. Avoid entering flood water and use a safer alternative route.',
      incorrectFeedback:
          'Avoid entering flood water. It may be deeper or faster-moving than it appears.',
    ),
    _ScenarioStep(
      visual: _ScenarioVisual.alternativeRoute,
      situation: 'You turn around safely, but the rain is becoming heavier. '
          'You need to decide which route to take next.',
      question: 'What should you do before choosing another route?',
      options: [
        'Choose the shortest road without checking conditions.',
        'Check current flood information and plan a safer route.',
        'Return to the flooded road to see if conditions improved.',
        'Continue driving until you find an open road.',
      ],
      correctIndex: 1,
      correctFeedback:
          'Correct. Checking current conditions helps you avoid roads affected by flooding.',
      incorrectFeedback:
          'A safer approach is to check current flood information before choosing another route.',
    ),
    _ScenarioStep(
      visual: _ScenarioVisual.heavyRainDriving,
      situation:
          'Your alternative route is clear, but heavy rain is continuing '
          'and visibility is becoming poor.',
      question: 'What is the safest next action?',
      options: [
        'Speed up so you can get home sooner.',
        'Continue normally and ignore the reduced visibility.',
        'Slow down and continue cautiously while monitoring conditions.',
        'Use your phone while driving to check updates.',
      ],
      correctIndex: 2,
      correctFeedback:
          'Correct. Slowing down and staying alert is safer when visibility is reduced.',
      incorrectFeedback:
          'Poor visibility increases driving risk. Slow down, stay alert and monitor conditions safely.',
    ),
  ],
);

const _hazeScenario = _Scenario(
  id: 'haze_outdoor_activity',
  title: 'Haze During Outdoor Activity',
  description:
      'Make safe decisions when air quality worsens during outdoor plans.',
  icon: Icons.air,
  color: Colors.blueGrey,
  rewardPoints: 25,
  steps: [
    _ScenarioStep(
      visual: _ScenarioVisual.hazeOutdoor,
      situation: 'You planned to exercise outdoors this afternoon, '
          'but you notice that conditions look hazy.',
      question: 'What should you do before heading out?',
      options: [
        'Continue with your plans without checking anything.',
        'Check the latest PSI and air-quality conditions.',
        'Exercise harder so you can finish sooner.',
        'Assume the haze is harmless because visibility is still acceptable.',
      ],
      correctIndex: 1,
      correctFeedback:
          'Good decision. Checking current air-quality information helps you decide whether outdoor activity is appropriate.',
      incorrectFeedback:
          'Check current air-quality information before deciding whether to continue with prolonged outdoor activity.',
    ),
    _ScenarioStep(
      visual: _ScenarioVisual.hazeIndoor,
      situation: 'The PSI indicates poorer air quality than usual. '
          'You still want to stay active today.',
      question: 'What is the safer choice?',
      options: [
        'Continue a long, strenuous outdoor workout.',
        'Move your workout indoors or reduce prolonged outdoor exertion.',
        'Ignore the reading because you already planned the workout.',
        'Stay outdoors for longer to adapt to the haze.',
      ],
      correctIndex: 1,
      correctFeedback:
          'Correct. Adjusting your activity can reduce unnecessary exposure when air quality deteriorates.',
      incorrectFeedback:
          'Consider moving strenuous activity indoors or reducing prolonged outdoor exertion when conditions worsen.',
    ),
    _ScenarioStep(
      visual: _ScenarioVisual.hazeProtection,
      situation:
          'Later, you need to go outside and the hazy conditions are still present.',
      question: 'What should you do?',
      options: [
        'Monitor current conditions and follow the recommended precautions.',
        'Ignore further air-quality updates.',
        'Spend extra time outdoors because your workout was cancelled.',
        'Assume conditions cannot change during the day.',
      ],
      correctIndex: 0,
      correctFeedback:
          'Correct. Air quality can change, so continue monitoring conditions and follow appropriate precautions.',
      incorrectFeedback:
          'Continue checking current conditions because air quality can change throughout the day.',
    ),
  ],
);

const _heatUvScenario = _Scenario(
  id: 'heat_uv_outdoor_activity',
  title: 'Heat & UV During Outdoor Activity',
  description: 'Make safe decisions when heat and UV exposure are high.',
  icon: Icons.wb_sunny_outlined,
  color: Colors.orange,
  rewardPoints: 25,
  steps: [
    _ScenarioStep(
      visual: _ScenarioVisual.heatOutdoor,
      situation:
          'You are planning to spend several hours outdoors around midday. '
          'The weather is hot and the UV Index is high.',
      question: 'What should you do before heading out?',
      options: [
        'Go out immediately because sunny weather is safe.',
        'Apply sun protection, bring water and plan for shade.',
        'Avoid drinking water so you do not need breaks.',
        'Wear heavier clothing to get used to the heat.',
      ],
      correctIndex: 1,
      correctFeedback:
          'Good decision. Preparing sun protection, hydration and access to shade helps reduce heat and UV exposure.',
      incorrectFeedback:
          'Prepare for both heat and UV exposure before spending prolonged periods outdoors.',
    ),
    _ScenarioStep(
      visual: _ScenarioVisual.heatBreak,
      situation:
          'After spending some time outdoors, you are becoming very warm '
          'and have been exposed to direct sunlight for a while.',
      question: 'What is the safer next action?',
      options: [
        'Keep going without stopping.',
        'Drink water and take a break in a shaded or cooler area.',
        'Exercise harder so you can finish sooner.',
        'Stay in direct sunlight during your break.',
      ],
      correctIndex: 1,
      correctFeedback:
          'Correct. Hydration and cooling breaks can help reduce heat stress during prolonged outdoor activity.',
      incorrectFeedback:
          'Take regular hydration and cooling breaks rather than continuing prolonged activity in the heat.',
    ),
    _ScenarioStep(
      visual: _ScenarioVisual.heatMonitoring,
      situation:
          'You still have more outdoor activities planned later in the day.',
      question: 'How should you continue?',
      options: [
        'Ignore any changes because you already checked conditions earlier.',
        'Avoid water until you feel extremely thirsty.',
        'Continue monitoring conditions and adjust your plans if necessary.',
        'Stay outdoors continuously so your body adapts.',
      ],
      correctIndex: 2,
      correctFeedback:
          'Correct. Conditions can change, so continue monitoring them and adjust outdoor plans when necessary.',
      incorrectFeedback:
          'Continue monitoring heat and UV conditions and adjust your plans when necessary.',
    ),
  ],
);

/// Guides the user through the decision-making steps of a
/// preparedness scenario.
class _ScenarioScreen extends ConsumerStatefulWidget {
  const _ScenarioScreen({
    required this.scenario,
  });

  final _Scenario scenario;

  @override
  ConsumerState<_ScenarioScreen> createState() => _ScenarioScreenState();
}

class _ScenarioScreenState extends ConsumerState<_ScenarioScreen> {
  int? _selectedIndex;
  bool _answered = false;
  bool _isFinishing = false;

  int _currentStepIndex = 0;
  int _safeDecisions = 0;

  /// Confirms the user's selected answer so feedback can be shown.
  void _checkAnswer() {
    if (_selectedIndex == null) {
      return;
    }

    setState(() {
      _answered = true;
    });
  }

  /// Records whether the current decision was safe before moving
  /// to the next step in the scenario.
  void _nextStep() {
    if (!_answered || _selectedIndex == null) {
      return;
    }

    final currentStep = widget.scenario.steps[_currentStepIndex];

    if (_selectedIndex == currentStep.correctIndex) {
      _safeDecisions++;
    }

    setState(() {
      _currentStepIndex++;
      _selectedIndex = null;
      _answered = false;
    });
  }

  /// Completes the scenario, saves the reward and shows the user's
  /// final performance summary.
  Future<void> _finishScenario() async {
    final l10n = AppLocalizations.of(context)!;

    if (_isFinishing) {
      return;
    }

    setState(() {
      _isFinishing = true;
    });

    try {
      final scenarioId = widget.scenario.id;
      final rewardPoints = widget.scenario.rewardPoints;

      final currentStep = widget.scenario.steps[_currentStepIndex];

      if (_answered && _selectedIndex == currentStep.correctIndex) {
        _safeDecisions++;
      }

      final totalSteps = widget.scenario.steps.length;

      final starCount = _safeDecisions == totalSteps
          ? 3
          : _safeDecisions >= 2
              ? 2
              : 1;

      final service = ref.read(userProgressServiceProvider);

      final before = await service.getProgress();

      final alreadyCompleted = before.hasCompletedScenario(
        scenarioId,
      );

      final updated = await service.completeScenario(
        scenarioId: scenarioId,
        points: rewardPoints,
      );

      if (!mounted) {
        return;
      }

      final earned = updated.points - before.points;

      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return AlertDialog(
            icon: const Icon(
              Icons.emoji_events_outlined,
              size: 42,
              color: Colors.amber,
            ),
            title: Text(
              l10n.scenarioCompleteTitle,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.scenarioSafeDecisions(
                    _safeDecisions,
                    totalSteps,
                  ),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => Icon(
                      index < starCount
                          ? Icons.star_rounded
                          : Icons.star_border_rounded,
                      color: Colors.amber,
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  alreadyCompleted
                      ? l10n.scenarioPreviouslyCompleted
                      : l10n.scenarioXpEarned(earned),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              FilledButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                child: Text(
                  l10n.scenarioContinue,
                ),
              ),
            ],
          );
        },
      );

      if (!mounted) {
        return;
      }

      Navigator.of(context).pop();
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isFinishing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n.scenarioSaveError,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final currentStep = widget.scenario.steps[_currentStepIndex];

    final localizedSituation = _localizedScenarioSituation(
      currentStep,
      l10n,
    );

    final localizedQuestion = _localizedScenarioQuestion(
      currentStep,
      l10n,
    );

    final localizedOptions = _localizedScenarioOptions(
      currentStep,
      l10n,
    );

    final wasCorrect = _selectedIndex == currentStep.correctIndex;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _localizedScenarioTitle(
            widget.scenario,
            l10n,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _ScenarioVisualCard(
              visual: currentStep.visual,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(
                  alpha: 0.08,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.blue.withValues(
                    alpha: 0.25,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        widget.scenario.icon,
                        color: widget.scenario.color,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          l10n.scenarioSituationLabel,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    localizedSituation,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              localizedQuestion,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            ...List.generate(
              currentStep.options.length,
              (index) {
                final selected = _selectedIndex == index;

                final isCorrect = index == currentStep.correctIndex;

                Color? backgroundColor;
                Color? borderColor;
                IconData? trailingIcon;

                final isDark = Theme.of(context).brightness == Brightness.dark;

                // Once answered, highlight the correct choice and any
                // incorrect option selected by the user.
                if (_answered && isCorrect) {
                  backgroundColor = isDark
                      ? Colors.green.withValues(alpha: 0.16)
                      : Colors.green.shade50;

                  borderColor = Colors.green;

                  trailingIcon = Icons.check_circle;
                } else if (_answered && selected && !isCorrect) {
                  backgroundColor = isDark
                      ? Colors.red.withValues(alpha: 0.16)
                      : Colors.red.shade50;

                  borderColor = Colors.red;

                  trailingIcon = Icons.cancel;
                } else if (selected) {
                  backgroundColor =
                      Theme.of(context).colorScheme.primaryContainer;

                  borderColor = Theme.of(context).colorScheme.primary;
                }

                return Card(
                  margin: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  color: backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: BorderSide(
                      color: borderColor ?? Colors.transparent,
                      width: borderColor == null ? 0 : 1.5,
                    ),
                  ),
                  child: ListTile(
                    onTap: _answered
                        ? null
                        : () {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                    leading: CircleAvatar(
                      radius: 16,
                      child: Text(
                        String.fromCharCode(
                          65 + index,
                        ),
                      ),
                    ),
                    title: Text(
                      localizedOptions[index],
                    ),
                    trailing: trailingIcon == null
                        ? null
                        : Icon(
                            trailingIcon,
                            color: isCorrect ? Colors.green : Colors.red,
                          ),
                  ),
                );
              },
            ),
            if (_answered) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: (wasCorrect ? Colors.green : Colors.orange).withValues(
                    alpha: 0.08,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color:
                        (wasCorrect ? Colors.green : Colors.orange).withValues(
                      alpha: 0.35,
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      wasCorrect ? Icons.check_circle : Icons.info,
                      color: wasCorrect ? Colors.green : Colors.orange,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _localizedScenarioFeedback(
                          currentStep,
                          l10n,
                          isCorrect: wasCorrect,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 20),
            FilledButton(
              onPressed: _selectedIndex == null || _isFinishing
                  ? null
                  : _answered
                      ? (_currentStepIndex < widget.scenario.steps.length - 1
                          ? _nextStep
                          : _finishScenario)
                      : _checkAnswer,
              child: _isFinishing
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      _answered
                          ? (_currentStepIndex <
                                  widget.scenario.steps.length - 1
                              ? l10n.scenarioNextSituation
                              : l10n.scenarioFinishScenario)
                          : l10n.scenarioCheckDecision,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  String _localizedScenarioSituation(
    _ScenarioStep step,
    AppLocalizations l10n,
  ) {
    if (widget.scenario.id == 'flash_flood_route') {
      switch (_currentStepIndex) {
        case 0:
          return l10n.scenarioFloodStep1Situation;
        case 1:
          return l10n.scenarioFloodStep2Situation;
        case 2:
          return l10n.scenarioFloodStep3Situation;
      }
    }

    if (widget.scenario.id == 'haze_outdoor_activity') {
      switch (_currentStepIndex) {
        case 0:
          return l10n.scenarioHazeStep1Situation;
        case 1:
          return l10n.scenarioHazeStep2Situation;
        case 2:
          return l10n.scenarioHazeStep3Situation;
      }
    }

    if (widget.scenario.id == 'heat_uv_outdoor_activity') {
      switch (_currentStepIndex) {
        case 0:
          return l10n.scenarioHeatUvStep1Situation;
        case 1:
          return l10n.scenarioHeatUvStep2Situation;
        case 2:
          return l10n.scenarioHeatUvStep3Situation;
      }
    }

    return step.situation;
  }

  String _localizedScenarioQuestion(
    _ScenarioStep step,
    AppLocalizations l10n,
  ) {
    if (widget.scenario.id == 'flash_flood_route') {
      switch (_currentStepIndex) {
        case 0:
          return l10n.scenarioFloodStep1Question;
        case 1:
          return l10n.scenarioFloodStep2Question;
        case 2:
          return l10n.scenarioFloodStep3Question;
      }
    }

    if (widget.scenario.id == 'haze_outdoor_activity') {
      switch (_currentStepIndex) {
        case 0:
          return l10n.scenarioHazeStep1Question;
        case 1:
          return l10n.scenarioHazeStep2Question;
        case 2:
          return l10n.scenarioHazeStep3Question;
      }
    }

    if (widget.scenario.id == 'heat_uv_outdoor_activity') {
      switch (_currentStepIndex) {
        case 0:
          return l10n.scenarioHeatUvStep1Question;
        case 1:
          return l10n.scenarioHeatUvStep2Question;
        case 2:
          return l10n.scenarioHeatUvStep3Question;
      }
    }

    return step.question;
  }

  List<String> _localizedScenarioOptions(
    _ScenarioStep step,
    AppLocalizations l10n,
  ) {
    if (widget.scenario.id == 'flash_flood_route') {
      switch (_currentStepIndex) {
        case 0:
          return [
            l10n.scenarioFloodStep1Option1,
            l10n.scenarioFloodStep1Option2,
            l10n.scenarioFloodStep1Option3,
            l10n.scenarioFloodStep1Option4,
          ];

        case 1:
          return [
            l10n.scenarioFloodStep2Option1,
            l10n.scenarioFloodStep2Option2,
            l10n.scenarioFloodStep2Option3,
            l10n.scenarioFloodStep2Option4,
          ];

        case 2:
          return [
            l10n.scenarioFloodStep3Option1,
            l10n.scenarioFloodStep3Option2,
            l10n.scenarioFloodStep3Option3,
            l10n.scenarioFloodStep3Option4,
          ];
      }
    }

    if (widget.scenario.id == 'haze_outdoor_activity') {
      switch (_currentStepIndex) {
        case 0:
          return [
            l10n.scenarioHazeStep1Option1,
            l10n.scenarioHazeStep1Option2,
            l10n.scenarioHazeStep1Option3,
            l10n.scenarioHazeStep1Option4,
          ];

        case 1:
          return [
            l10n.scenarioHazeStep2Option1,
            l10n.scenarioHazeStep2Option2,
            l10n.scenarioHazeStep2Option3,
            l10n.scenarioHazeStep2Option4,
          ];

        case 2:
          return [
            l10n.scenarioHazeStep3Option1,
            l10n.scenarioHazeStep3Option2,
            l10n.scenarioHazeStep3Option3,
            l10n.scenarioHazeStep3Option4,
          ];
      }
    }

    if (widget.scenario.id == 'heat_uv_outdoor_activity') {
      switch (_currentStepIndex) {
        case 0:
          return [
            l10n.scenarioHeatUvStep1Option1,
            l10n.scenarioHeatUvStep1Option2,
            l10n.scenarioHeatUvStep1Option3,
            l10n.scenarioHeatUvStep1Option4,
          ];

        case 1:
          return [
            l10n.scenarioHeatUvStep2Option1,
            l10n.scenarioHeatUvStep2Option2,
            l10n.scenarioHeatUvStep2Option3,
            l10n.scenarioHeatUvStep2Option4,
          ];

        case 2:
          return [
            l10n.scenarioHeatUvStep3Option1,
            l10n.scenarioHeatUvStep3Option2,
            l10n.scenarioHeatUvStep3Option3,
            l10n.scenarioHeatUvStep3Option4,
          ];
      }
    }

    return step.options;
  }

  String _localizedScenarioFeedback(
    _ScenarioStep step,
    AppLocalizations l10n, {
    required bool isCorrect,
  }) {
    if (widget.scenario.id == 'flash_flood_route') {
      switch (_currentStepIndex) {
        case 0:
          return isCorrect
              ? l10n.scenarioFloodStep1CorrectFeedback
              : l10n.scenarioFloodStep1IncorrectFeedback;

        case 1:
          return isCorrect
              ? l10n.scenarioFloodStep2CorrectFeedback
              : l10n.scenarioFloodStep2IncorrectFeedback;

        case 2:
          return isCorrect
              ? l10n.scenarioFloodStep3CorrectFeedback
              : l10n.scenarioFloodStep3IncorrectFeedback;
      }
    }

    if (widget.scenario.id == 'haze_outdoor_activity') {
      switch (_currentStepIndex) {
        case 0:
          return isCorrect
              ? l10n.scenarioHazeStep1CorrectFeedback
              : l10n.scenarioHazeStep1IncorrectFeedback;

        case 1:
          return isCorrect
              ? l10n.scenarioHazeStep2CorrectFeedback
              : l10n.scenarioHazeStep2IncorrectFeedback;

        case 2:
          return isCorrect
              ? l10n.scenarioHazeStep3CorrectFeedback
              : l10n.scenarioHazeStep3IncorrectFeedback;
      }
    }

    if (widget.scenario.id == 'heat_uv_outdoor_activity') {
      switch (_currentStepIndex) {
        case 0:
          return isCorrect
              ? l10n.scenarioHeatUvStep1CorrectFeedback
              : l10n.scenarioHeatUvStep1IncorrectFeedback;

        case 1:
          return isCorrect
              ? l10n.scenarioHeatUvStep2CorrectFeedback
              : l10n.scenarioHeatUvStep2IncorrectFeedback;

        case 2:
          return isCorrect
              ? l10n.scenarioHeatUvStep3CorrectFeedback
              : l10n.scenarioHeatUvStep3IncorrectFeedback;
      }
    }

    return isCorrect ? step.correctFeedback : step.incorrectFeedback;
  }
}

/// Runs a quiz for the selected preparedness topic and tracks
/// the user's answers before saving their results.
class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({
    super.key,
    required this.topic,
    required this.questions,
  }) : assert(
          questions.length > 0,
          'QuizScreen requires at least one question.',
        );

  final String topic;
  final List<QuizQuestion> questions;

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  int _currentIndex = 0;
  int? _selectedIndex;
  int _score = 0;
  bool _answered = false;
  bool _isFinishing = false;

  final Map<String, bool> _questionResults = {};

  QuizQuestion get _currentQuestion {
    return widget.questions[_currentIndex];
  }

  bool get _isLastQuestion {
    return _currentIndex == widget.questions.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final question = _currentQuestion;

    final localizedOptions = _localizedQuizOptions(question, l10n);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.learnQuizTitle(
            _localizedQuizTopic(widget.topic, l10n),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LinearProgressIndicator(
                value: (_currentIndex + 1) / widget.questions.length,
                minHeight: 8,
                borderRadius: BorderRadius.circular(20),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.learnQuizQuestionProgress(
                  _currentIndex + 1,
                  widget.questions.length,
                ),
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 8),
              Text(
                _localizedQuizQuestion(question, l10n),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    ...List.generate(
                      localizedOptions.length,
                      (index) {
                        return _QuizOption(
                          text: localizedOptions[index],
                          index: index,
                          selectedIndex: _selectedIndex,
                          correctIndex: question.correctIndex,
                          answered: _answered,
                          onTap: () {
                            if (_answered) {
                              return;
                            }

                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                        );
                      },
                    ),
                    if (_answered) ...[
                      const SizedBox(height: 10),
                      _ExplanationCard(
                        wasCorrect: _selectedIndex == question.correctIndex,
                        explanation: _localizedQuizExplanation(
                          question,
                          l10n,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: _selectedIndex == null || _isFinishing
                    ? null
                    : _handlePrimaryAction,
                child: _isFinishing
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        !_answered
                            ? l10n.learnQuizCheckAnswer
                            : _isLastQuestion
                                ? l10n.learnQuizViewResults
                                : l10n.learnQuizNextQuestion,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Checks the current answer or moves the user to the next question.
  Future<void> _handlePrimaryAction() async {
    if (!_answered) {
      final correct = _currentQuestion.isCorrect(_selectedIndex!);

      setState(() {
        _answered = true;
        _questionResults[_currentQuestion.id] = correct;

        if (correct) {
          _score++;
        }
      });

      return;
    }

    if (_isLastQuestion) {
      await _finishQuiz();
      return;
    }

    setState(() {
      _currentIndex++;
      _selectedIndex = null;
      _answered = false;
    });
  }

  /// Saves the completed quiz, calculates the earned XP and
  /// shows the user's final result.
  Future<void> _finishQuiz() async {
    final l10n = AppLocalizations.of(context)!;

    setState(() {
      _isFinishing = true;
    });

    try {
      final service = ref.read(userProgressServiceProvider);

      final before = await service.getProgress();

      final maxQuizPoints = 50;

      final pointsPerQuestion =
          (maxQuizPoints / widget.questions.length).round();

      for (final question in widget.questions) {
        final wasCorrect = _questionResults[question.id] ?? false;

        await service.completeQuiz(
          question.id,
          wasCorrect ? 1 : 0,
          1,
          maxPoints: pointsPerQuestion,
        );
      }

      final after = await service.getProgress();

      final earned = after.points - before.points;

      final percentage = _score / widget.questions.length;

      final starCount = percentage == 1
          ? 3
          : percentage >= 0.6
              ? 2
              : 1;

      if (!mounted) {
        return;
      }

      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return AlertDialog(
            icon: Icon(
              _score == widget.questions.length
                  ? Icons.emoji_events
                  : Icons.school,
              color: _score == widget.questions.length
                  ? Colors.amber.shade700
                  : Colors.teal,
              size: 42,
            ),
            title: Text(
              l10n.learnQuizComplete,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.learnQuizScore(
                    _score,
                    widget.questions.length,
                  ),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => Icon(
                      index < starCount
                          ? Icons.star_rounded
                          : Icons.star_border_rounded,
                      color: Colors.amber,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _resultMessage(l10n),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  earned > 0
                      ? l10n.learnQuizXpEarned(earned)
                      : l10n.learnQuizNoAdditionalXp,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: earned > 0
                        ? Colors.green
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            actions: [
              FilledButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                child: Text(
                  l10n.learnQuizContinue,
                ),
              ),
            ],
          );
        },
      );

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (_) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n.learnQuizSaveError,
          ),
        ),
      );

      setState(() {
        _isFinishing = false;
      });
    }
  }

  String _resultMessage(
    AppLocalizations l10n,
  ) {
    final percentage = _score / widget.questions.length;

    if (percentage == 1) {
      return l10n.learnQuizResultExcellent;
    }

    if (percentage >= 0.5) {
      return l10n.learnQuizResultGood;
    }

    return l10n.learnQuizResultKeepLearning;
  }

  String _localizedQuizTopic(
    String topic,
    AppLocalizations l10n,
  ) {
    switch (topic.toLowerCase()) {
      case 'haze':
        return l10n.learnCategoryHaze;
      case 'uv':
        return l10n.learnCategoryUv;
      case 'heat':
        return l10n.learnCategoryHeat;
      case 'flood':
        return l10n.learnCategoryFlood;
      default:
        return topic;
    }
  }

  String _localizedQuizQuestion(
    QuizQuestion question,
    AppLocalizations l10n,
  ) {
    switch (question.id) {
      case 'haze_1':
        return l10n.quizHaze1Question;
      case 'haze_2':
        return l10n.quizHaze2Question;
      case 'haze_3':
        return l10n.quizHaze3Question;
      case 'haze_4':
        return l10n.quizHaze4Question;
      case 'haze_5':
        return l10n.quizHaze5Question;

      case 'uv_1':
        return l10n.quizUv1Question;
      case 'uv_2':
        return l10n.quizUv2Question;
      case 'uv_3':
        return l10n.quizUv3Question;
      case 'uv_4':
        return l10n.quizUv4Question;
      case 'uv_5':
        return l10n.quizUv5Question;

      case 'heat_1':
        return l10n.quizHeat1Question;
      case 'heat_2':
        return l10n.quizHeat2Question;
      case 'heat_3':
        return l10n.quizHeat3Question;
      case 'heat_4':
        return l10n.quizHeat4Question;
      case 'heat_5':
        return l10n.quizHeat5Question;

      case 'flood_1':
        return l10n.quizFlood1Question;
      case 'flood_2':
        return l10n.quizFlood2Question;
      case 'flood_3':
        return l10n.quizFlood3Question;
      case 'flood_4':
        return l10n.quizFlood4Question;
      case 'flood_5':
        return l10n.quizFlood5Question;

      default:
        return question.question;
    }
  }

  List<String> _localizedQuizOptions(
    QuizQuestion question,
    AppLocalizations l10n,
  ) {
    switch (question.id) {
      case 'haze_1':
        return [
          l10n.quizHaze1Option1,
          l10n.quizHaze1Option2,
          l10n.quizHaze1Option3,
          l10n.quizHaze1Option4,
        ];

      case 'haze_2':
        return [
          l10n.quizHaze2Option1,
          l10n.quizHaze2Option2,
          l10n.quizHaze2Option3,
          l10n.quizHaze2Option4,
        ];

      case 'haze_3':
        return [
          l10n.quizHaze3Option1,
          l10n.quizHaze3Option2,
          l10n.quizHaze3Option3,
          l10n.quizHaze3Option4,
        ];

      case 'haze_4':
        return [
          l10n.quizHaze4Option1,
          l10n.quizHaze4Option2,
          l10n.quizHaze4Option3,
          l10n.quizHaze4Option4,
        ];

      case 'haze_5':
        return [
          l10n.quizHaze5Option1,
          l10n.quizHaze5Option2,
          l10n.quizHaze5Option3,
          l10n.quizHaze5Option4,
        ];

      case 'uv_1':
        return [
          l10n.quizUv1Option1,
          l10n.quizUv1Option2,
          l10n.quizUv1Option3,
          l10n.quizUv1Option4,
        ];

      case 'uv_2':
        return [
          l10n.quizUv2Option1,
          l10n.quizUv2Option2,
          l10n.quizUv2Option3,
          l10n.quizUv2Option4,
        ];

      case 'uv_3':
        return [
          l10n.quizUv3Option1,
          l10n.quizUv3Option2,
          l10n.quizUv3Option3,
          l10n.quizUv3Option4,
        ];

      case 'uv_4':
        return [
          l10n.quizUv4Option1,
          l10n.quizUv4Option2,
          l10n.quizUv4Option3,
          l10n.quizUv4Option4,
        ];

      case 'uv_5':
        return [
          l10n.quizUv5Option1,
          l10n.quizUv5Option2,
          l10n.quizUv5Option3,
          l10n.quizUv5Option4,
        ];

      case 'heat_1':
        return [
          l10n.quizHeat1Option1,
          l10n.quizHeat1Option2,
          l10n.quizHeat1Option3,
          l10n.quizHeat1Option4,
        ];

      case 'heat_2':
        return [
          l10n.quizHeat2Option1,
          l10n.quizHeat2Option2,
          l10n.quizHeat2Option3,
          l10n.quizHeat2Option4,
        ];

      case 'heat_3':
        return [
          l10n.quizHeat3Option1,
          l10n.quizHeat3Option2,
          l10n.quizHeat3Option3,
          l10n.quizHeat3Option4,
        ];

      case 'heat_4':
        return [
          l10n.quizHeat4Option1,
          l10n.quizHeat4Option2,
          l10n.quizHeat4Option3,
          l10n.quizHeat4Option4,
        ];

      case 'heat_5':
        return [
          l10n.quizHeat5Option1,
          l10n.quizHeat5Option2,
          l10n.quizHeat5Option3,
          l10n.quizHeat5Option4,
        ];

      case 'flood_1':
        return [
          l10n.quizFlood1Option1,
          l10n.quizFlood1Option2,
          l10n.quizFlood1Option3,
          l10n.quizFlood1Option4,
        ];

      case 'flood_2':
        return [
          l10n.quizFlood2Option1,
          l10n.quizFlood2Option2,
          l10n.quizFlood2Option3,
          l10n.quizFlood2Option4,
        ];

      case 'flood_3':
        return [
          l10n.quizFlood3Option1,
          l10n.quizFlood3Option2,
          l10n.quizFlood3Option3,
          l10n.quizFlood3Option4,
        ];

      case 'flood_4':
        return [
          l10n.quizFlood4Option1,
          l10n.quizFlood4Option2,
          l10n.quizFlood4Option3,
          l10n.quizFlood4Option4,
        ];

      case 'flood_5':
        return [
          l10n.quizFlood5Option1,
          l10n.quizFlood5Option2,
          l10n.quizFlood5Option3,
          l10n.quizFlood5Option4,
        ];

      default:
        return question.options;
    }
  }

  String _localizedQuizExplanation(
    QuizQuestion question,
    AppLocalizations l10n,
  ) {
    switch (question.id) {
      case 'haze_1':
        return l10n.quizHaze1Explanation;
      case 'haze_2':
        return l10n.quizHaze2Explanation;
      case 'haze_3':
        return l10n.quizHaze3Explanation;
      case 'haze_4':
        return l10n.quizHaze4Explanation;
      case 'haze_5':
        return l10n.quizHaze5Explanation;

      case 'uv_1':
        return l10n.quizUv1Explanation;
      case 'uv_2':
        return l10n.quizUv2Explanation;
      case 'uv_3':
        return l10n.quizUv3Explanation;
      case 'uv_4':
        return l10n.quizUv4Explanation;
      case 'uv_5':
        return l10n.quizUv5Explanation;

      case 'heat_1':
        return l10n.quizHeat1Explanation;
      case 'heat_2':
        return l10n.quizHeat2Explanation;
      case 'heat_3':
        return l10n.quizHeat3Explanation;
      case 'heat_4':
        return l10n.quizHeat4Explanation;
      case 'heat_5':
        return l10n.quizHeat5Explanation;

      case 'flood_1':
        return l10n.quizFlood1Explanation;
      case 'flood_2':
        return l10n.quizFlood2Explanation;
      case 'flood_3':
        return l10n.quizFlood3Explanation;
      case 'flood_4':
        return l10n.quizFlood4Explanation;
      case 'flood_5':
        return l10n.quizFlood5Explanation;

      default:
        return question.explanation;
    }
  }
}

/// Displays one quiz answer and updates its appearance
/// after the user checks their response.
class _QuizOption extends StatelessWidget {
  const _QuizOption({
    required this.text,
    required this.index,
    required this.selectedIndex,
    required this.correctIndex,
    required this.answered,
    required this.onTap,
  });

  final String text;
  final int index;
  final int? selectedIndex;
  final int correctIndex;
  final bool answered;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final selected = selectedIndex == index;
    final correct = index == correctIndex;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color? backgroundColor;
    Color? borderColor;
    IconData? trailingIcon;
    Color? trailingColor;

    if (answered && correct) {
      backgroundColor =
          isDark ? Colors.green.withValues(alpha: 0.16) : Colors.green.shade50;

      borderColor = Colors.green;
      trailingIcon = Icons.check_circle;
      trailingColor = Colors.green;
    } else if (answered && selected && !correct) {
      backgroundColor =
          isDark ? Colors.red.withValues(alpha: 0.16) : Colors.red.shade50;

      borderColor = Colors.red;
      trailingIcon = Icons.cancel;
      trailingColor = Colors.red;
    } else if (selected) {
      backgroundColor = Theme.of(context).colorScheme.primaryContainer;

      borderColor = Theme.of(context).colorScheme.primary;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: borderColor ?? Colors.transparent,
          width: borderColor == null ? 0 : 1.5,
        ),
      ),
      child: ListTile(
        onTap: answered ? null : onTap,
        leading: CircleAvatar(
          radius: 16,
          child: Text(
            String.fromCharCode(65 + index),
          ),
        ),
        title: Text(text),
        trailing: trailingIcon == null
            ? null
            : Icon(
                trailingIcon,
                color: trailingColor,
              ),
      ),
    );
  }
}

/// Shows feedback explaining the result of a submitted quiz answer.
class _ExplanationCard extends StatelessWidget {
  const _ExplanationCard({
    required this.wasCorrect,
    required this.explanation,
  });

  final bool wasCorrect;
  final String explanation;

  @override
  Widget build(BuildContext context) {
    final color = wasCorrect ? Colors.green : Colors.orange;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: color.withValues(alpha: 0.35),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            wasCorrect ? Icons.check_circle : Icons.info,
            color: color,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(explanation),
          ),
        ],
      ),
    );
  }
}

/// Reusable error state for progress that could not be loaded,
/// with an option for the user to try again.
class _ProgressErrorView extends StatelessWidget {
  const _ProgressErrorView({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(
                l10n.learnTryAgain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
