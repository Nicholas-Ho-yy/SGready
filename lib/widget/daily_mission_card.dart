import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/daily_task.dart';
import '../models/gamification.dart';
import '../models/mission_context.dart';
import 'hydration_task_card.dart';
import 'sunscreen_task_card.dart';
import 'rain_prep_task_card.dart';

class DailyMissionCard extends StatelessWidget {
  const DailyMissionCard({
    super.key,
    required this.tasks,
    required this.progress,
    required this.onCheckboxChanged,
    required this.onIncrementCounter,
    required this.onDecrementCounter,
    required this.onClaimReward,
    required this.missionContext,
    required this.largerControlsEnabled,
    this.isUpdating = false,
  });

  final List<DailyTask> tasks;
  final UserProgress progress;
  final MissionContext missionContext;

  final Future<void> Function(
    DailyTask task,
    bool isCompleted,
  ) onCheckboxChanged;

  final Future<void> Function(
    DailyTask task,
  ) onIncrementCounter;

  final Future<void> Function(
    DailyTask task,
  ) onDecrementCounter;

  final Future<void> Function() onClaimReward;

  final bool isUpdating;
  final bool largerControlsEnabled;

  @override
  Widget build(BuildContext context) {
    final completedTasks = tasks.where((task) {
      return progress.isDailyTaskCompleted(
        taskId: task.id,
        target: task.target,
      );
    }).length;

    final totalTasks = tasks.length;

    final progressValue =
        totalTasks == 0 ? 0.0 : (completedTasks / totalTasks).clamp(0.0, 1.0);

    final percentage = (progressValue * 100).round();

    final missionComplete = totalTasks > 0 && completedTasks == totalTasks;

    final remainingTasks = totalTasks - completedTasks;

    final rewardXp = tasks.fold<int>(
      0,
      (total, task) => total + task.points,
    );

    final rewardClaimed = progress.dailyTaskRewardClaimed;

    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: scheme.outlineVariant.withValues(alpha: 0.65),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (tasks.isNotEmpty) ...[
            _MissionContextBanner(
              missionContext: missionContext,
              rewardXp: rewardXp,
            ),
            const SizedBox(height: 16),
          ],
          _DailyProgressCard(
            percentage: percentage,
            progressValue: progressValue,
            completedTasks: completedTasks,
            totalTasks: totalTasks,
            remainingTasks: remainingTasks,
            missionComplete: missionComplete,
          ),
          const SizedBox(height: 22),
          Text(
            l10n.todaysActions,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.todaysActionsDescription,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                  height: 1.35,
                ),
          ),
          const SizedBox(height: 14),
          if (tasks.isEmpty)
            const _EmptyMissionView()
          else
            ...tasks.map(
              (task) => _DailyTaskTile(
                task: task,
                progress: progress,
                isUpdating: isUpdating || rewardClaimed,
                largerControlsEnabled: largerControlsEnabled,
                onCheckboxChanged: onCheckboxChanged,
                onIncrementCounter: onIncrementCounter,
                onDecrementCounter: onDecrementCounter,
              ),
            ),
          const SizedBox(height: 8),
          _MissionStatusMessage(
            rewardClaimed: rewardClaimed,
            missionComplete: missionComplete,
            progressValue: progressValue,
            remainingTasks: remainingTasks,
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                minimumSize: Size(
                  double.infinity,
                  largerControlsEnabled ? 56 : 48,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: largerControlsEnabled ? 22 : 16,
                  vertical: largerControlsEnabled ? 16 : 12,
                ),
              ),
              onPressed: missionComplete && !rewardClaimed && !isUpdating
                  ? onClaimReward
                  : null,
              icon: Icon(
                rewardClaimed
                    ? Icons.verified_rounded
                    : missionComplete
                        ? Icons.stars_rounded
                        : Icons.lock_outline_rounded,
                size: largerControlsEnabled ? 26 : 24,
              ),
              label: Text(
                _buttonLabel(
                  l10n: l10n,
                  rewardClaimed: rewardClaimed,
                  missionComplete: missionComplete,
                  remainingTasks: remainingTasks,
                  rewardXp: rewardXp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _buttonLabel({
    required AppLocalizations l10n,
    required bool rewardClaimed,
    required bool missionComplete,
    required int remainingTasks,
    required int rewardXp,
  }) {
    if (rewardClaimed) {
      return l10n.rewardClaimed;
    }

    if (missionComplete) {
      return l10n.claimXp(rewardXp);
    }

    if (remainingTasks == 1) {
      return l10n.completeOneMoreTask;
    }

    return l10n.completeMoreTasks(remainingTasks);
  }
}

class _MissionContextBanner extends StatefulWidget {
  const _MissionContextBanner({
    required this.missionContext,
    required this.rewardXp,
  });

  final MissionContext missionContext;
  final int rewardXp;

  @override
  State<_MissionContextBanner> createState() => _MissionContextBannerState();
}

class _MissionContextBannerState extends State<_MissionContextBanner> {
  bool _showExplanation = false;

  @override
  Widget build(BuildContext context) {
    final missionContext = widget.missionContext;

    final visual = _visualForFocus(
      missionContext.focus,
    );

    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    final localizedMissionTitle = _localizedMissionTitle(missionContext, l10n);

    final localizedMissionMessage =
        _localizedMissionMessage(missionContext, l10n);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: visual.color.withValues(
                  alpha: 0.10,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                visual.icon,
                color: visual.color,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.todaysConditions,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l10n.priority(
                      _focusLabel(
                        missionContext.focus,
                        l10n,
                      ),
                    ),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: visual.color,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
            _RewardBadge(
              rewardXp: widget.rewardXp,
              claimed: false,
            ),
          ],
        ),

        const SizedBox(height: 12),

        Wrap(
          spacing: 7,
          runSpacing: 7,
          children: [
            _ReadingChip(
              icon: Icons.air_rounded,
              label: _localizedPsiDisplay(
                missionContext,
                l10n,
              ),
              color: Colors.blueGrey,
            ),
            _ReadingChip(
              icon: Icons.wb_sunny_outlined,
              label: _localizedUvDisplay(
                missionContext,
                l10n,
              ),
              color: Colors.orange,
            ),
            _ReadingChip(
              icon: Icons.thermostat_outlined,
              label: _localizedHeatDisplay(
                missionContext,
                l10n,
              ),
              color: const Color(0xFFF97360),
            ),
            if (missionContext.heavyRainDetected)
              _ReadingChip(
                icon: Icons.umbrella_outlined,
                label: l10n.heavyRain,
                color: const Color(0xFF4D9DE0),
              ),
          ],
        ),

        const SizedBox(height: 12),

        // Expand / collapse control
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              setState(() {
                _showExplanation = !_showExplanation;
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 8,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 18,
                    color: visual.color,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l10n.whyThisPlan,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: visual.color,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _showExplanation ? 0.5 : 0,
                    duration: const Duration(
                      milliseconds: 200,
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Existing explanation, now expandable
        AnimatedSize(
          duration: const Duration(
            milliseconds: 250,
          ),
          curve: Curves.easeInOut,
          child: _showExplanation
              ? Padding(
                  padding: const EdgeInsets.only(
                    top: 4,
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: visual.color.withValues(
                        alpha: 0.07,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localizedMissionTitle,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          localizedMissionMessage,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: scheme.onSurfaceVariant,
                                    height: 1.35,
                                  ),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  String _focusLabel(
    MissionFocus focus,
    AppLocalizations l10n,
  ) {
    switch (focus) {
      case MissionFocus.rain:
        return l10n.focusRainPreparation;

      case MissionFocus.hazeAndUv:
        return l10n.focusAirQualitySunProtection;

      case MissionFocus.haze:
        return l10n.focusAirQuality;

      case MissionFocus.uv:
        return l10n.focusSunProtection;

      case MissionFocus.general:
        return l10n.focusGeneralPreparedness;
    }
  }

  _MissionVisual _visualForFocus(
    MissionFocus focus,
  ) {
    switch (focus) {
      case MissionFocus.rain:
        return const _MissionVisual(
          icon: Icons.umbrella_outlined,
          color: Color(0xFF4D9DE0),
        );

      case MissionFocus.hazeAndUv:
        return const _MissionVisual(
          icon: Icons.health_and_safety_outlined,
          color: Color(0xFFF4B942),
        );

      case MissionFocus.haze:
        return const _MissionVisual(
          icon: Icons.air_rounded,
          color: Color(0xFF7C8798),
        );

      case MissionFocus.uv:
        return const _MissionVisual(
          icon: Icons.wb_sunny_outlined,
          color: Color(0xFFF4B942),
        );

      case MissionFocus.general:
        return const _MissionVisual(
          icon: Icons.check_circle_outline_rounded,
          color: Color(0xFF3DAA78),
        );
    }
  }
}

class _DailyProgressCard extends StatelessWidget {
  const _DailyProgressCard({
    required this.percentage,
    required this.progressValue,
    required this.completedTasks,
    required this.totalTasks,
    required this.remainingTasks,
    required this.missionComplete,
  });

  final int percentage;
  final double progressValue;
  final int completedTasks;
  final int totalTasks;
  final int remainingTasks;
  final bool missionComplete;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.primaryContainer.withValues(
          alpha: 0.28,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.dailyPreparedness,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              Text(
                '$percentage%',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: scheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: progressValue,
            minHeight: 7,
            borderRadius: BorderRadius.circular(20),
          ),
          const SizedBox(height: 9),
          Row(
            children: [
              Icon(
                missionComplete
                    ? Icons.check_circle_rounded
                    : Icons.flag_outlined,
                size: 16,
                color:
                    missionComplete ? const Color(0xFF3DAA78) : scheme.primary,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  missionComplete
                      ? l10n.allActionsCompleted(totalTasks)
                      : l10n.actionsCompleted(
                          completedTasks,
                          totalTasks,
                        ),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              if (!missionComplete && remainingTasks > 0)
                Text(
                  l10n.tasksLeft(remainingTasks),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MissionVisual {
  const _MissionVisual({
    required this.icon,
    required this.color,
  });

  final IconData icon;
  final Color color;
}

class _ReadingChip extends StatelessWidget {
  const _ReadingChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}

class _DailyTaskTile extends StatelessWidget {
  const _DailyTaskTile({
    required this.task,
    required this.progress,
    required this.isUpdating,
    required this.largerControlsEnabled,
    required this.onCheckboxChanged,
    required this.onIncrementCounter,
    required this.onDecrementCounter,
  });

  final DailyTask task;
  final UserProgress progress;
  final bool isUpdating;
  final bool largerControlsEnabled;

  final Future<void> Function(
    DailyTask task,
    bool isCompleted,
  ) onCheckboxChanged;

  final Future<void> Function(
    DailyTask task,
  ) onIncrementCounter;

  final Future<void> Function(
    DailyTask task,
  ) onDecrementCounter;

  @override
  Widget build(BuildContext context) {
    final currentProgress = progress.dailyTaskProgressFor(task.id);

    final completed = progress.isDailyTaskCompleted(
      taskId: task.id,
      target: task.target,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: completed
            ? Colors.green.withValues(alpha: 0.06)
            : Theme.of(context)
                .colorScheme
                .surfaceContainerHighest
                .withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: completed
              ? Colors.green.withValues(alpha: 0.30)
              : Theme.of(context)
                  .colorScheme
                  .outlineVariant
                  .withValues(alpha: 0.65),
        ),
      ),
      child: task.id == 'hydration_goal_heat'
          ? HydrationTaskCard(
              task: task,
              currentProgress: currentProgress,
              largerControlsEnabled: largerControlsEnabled,
              onIncrement: () => onIncrementCounter(task),
              onDecrement: () => onDecrementCounter(task),
            )
          : task.id == 'apply_sunscreen'
              ? SunscreenTaskCard(
                  task: task,
                  currentProgress: currentProgress,
                  largerControlsEnabled: largerControlsEnabled,
                  onIncrement: () => onIncrementCounter(task),
                  onDecrement: () => onDecrementCounter(task),
                )
              : task.id == 'rain_preparation'
                  ? RainPrepTaskCard(
                      task: task,
                      currentProgress: currentProgress,
                      largerControlsEnabled: largerControlsEnabled,
                      onIncrement: () => onIncrementCounter(task),
                      onDecrement: () => onDecrementCounter(task),
                    )
                  : task.isCounter
                      ? _CounterTaskContent(
                          task: task,
                          currentProgress: currentProgress,
                          completed: completed,
                          isUpdating: isUpdating,
                          largerControlsEnabled: largerControlsEnabled,
                          onIncrement: () => onIncrementCounter(task),
                          onDecrement: () => onDecrementCounter(task),
                        )
                      : _CheckboxTaskContent(
                          task: task,
                          completed: completed,
                          isUpdating: isUpdating,
                          largerControlsEnabled: largerControlsEnabled,
                          onChanged: (value) {
                            onCheckboxChanged(task, value);
                          },
                        ),
    );
  }
}

class _CheckboxTaskContent extends StatelessWidget {
  const _CheckboxTaskContent({
    required this.task,
    required this.completed,
    required this.isUpdating,
    required this.largerControlsEnabled,
    required this.onChanged,
  });

  final DailyTask task;
  final bool completed;
  final bool isUpdating;
  final bool largerControlsEnabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform.scale(
          scale: largerControlsEnabled ? 1.3 : 1.0,
          child: Checkbox(
            value: completed,
            onChanged: isUpdating
                ? null
                : (value) {
                    onChanged(value ?? false);
                  },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8,
            ),
            child: _TaskText(
              task: task,
              completed: completed,
            ),
          ),
        ),
      ],
    );
  }
}

class _CounterTaskContent extends StatelessWidget {
  const _CounterTaskContent({
    required this.task,
    required this.currentProgress,
    required this.completed,
    required this.isUpdating,
    required this.largerControlsEnabled,
    required this.onIncrement,
    required this.onDecrement,
  });

  final DailyTask task;
  final int currentProgress;
  final bool completed;
  final bool isUpdating;
  final bool largerControlsEnabled;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final counterProgress = task.target == 0
        ? 0.0
        : (currentProgress / task.target).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              _taskIcon(task),
              color: completed ? Colors.green : _taskColor(task),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _TaskText(
                task: task,
                completed: completed,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        LinearProgressIndicator(
          value: counterProgress,
          minHeight: 8,
          borderRadius: BorderRadius.circular(20),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.counterProgress(
                  currentProgress,
                  task.target,
                  _localizedTaskUnit(task, l10n),
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            IconButton.outlined(
              onPressed:
                  isUpdating || currentProgress <= 0 ? null : onDecrement,
              icon: Icon(
                Icons.remove,
                size: largerControlsEnabled ? 28 : 24,
              ),
              constraints: BoxConstraints(
                minWidth: largerControlsEnabled ? 56 : 48,
                minHeight: largerControlsEnabled ? 56 : 48,
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filled(
              onPressed: isUpdating || currentProgress >= task.target
                  ? null
                  : onIncrement,
              icon: Icon(
                Icons.add,
                size: largerControlsEnabled ? 28 : 24,
              ),
              constraints: BoxConstraints(
                minWidth: largerControlsEnabled ? 56 : 48,
                minHeight: largerControlsEnabled ? 56 : 48,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TaskText extends StatefulWidget {
  const _TaskText({
    required this.task,
    required this.completed,
  });

  final DailyTask task;
  final bool completed;

  @override
  State<_TaskText> createState() => _TaskTextState();
}

class _TaskTextState extends State<_TaskText> {
  bool _showReason = false;

  @override
  Widget build(BuildContext context) {
    final task = widget.task;
    final completed = widget.completed;
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    final localizedTitle = _localizedTaskTitle(task, l10n);

    final localizedDescription = _localizedTaskDescription(task, l10n);

    final localizedEstimatedTime = _localizedTaskEstimatedTime(task, l10n);

    final localizedReason = _localizedTaskReason(task, l10n);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizedTitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                decoration: completed ? TextDecoration.lineThrough : null,
              ),
        ),
        const SizedBox(height: 3),
        Text(
          localizedDescription,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
                height: 1.35,
              ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(
              Icons.schedule_outlined,
              size: 15,
              color: scheme.onSurfaceVariant,
            ),
            const SizedBox(width: 4),
            Text(
              localizedEstimatedTime,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              setState(() {
                _showReason = !_showReason;
              });
            },
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 16,
                    color: scheme.primary,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    l10n.why,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: scheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(width: 2),
                  AnimatedRotation(
                    turns: _showReason ? 0.5 : 0,
                    duration: const Duration(
                      milliseconds: 200,
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 18,
                      color: scheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(
            milliseconds: 220,
          ),
          curve: Curves.easeInOut,
          child: _showReason
              ? Padding(
                  padding: const EdgeInsets.only(
                    top: 3,
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: scheme.primaryContainer.withValues(
                        alpha: 0.25,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      localizedReason,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                            height: 1.35,
                          ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _MissionStatusMessage extends StatelessWidget {
  const _MissionStatusMessage({
    required this.rewardClaimed,
    required this.missionComplete,
    required this.progressValue,
    required this.remainingTasks,
  });

  final bool rewardClaimed;
  final bool missionComplete;
  final double progressValue;
  final int remainingTasks;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final completedState = rewardClaimed || missionComplete;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: completedState
            ? Colors.green.withValues(alpha: 0.08)
            : Theme.of(context)
                .colorScheme
                .secondaryContainer
                .withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(
            rewardClaimed
                ? Icons.verified
                : missionComplete
                    ? Icons.celebration_outlined
                    : Icons.local_fire_department_outlined,
            color: completedState
                ? Colors.green
                : Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _message(l10n),
            ),
          ),
        ],
      ),
    );
  }

  String _message(AppLocalizations l10n) {
    if (rewardClaimed) {
      return l10n.missionRewardClaimedMessage;
    }

    if (missionComplete) {
      return l10n.missionCompleteMessage;
    }

    if (progressValue == 0) {
      return l10n.missionStartMessage;
    }

    if (progressValue < 0.5) {
      return l10n.missionGoodStartMessage;
    }

    if (remainingTasks == 1) {
      return l10n.missionOneRemainingMessage;
    }

    return l10n.missionRemainingMessage;
  }
}

class _RewardBadge extends StatelessWidget {
  const _RewardBadge({
    required this.rewardXp,
    required this.claimed,
  });

  final int rewardXp;
  final bool claimed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: claimed
            ? Colors.green.withValues(alpha: 0.12)
            : Colors.amber.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            claimed ? Icons.verified : Icons.stars,
            size: 18,
            color: claimed ? Colors.green : Colors.amber,
          ),
          const SizedBox(width: 4),
          Text(
            claimed ? l10n.done : '+$rewardXp XP',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyMissionView extends StatelessWidget {
  const _EmptyMissionView();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        AppLocalizations.of(context)!.noDailyMission,
      ),
    );
  }
}

IconData _taskIcon(DailyTask task) {
  switch (task.category.toLowerCase()) {
    case 'haze':
      return Icons.masks_outlined;
    case 'uv':
      return Icons.wb_sunny_outlined;
    case 'heat':
      return Icons.water_drop_outlined;
    case 'rain':
      return Icons.umbrella_outlined;
    case 'flood':
      return Icons.flood_outlined;
    default:
      return Icons.fact_check_outlined;
  }
}

Color _taskColor(DailyTask task) {
  switch (task.category.toLowerCase()) {
    case 'haze':
      return Colors.blueGrey;
    case 'uv':
      return Colors.orange;
    case 'heat':
      return Colors.blue;
    case 'rain':
      return Colors.indigo;
    case 'flood':
      return Colors.lightBlue;
    default:
      return Colors.teal;
  }
}

String _localizedTaskTitle(
  DailyTask task,
  AppLocalizations l10n,
) {
  switch (task.id) {
    case 'review_conditions':
      return l10n.taskReviewConditionsTitle;

    case 'monitor_air_quality':
      return l10n.taskMonitorAirQualityTitle;

    case 'pack_n95':
      return l10n.taskPackN95Title;

    case 'reduce_outdoor_exercise':
      return l10n.taskReduceOutdoorExerciseTitle;

    case 'stay_indoors_haze':
      return l10n.taskStayIndoorsHazeTitle;

    case 'prepare_n95_haze':
      return l10n.taskPrepareN95HazeTitle;

    case 'check_haze_symptoms':
      return l10n.taskCheckHazeSymptomsTitle;

    case 'apply_sunscreen':
      return l10n.taskApplySunscreenTitle;

    case 'seek_midday_shade':
      return l10n.taskSeekMiddayShadeTitle;

    case 'reapply_sunscreen':
      return l10n.taskReapplySunscreenTitle;

    case 'wear_sun_protection':
      return l10n.taskWearSunProtectionTitle;

    case 'avoid_midday_sun':
      return l10n.taskAvoidMiddaySunTitle;

    case 'carry_water_heat':
      return l10n.taskCarryWaterHeatTitle;

    case 'hydration_goal_heat':
      return l10n.taskHydrationGoalHeatTitle;

    case 'cooling_break_heat':
      return l10n.taskCoolingBreakHeatTitle;

    case 'reduce_outdoor_heat':
      return l10n.taskReduceOutdoorHeatTitle;

    case 'rain_preparation':
      return l10n.taskRainPreparationTitle;

    default:
      return task.title;
  }
}

String _localizedTaskDescription(
  DailyTask task,
  AppLocalizations l10n,
) {
  switch (task.id) {
    case 'review_conditions':
      return l10n.taskReviewConditionsDescription;

    case 'monitor_air_quality':
      return l10n.taskMonitorAirQualityDescription;

    case 'pack_n95':
      return l10n.taskPackN95Description;

    case 'reduce_outdoor_exercise':
      return l10n.taskReduceOutdoorExerciseDescription;

    case 'stay_indoors_haze':
      return l10n.taskStayIndoorsHazeDescription;

    case 'prepare_n95_haze':
      return l10n.taskPrepareN95HazeDescription;

    case 'check_haze_symptoms':
      return l10n.taskCheckHazeSymptomsDescription;

    case 'apply_sunscreen':
      switch (task.contentKey) {
        case 'moderate':
          return l10n.taskApplySunscreenModerateDescription;
        case 'high':
          return l10n.taskApplySunscreenHighDescription;
        case 'veryHigh':
          return l10n.taskApplySunscreenVeryHighDescription;
        default:
          return l10n.taskApplySunscreenDescription;
      }

    case 'seek_midday_shade':
      return l10n.taskSeekMiddayShadeDescription;

    case 'reapply_sunscreen':
      return l10n.taskReapplySunscreenDescription;

    case 'wear_sun_protection':
      return l10n.taskWearSunProtectionDescription;

    case 'avoid_midday_sun':
      return l10n.taskAvoidMiddaySunDescription;

    case 'carry_water_heat':
      return l10n.taskCarryWaterHeatDescription;

    case 'hydration_goal_heat':
      return l10n.taskHydrationGoalHeatDescription;

    case 'cooling_break_heat':
      return l10n.taskCoolingBreakHeatDescription;

    case 'reduce_outdoor_heat':
      return l10n.taskReduceOutdoorHeatDescription;

    case 'rain_preparation':
      return l10n.taskRainPreparationDescription;

    default:
      return task.description;
  }
}

String _localizedTaskReason(
  DailyTask task,
  AppLocalizations l10n,
) {
  switch (task.id) {
    case 'review_conditions':
      return l10n.taskReviewConditionsReason;

    case 'monitor_air_quality':
      return l10n.taskMonitorAirQualityReason;

    case 'pack_n95':
      return l10n.taskPackN95Reason;

    case 'reduce_outdoor_exercise':
      return l10n.taskReduceOutdoorExerciseReason;

    case 'stay_indoors_haze':
      return l10n.taskStayIndoorsHazeReason;

    case 'prepare_n95_haze':
      return l10n.taskPrepareN95HazeReason;

    case 'check_haze_symptoms':
      return l10n.taskCheckHazeSymptomsReason;

    case 'apply_sunscreen':
      switch (task.contentKey) {
        case 'moderate':
          return l10n.taskApplySunscreenModerateReason;
        case 'high':
          return l10n.taskApplySunscreenHighReason;
        case 'veryHigh':
          return l10n.taskApplySunscreenVeryHighReason;
        default:
          return l10n.taskApplySunscreenReason;
      }

    case 'seek_midday_shade':
      return l10n.taskSeekMiddayShadeReason;

    case 'reapply_sunscreen':
      return l10n.taskReapplySunscreenReason;

    case 'wear_sun_protection':
      return l10n.taskWearSunProtectionReason;

    case 'avoid_midday_sun':
      return l10n.taskAvoidMiddaySunReason;

    case 'carry_water_heat':
      return l10n.taskCarryWaterHeatReason;

    case 'hydration_goal_heat':
      return l10n.taskHydrationGoalHeatReason;

    case 'cooling_break_heat':
      return l10n.taskCoolingBreakHeatReason;

    case 'reduce_outdoor_heat':
      return l10n.taskReduceOutdoorHeatReason;

    case 'rain_preparation':
      return l10n.taskRainPreparationReason;

    default:
      return task.reason;
  }
}

String _localizedTaskEstimatedTime(
  DailyTask task,
  AppLocalizations l10n,
) {
  switch (task.estimatedTime) {
    case '1 minute':
      return l10n.estimatedOneMinute;

    case '30 seconds':
      return l10n.estimatedThirtySeconds;

    case 'Throughout the day':
      return l10n.estimatedThroughoutDay;

    case 'Plan for today':
      return l10n.estimatedPlanToday;

    case '2–3 minutes':
    case '2-3 minutes':
      return l10n.estimatedTwoThreeMinutes;

    default:
      return task.estimatedTime;
  }
}

String _localizedTaskUnit(
  DailyTask task,
  AppLocalizations l10n,
) {
  switch (task.unitLabel?.toLowerCase()) {
    case 'steps':
      return l10n.unitSteps;

    case 'glasses':
      return l10n.unitGlasses;

    default:
      return task.unitLabel ?? l10n.completed;
  }
}

String _localizedMissionTitle(
  MissionContext context,
  AppLocalizations l10n,
) {
  switch (context.title) {
    case 'Rain preparedness is recommended':
      return l10n.missionRainTitle;
    case 'Heat and UV precautions are recommended':
      return l10n.missionHeatUvTitle;
    case 'Heat precautions are recommended':
      return l10n.missionHeatTitle;
    case 'Air-quality and UV precautions are recommended':
      return l10n.missionHazeUvTitle;
    case 'Air-quality precautions are recommended':
      return l10n.missionHazeTitle;
    case 'UV protection is recommended':
      return l10n.missionUvTitle;
    case 'Conditions are generally manageable':
      return l10n.missionGeneralTitle;
    default:
      return context.title;
  }
}

String _localizedMissionMessage(
  MissionContext context,
  AppLocalizations l10n,
) {
  switch (context.title) {
    case 'Rain preparedness is recommended':
      return l10n.missionRainMessage;
    case 'Heat and UV precautions are recommended':
      return l10n.missionHeatUvMessage;
    case 'Heat precautions are recommended':
      return l10n.missionHeatMessage;
    case 'Air-quality and UV precautions are recommended':
      return l10n.missionHazeUvMessage;
    case 'Air-quality precautions are recommended':
      return l10n.missionHazeMessage;
    case 'UV protection is recommended':
      return l10n.missionUvMessage;
    case 'Conditions are generally manageable':
      return l10n.missionGeneralMessage;
    default:
      return context.message;
  }
}

String _localizedPsiLabel(
  String label,
  AppLocalizations l10n,
) {
  switch (label) {
    case 'Good':
      return l10n.psiGood;
    case 'Moderate':
      return l10n.psiModerate;
    case 'Unhealthy':
      return l10n.psiUnhealthy;
    case 'Very Unhealthy':
      return l10n.psiVeryUnhealthy;
    case 'Hazardous':
      return l10n.psiHazardous;
    case 'No data':
      return l10n.riskNoData;
    default:
      return label;
  }
}

String _localizedRiskLevelLabel(
  String label,
  AppLocalizations l10n,
) {
  switch (label) {
    case 'Low':
      return l10n.riskLow;
    case 'Moderate':
      return l10n.riskModerate;
    case 'High':
      return l10n.riskHigh;
    case 'Very High':
      return l10n.riskVeryHigh;
    case 'Extreme':
      return l10n.riskExtreme;
    case 'No data':
      return l10n.riskNoData;
    default:
      return label;
  }
}

String _localizedPsiDisplay(
  MissionContext context,
  AppLocalizations l10n,
) {
  return l10n.psiReading(
    context.psiValue?.toString() ?? '—',
    _localizedPsiLabel(
      context.psiLabel,
      l10n,
    ),
  );
}

String _localizedUvDisplay(
  MissionContext context,
  AppLocalizations l10n,
) {
  return l10n.uvReading(
    context.uvValue?.toString() ?? '—',
    _localizedRiskLevelLabel(
      context.uvLabel,
      l10n,
    ),
  );
}

String _localizedHeatDisplay(
  MissionContext context,
  AppLocalizations l10n,
) {
  return l10n.heatStressReading(
    _localizedRiskLevelLabel(
      context.heatStressLabel,
      l10n,
    ),
  );
}
