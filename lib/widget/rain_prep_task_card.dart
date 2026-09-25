import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/daily_task.dart';

/// Displays and updates progress for the daily rain-preparation task.
class RainPrepTaskCard extends StatelessWidget {
  const RainPrepTaskCard({
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
    // This task contains four fixed preparation steps.
    const target = 4;

    final safeProgress = currentProgress.clamp(0, target);

    final isComplete = safeProgress >= target;

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
                  Icons.umbrella_rounded,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.taskRainPreparationTitle,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      l10n.rainStepsReady(
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
              const SizedBox(width: 8),
              IconButton(
                onPressed: onDecrement,
                tooltip: l10n.undoLastStep,
                constraints: BoxConstraints(
                  minWidth: largerControlsEnabled ? 56 : 48,
                  minHeight: largerControlsEnabled ? 56 : 48,
                ),
                icon: Icon(
                  Icons.undo_rounded,
                  size: largerControlsEnabled ? 28 : 24,
                ),
              ),
              const SizedBox(width: 2),
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
        ),
      );
    }

    // Rain-preparation actions shown to the user in order.
    final steps = [
      (
        icon: Icons.umbrella_outlined,
        label: l10n.packUmbrella,
      ),
      (
        icon: Icons.warning_amber_rounded,
        label: l10n.checkFloodAlerts,
      ),
      (
        icon: Icons.alt_route_rounded,
        label: l10n.reviewYourRoute,
      ),
      (
        icon: Icons.battery_charging_full_rounded,
        label: l10n.chargePowerBank,
      ),
    ];

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
                    l10n.taskRainPreparationTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              l10n.taskRainPreparationDescription,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            ...List.generate(
              steps.length,
              (index) {
                // Steps before the current progress are marked as completed.
                final completed = index < safeProgress;

                final step = steps[index];

                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: completed
                          ? Colors.green.withValues(
                              alpha: 0.08,
                            )
                          : Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest
                              .withValues(
                                alpha: 0.35,
                              ),
                      border: Border.all(
                        color: completed
                            ? Colors.green.withValues(
                                alpha: 0.25,
                              )
                            : Theme.of(context)
                                .colorScheme
                                .outlineVariant
                                .withValues(
                                  alpha: 0.65,
                                ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          completed ? Icons.check_circle : step.icon,
                          color: completed ? Colors.green : Colors.blueGrey,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            step.label,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              decoration:
                                  completed ? TextDecoration.lineThrough : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton.outlined(
                  onPressed: safeProgress > 0 ? onDecrement : null,
                  tooltip: l10n.undo,
                  constraints: BoxConstraints(
                    minWidth: largerControlsEnabled ? 56 : 48,
                    minHeight: largerControlsEnabled ? 56 : 48,
                  ),
                  icon: Icon(
                    Icons.undo_rounded,
                    size: largerControlsEnabled ? 28 : 24,
                  ),
                ),
                const SizedBox(width: 12),
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
                    isComplete ? Icons.check : Icons.checklist_rounded,
                    size: largerControlsEnabled ? 26 : 24,
                  ),
                  label: Text(
                    isComplete ? l10n.rainPrepComplete : l10n.completeNextStep,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                l10n.rainReadyProgress(
                  safeProgress,
                  target,
                ),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
