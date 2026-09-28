// SGReady Final Year Project
// Developed by: Nicholas Ho
//
// The SGReady-specific hydration task card, progress handling and animated
// water bottle visual in this file were developed by me.
//
// Flutter is an external framework used to build the interface. The hydration
// guidance shown in this task is based on the health and preparedness sources
// referenced in the project report.

import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/daily_task.dart';

/// Displays and updates progress for the daily hydration task.
class HydrationTaskCard extends StatelessWidget {
  const HydrationTaskCard({
    super.key,
    required this.task,
    required this.currentProgress,
    required this.onIncrement,
    required this.onDecrement,
    required this.largerControlsEnabled,
  });

  final DailyTask task;
  final int currentProgress;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final bool largerControlsEnabled;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final target = task.target;

    // Keep the saved number of glasses within the target before
    // calculating how full the water bottle should appear.
    final safeProgress = currentProgress.clamp(0, target);

    final progress = target > 0 ? safeProgress / target : 0.0;

    final isComplete = safeProgress >= target;

    // Once the hydration target is reached, show a smaller completed-state
    // card while still allowing the user to undo the last glass.
    if (isComplete) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.green.withValues(
                    alpha: 0.10,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.water_drop_rounded,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.taskHydrationGoalHeatTitle,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      l10n.hydrationProgress(
                        safeProgress,
                        target,
                      ),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: onDecrement,
                    tooltip: l10n.undoLastGlass,
                    constraints: BoxConstraints(
                      minWidth: largerControlsEnabled ? 56 : 48,
                      minHeight: largerControlsEnabled ? 56 : 48,
                    ),
                    icon: Icon(
                      Icons.undo_rounded,
                      size: largerControlsEnabled ? 28 : 24,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(
                        alpha: 0.10,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.check_circle_rounded,
                          size: 17,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          l10n.complete,
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.water_drop_outlined,
                  size: 28,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l10n.taskHydrationGoalHeatTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              l10n.taskHydrationGoalHeatDescription,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 14),
            Center(
              child: _WaterBottle(
                progress: progress,
                isComplete: isComplete,
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                l10n.hydrationProgress(
                  safeProgress,
                  target,
                ),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton.outlined(
                  onPressed: safeProgress > 0 ? onDecrement : null,
                  icon: Icon(
                    Icons.remove,
                    size: largerControlsEnabled ? 28 : 24,
                  ),
                  constraints: BoxConstraints(
                    minWidth: largerControlsEnabled ? 56 : 48,
                    minHeight: largerControlsEnabled ? 56 : 48,
                  ),
                ),
                const SizedBox(width: 16),
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    minimumSize: Size(
                      0,
                      largerControlsEnabled ? 56 : 48,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: largerControlsEnabled ? 22 : 16,
                      vertical: largerControlsEnabled ? 16 : 12,
                    ),
                  ),
                  onPressed: isComplete ? null : onIncrement,
                  icon: Icon(
                    Icons.water_drop,
                    size: largerControlsEnabled ? 26 : 24,
                  ),
                  label: Text(
                    isComplete ? l10n.hydrationComplete : l10n.iDrankAGlass,
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

/// Displays an animated water bottle that fills up based on
/// the user's progress towards their hydration target.
class _WaterBottle extends StatelessWidget {
  const _WaterBottle({
    required this.progress,
    required this.isComplete,
  });

  final double progress;
  final bool isComplete;

  @override
  Widget build(BuildContext context) {
    final outlineColor = Theme.of(context).colorScheme.outline;

    const waterColor = Color(0xFF64BFE8);

    return SizedBox(
      width: 115,
      height: 200,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Bottle cap
          Positioned(
            top: 0,
            child: Container(
              width: 42,
              height: 24,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                border: Border.all(
                  color: outlineColor,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),

          // Small neck
          Positioned(
            top: 22,
            child: Container(
              width: 34,
              height: 20,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: outlineColor,
                    width: 3,
                  ),
                  right: BorderSide(
                    color: outlineColor,
                    width: 3,
                  ),
                ),
              ),
            ),
          ),

          // Bottle body
          Positioned(
            top: 38,
            child: Container(
              width: 90,
              height: 160,
              decoration: BoxDecoration(
                border: Border.all(
                  color: outlineColor,
                  width: 3,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                  bottomLeft: Radius.circular(22),
                  bottomRight: Radius.circular(22),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none,
                  children: [
                    // Bottle background
                    Container(
                      color:
                          Theme.of(context).colorScheme.surfaceContainerLowest,
                    ),

                    // Increase the water height as the user records more glasses.
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 650),
                        curve: Curves.easeOutCubic,
                        width: double.infinity,
                        height: 159 * progress,
                        decoration: const BoxDecoration(
                          color: waterColor,
                        ),
                      ),
                    ),

                    // Bottle highlight
                    Positioned(
                      left: 13,
                      top: 25,
                      bottom: 25,
                      child: Container(
                        width: 5,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(
                            alpha: 0.35,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    // Completion icon
                    if (isComplete)
                      const Center(
                        child: Icon(
                          Icons.check_circle_rounded,
                          size: 46,
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
