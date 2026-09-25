import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

/// Shows the user's XP milestones and the prototype rewards
/// they can unlock as their preparedness progress increases.
class RewardsScreen extends StatelessWidget {
  const RewardsScreen({
    super.key,
    required this.currentXp,
  });

  final int currentXp;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final rewards = [
      _RewardItem(
        title: l10n.rewardTreatVoucherTitle,
        description: l10n.rewardTreatVoucherDescription,
        xpRequired: 500,
        icon: Icons.icecream_outlined,
      ),
      _RewardItem(
        title: l10n.rewardLifestyleVoucherTitle,
        description: l10n.rewardLifestyleVoucherDescription,
        xpRequired: 1000,
        icon: Icons.card_giftcard_rounded,
      ),
      _RewardItem(
        title: l10n.rewardPreparednessPackTitle,
        description: l10n.rewardPreparednessPackDescription,
        xpRequired: 1500,
        icon: Icons.backpack_outlined,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.rewardsScreenTitle,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          16,
          8,
          16,
          28,
        ),
        children: [
          _XpOverviewCard(
            currentXp: currentXp,
          ),
          const SizedBox(height: 20),
          Text(
            l10n.rewardsMilestones,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.rewardsMilestonesDescription,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.35,
                ),
          ),
          const SizedBox(height: 14),
          ...rewards.map(
            (reward) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _RewardCard(
                reward: reward,
                currentXp: currentXp,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const _PrototypeNotice(),
        ],
      ),
    );
  }
}

/// Summarises the user's lifetime XP, current tier
/// and progress towards the next tier.
class _XpOverviewCard extends StatelessWidget {
  const _XpOverviewCard({
    required this.currentXp,
  });

  final int currentXp;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    final tier = _tierForXp(currentXp);
    final nextTier = _nextTierForXp(currentXp);

    final localizedTier = _localizedTierName(l10n, tier);

    final localizedNextTier = nextTier == null
        ? null
        : _localizedTierName(
            l10n,
            nextTier.name,
          );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: scheme.primaryContainer.withValues(alpha: 0.38),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: scheme.primary,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.stars_rounded,
                  color: scheme.onPrimary,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.rewardsLifetimeXpTitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.rewardsXpValue(
                        currentXp,
                      ),
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: scheme.primary,
                              ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: scheme.surface.withValues(alpha: 0.72),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.workspace_premium_outlined,
                  color: scheme.primary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.rewardsTier(
                          localizedTier,
                        ),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      Text(
                        nextTier == null
                            ? l10n.rewardsHighestTierReached
                            : l10n.rewardsXpToTier(
                                nextTier.xp - currentXp,
                                localizedNextTier!,
                              ),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.rewardsEarnXpDescription,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                  height: 1.35,
                ),
          ),
        ],
      ),
    );
  }

  static String _localizedTierName(
    AppLocalizations l10n,
    String tier,
  ) {
    switch (tier) {
      case 'Prepared':
        return l10n.rewardsTierPrepared;
      case 'Ready':
        return l10n.rewardsTierReady;
      case 'Resilient':
        return l10n.rewardsTierResilient;
      case 'Starter':
      default:
        return l10n.rewardsTierStarter;
    }
  }

  static String _tierForXp(int xp) {
    if (xp >= 1500) return 'Resilient';
    if (xp >= 1000) return 'Ready';
    if (xp >= 500) return 'Prepared';
    return 'Starter';
  }

  static ({String name, int xp})? _nextTierForXp(int xp) {
    if (xp < 500) {
      return (name: 'Prepared', xp: 500);
    }

    if (xp < 1000) {
      return (name: 'Ready', xp: 1000);
    }

    if (xp < 1500) {
      return (name: 'Resilient', xp: 1500);
    }

    return null;
  }
}

/// Stores the information needed to display a reward milestone.
class _RewardItem {
  const _RewardItem({
    required this.title,
    required this.description,
    required this.xpRequired,
    required this.icon,
  });

  final String title;
  final String description;
  final int xpRequired;
  final IconData icon;
}

/// Shows a reward milestone and the user's progress
/// towards unlocking it.
class _RewardCard extends StatelessWidget {
  const _RewardCard({
    required this.reward,
    required this.currentXp,
  });

  final _RewardItem reward;
  final int currentXp;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    final unlocked = currentXp >= reward.xpRequired;

    final remaining =
        (reward.xpRequired - currentXp).clamp(0, reward.xpRequired);

    final progress = (currentXp / reward.xpRequired).clamp(0.0, 1.0);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: unlocked
                        ? scheme.primaryContainer
                        : scheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    reward.icon,
                    color: unlocked ? scheme.primary : scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reward.title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${reward.xpRequired} XP',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: scheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  unlocked
                      ? Icons.lock_open_rounded
                      : Icons.lock_outline_rounded,
                  color: unlocked ? scheme.primary : scheme.onSurfaceVariant,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              reward.description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                    height: 1.35,
                  ),
            ),
            const SizedBox(height: 14),
            LinearProgressIndicator(
              value: progress,
              minHeight: 7,
              borderRadius: BorderRadius.circular(20),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    unlocked
                        ? l10n.rewardUnlocked
                        : l10n.rewardXpMoreToUnlock(
                            remaining,
                          ),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                if (unlocked)
                  TextButton(
                    onPressed: () {
                      _showPrototypeDialog(
                        context,
                        reward,
                      );
                    },
                    child: Text(
                      l10n.rewardView,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Explains that unlocked rewards are part of the current
  /// prototype and cannot be redeemed yet.
  void _showPrototypeDialog(
    BuildContext context,
    _RewardItem reward,
  ) {
    final l10n = AppLocalizations.of(context)!;

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: const Icon(
            Icons.redeem_rounded,
          ),
          title: Text(reward.title),
          content: Text(
            l10n.rewardPrototypeDialogDescription,
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                l10n.rewardGotIt,
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Reminds users that the reward system is currently
/// included for demonstration purposes only.
class _PrototypeNotice extends StatelessWidget {
  const _PrototypeNotice();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    const warningColor = Color(0xFFF4B942);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? warningColor.withValues(alpha: 0.10)
            : const Color(0xFFFFF7E8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: warningColor.withValues(
            alpha: isDark ? 0.40 : 0.35,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            color: warningColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.prototypeRewardsTitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: isDark ? warningColor : scheme.onSurface,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.prototypeRewardsDescription,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                        height: 1.4,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
