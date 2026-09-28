// SGReady Final Year Project
// Developed by: Nicholas Ho
//
// The SGReady-specific flash flood safety screen, layout and reusable UI
// components in this file were developed by me. Flutter is an external
// framework used to build the interface.
//
// The flash flood safety guidance displayed on this screen is based on
// the Singapore safety and preparedness sources referenced in the project report.
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

/// Gives users quick safety guidance on what to do and avoid
/// when they encounter a flash flood.
class FlashFloodSafetyScreen extends StatelessWidget {
  const FlashFloodSafetyScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.floodSafetyTitle,
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: scheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      color: scheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.flood_rounded,
                      size: 38,
                      color: scheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    l10n.floodSafetyHeroTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.floodSafetyHeroDescription,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              l10n.floodSafetyEncounterTitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 12),

            // Separate the guidance into actions the user should and should not do
            // when they encounter a flash flood.
            _FloodActionCard(
              icon: Icons.turn_left_rounded,
              title: l10n.floodSafetyTurnBackTitle,
              description: l10n.floodSafetyTurnBackDescription,
              isDo: true,
            ),

            const SizedBox(height: 10),

            _FloodActionCard(
              icon: Icons.terrain_rounded,
              title: l10n.floodSafetyHigherGroundTitle,
              description: l10n.floodSafetyHigherGroundDescription,
              isDo: true,
            ),

            const SizedBox(height: 10),

            _FloodActionCard(
              icon: Icons.directions_walk_rounded,
              title: l10n.floodSafetyAvoidMovingWaterTitle,
              description: l10n.floodSafetyAvoidMovingWaterDescription,
              isDo: false,
            ),

            const SizedBox(height: 10),

            _FloodActionCard(
              icon: Icons.directions_car_outlined,
              title: l10n.floodSafetyAvoidDrivingTitle,
              description: l10n.floodSafetyAvoidDrivingDescription,
              isDo: false,
            ),

            const SizedBox(height: 24),

            // Reminds users to check current conditions before travelling.
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.notifications_active_outlined,
                    color: scheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.floodSafetyBeforeTravellingTitle,
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.floodSafetyBeforeTravellingDescription,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: scheme.onSurfaceVariant,
                                    height: 1.4,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Shows the source of the safety guidance.
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.verified_outlined,
                  size: 18,
                  color: scheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.floodSafetySource,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

/// Reusable card for showing recommended and unsafe actions
/// during a flash flood.
class _FloodActionCard extends StatelessWidget {
  const _FloodActionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.isDo,
  });

  final IconData icon;
  final String title;
  final String description;

  // Used to decide whether the card is shown as a recommended
  // "Do" action or an unsafe "Don't" action.
  final bool isDo;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    final actionColor = isDo ? Colors.green : scheme.error;

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: actionColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                icon,
                color: actionColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: actionColor.withValues(
                            alpha: 0.12,
                          ),
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                        child: Text(
                          isDo ? l10n.floodSafetyDo : l10n.floodSafetyDont,
                          style: TextStyle(
                            color: actionColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                          height: 1.35,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
