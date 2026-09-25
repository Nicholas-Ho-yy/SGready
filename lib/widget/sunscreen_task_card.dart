import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../l10n/app_localizations.dart';
import '../models/daily_task.dart';

/// Displays and updates progress for the daily sunscreen task.
class SunscreenTaskCard extends StatelessWidget {
  const SunscreenTaskCard({
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

    final localizedDescription = switch (task.contentKey) {
      'moderate' => l10n.taskApplySunscreenModerateDescription,
      'high' => l10n.taskApplySunscreenHighDescription,
      'veryHigh' => l10n.taskApplySunscreenVeryHighDescription,
      _ => l10n.taskApplySunscreenDescription,
    };

    // Sunscreen coverage is completed across four application steps.
    const target = 4;

    final safeProgress = currentProgress.clamp(0, target);

    final progress = safeProgress / target;

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
                  color: Colors.orange.withValues(
                    alpha: 0.10,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.wb_sunny_rounded,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.taskApplySunscreenTitle,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      l10n.sunscreenApplied,
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

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.wb_sunny_outlined,
                  size: 28,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l10n.taskApplySunscreenTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              localizedDescription,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Center(
              child: _CoverageVisual(
                progress: progress,
                isComplete: isComplete,
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                isComplete
                    ? l10n.sunscreenApplied
                    : l10n.coveragePercent(
                        (progress * 100).round(),
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
                    isComplete ? Icons.check : Icons.wb_sunny_outlined,
                    size: largerControlsEnabled ? 26 : 24,
                  ),
                  label: Text(
                    isComplete
                        ? l10n.sunscreenApplied
                        : l10n.applySunscreenButton,
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

class _CoverageVisual extends StatelessWidget {
  const _CoverageVisual({
    required this.progress,
    required this.isComplete,
  });

  final double progress;
  final bool isComplete;

  @override
  Widget build(BuildContext context) {
    final steps = (progress * 4).round();

    return SizedBox(
      width: 190,
      height: 190,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Sun
          Positioned(
            top: 0,
            right: 15,
            child: Icon(
              Icons.wb_sunny_rounded,
              size: 42,
              color: Colors.amber.shade400,
            ),
          ),

          // SVG face illustration
          Positioned(
            top: 10,
            child: SvgPicture.asset(
              'assets/images/sunscreen_face.svg',
              width: 190,
              height: 190,
            ),
          ),

          // Left cheek sunscreen
          if (steps >= 1)
            const Positioned(
              top: 112,
              left: 66,
              child: _SunscreenMark(),
            ),

          // Right cheek sunscreen
          if (steps >= 2)
            const Positioned(
              top: 112,
              right: 66,
              child: _SunscreenMark(),
            ),

          // Forehead sunscreen
          if (steps >= 3)
            const Positioned(
              top: 74,
              child: _SunscreenMark(
                width: 20,
                height: 7,
              ),
            ),

          // Nose sunscreen
          if (steps >= 4)
            const Positioned(
              top: 104,
              child: _SunscreenMark(
                width: 8,
                height: 16,
              ),
            ),

          // Four progress indicators
          Positioned(
            bottom: 2,
            child: Row(
              children: List.generate(
                4,
                (index) {
                  final filled = steps >= index + 1;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                    ),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: 26,
                      height: 7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: filled
                            ? Colors.orange.shade400
                            : Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SunscreenMark extends StatelessWidget {
  const _SunscreenMark({
    this.width = 16,
    this.height = 7,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.5, end: 1.0),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        final safeOpacity = value.clamp(0.0, 1.0).toDouble();

        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: safeOpacity,
            child: child,
          ),
        );
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.75),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
