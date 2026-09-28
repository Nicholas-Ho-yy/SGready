// SGReady Final Year Project
// Developed by: Nicholas Ho
//
// The SGReady-specific notification message generation, localisation,
// weather advice and daily-task reminder logic in this file were developed by me.
//
// The preparedness messages were written based on the safety and preparedness
// guidance researched for this project. The relevant sources are referenced
// in the project report.

import '../models/daily_task.dart';
import '../models/gamification.dart';
import '../models/mission_context.dart';

/// Builds localized notification messages from weather conditions
/// and the user's daily preparedness tasks.
class NotificationCoordinator {
  const NotificationCoordinator();

  /// Builds weather and preparedness advice.
  ///
  /// The context is generated from the environmental snapshot
  /// available when this method is called.
  String buildWeatherPreparednessBody({
    required MissionContext context,
    String languageCode = 'en',
  }) {
    // Build the first part of the notification using the latest
    // PSI, UV and heat-stress information.
    final lines = <String>[
      _localizedPsiDisplay(context, languageCode),
      _localizedUvDisplay(context, languageCode),
      _localizedHeatDisplay(context, languageCode),
    ];

    if (context.heavyRainDetected) {
      lines.add(
        _text(
          languageCode,
          en: 'Heavy rain detected',
          zh: '检测到大雨',
          ms: 'Hujan lebat dikesan',
        ),
      );
    }

    final advice = _buildWeatherAdvice(context, languageCode);

    return '${lines.join('\n')}\n\n$advice';
  }

  String _buildWeatherAdvice(
    MissionContext context,
    String languageCode,
  ) {
    // Heavy rain takes priority because it may affect travel and safety.
    if (context.heavyRainDetected) {
      return _text(
        languageCode,
        en: '⚠ Bring an umbrella and avoid flood-prone areas.',
        zh: '⚠ 请携带雨伞，并避开容易发生水灾的地区。',
        ms: '⚠ Bawa payung dan elakkan kawasan yang mudah dilanda banjir.',
      );
    }

    // If there is no heavy rain, check the remaining conditions
    // in priority order and return the first relevant advice.
    final psi = context.psiValue;

    if (psi != null) {
      if (psi > 200) {
        return _text(
          languageCode,
          en: '⚠ Avoid prolonged outdoor activity.',
          zh: '⚠ 避免长时间进行户外活动。',
          ms: '⚠ Elakkan aktiviti luar yang berpanjangan.',
        );
      }

      if (psi > 100) {
        return _text(
          languageCode,
          en: '⚠ Limit prolonged outdoor activity.',
          zh: '⚠ 减少长时间的户外活动。',
          ms: '⚠ Hadkan aktiviti luar yang berpanjangan.',
        );
      }
    }

    final uv = context.uvValue;

    if (uv != null) {
      if (uv >= 8) {
        return _text(
          languageCode,
          en: '☀ Use sun protection and seek shade.',
          zh: '☀ 做好防晒措施，并尽量待在阴凉处。',
          ms: '☀ Gunakan perlindungan matahari dan berteduh.',
        );
      }

      if (uv >= 6) {
        return _text(
          languageCode,
          en: '☀ Use sunscreen when outdoors.',
          zh: '☀ 户外活动时请使用防晒霜。',
          ms: '☀ Gunakan pelindung matahari apabila berada di luar.',
        );
      }
    }

    final heat = context.heatStressLabel.toLowerCase();

    if (heat.contains('high') || heat.contains('danger')) {
      return _text(
        languageCode,
        en: '🌡 Stay hydrated and reduce heat exposure.',
        zh: '🌡 保持充足水分，并减少高温暴露。',
        ms: '🌡 Kekal terhidrat dan kurangkan pendedahan kepada haba.',
      );
    }

    return _text(
      languageCode,
      en: '✓ Conditions are generally suitable for outdoor activity.',
      zh: '✓ 当前情况总体适合户外活动。',
      ms: '✓ Keadaan secara amnya sesuai untuk aktiviti luar.',
    );
  }

  /// Builds a reminder for today's unfinished daily tasks.
  ///
  /// Returns null when there are no eligible tasks remaining.
  String? buildDailyTaskReminderBody({
    required List<DailyTask> tasks,
    required UserProgress progress,
    String languageCode = 'en',
    DateTime? currentTime,
  }) {
    final today = currentTime ?? DateTime.now();

    // Only compare progress from today so old task data does not
    // affect the current reminder.
    final hasTodayProgress = progress.hasDailyTaskDataFor(today);

    // Find the tasks that still need to be completed. The general
    // conditions-review task is not included in reminder notifications.
    final incompleteTasks = tasks.where((task) {
      if (task.id == 'review_conditions') {
        return false;
      }

      final currentProgress =
          hasTodayProgress ? progress.dailyTaskProgressFor(task.id) : 0;

      return currentProgress < task.target;
    }).toList();

    if (incompleteTasks.isEmpty) {
      return null;
    }

    final priorityTask = _selectPriorityTask(incompleteTasks);

    final priorityTaskTitle = _localizedTaskTitle(
      priorityTask,
      languageCode,
    );

    final taskCount = incompleteTasks.length;

    switch (languageCode) {
      case 'zh':
        return '您今天还有 $taskCount 项防灾准备任务未完成。'
            '下一项行动：$priorityTaskTitle。';

      case 'ms':
        return 'Anda mempunyai $taskCount tugas kesiapsiagaan '
            'yang masih belum selesai hari ini. '
            'Tindakan seterusnya: $priorityTaskTitle.';

      case 'en':
      default:
        final taskLabel = taskCount == 1 ? 'task' : 'tasks';

        return 'You have $taskCount preparedness '
            '$taskLabel remaining today. '
            'Next action: $priorityTaskTitle.';
    }
  }

  // Return the version of a message that matches the user's
  // selected app language.
  String _text(
    String languageCode, {
    required String en,
    required String zh,
    required String ms,
  }) {
    switch (languageCode) {
      case 'zh':
        return zh;

      case 'ms':
        return ms;

      case 'en':
      default:
        return en;
    }
  }

  String _localizedPsiDisplay(
    MissionContext context,
    String languageCode,
  ) {
    final value = context.psiValue?.toString() ?? '—';

    final label = _localizedRiskLabel(
      context.psiLabel,
      languageCode,
    );

    return 'PSI $value · $label';
  }

  String _localizedUvDisplay(
    MissionContext context,
    String languageCode,
  ) {
    final value = context.uvValue?.toString() ?? '—';

    final label = _localizedRiskLabel(
      context.uvLabel,
      languageCode,
    );

    return 'UV $value · $label';
  }

  String _localizedHeatDisplay(
    MissionContext context,
    String languageCode,
  ) {
    final label = _localizedRiskLabel(
      context.heatStressLabel,
      languageCode,
    );

    return _text(
      languageCode,
      en: 'Heat stress · $label',
      zh: '热应激 · $label',
      ms: 'Tekanan haba · $label',
    );
  }

  String _localizedRiskLabel(
    String label,
    String languageCode,
  ) {
    switch (label.toLowerCase().trim()) {
      case 'good':
        return _text(
          languageCode,
          en: 'Good',
          zh: '良好',
          ms: 'Baik',
        );

      case 'low':
        return _text(
          languageCode,
          en: 'Low',
          zh: '低',
          ms: 'Rendah',
        );

      case 'moderate':
        return _text(
          languageCode,
          en: 'Moderate',
          zh: '中等',
          ms: 'Sederhana',
        );

      case 'high':
        return _text(
          languageCode,
          en: 'High',
          zh: '高',
          ms: 'Tinggi',
        );

      case 'very high':
        return _text(
          languageCode,
          en: 'Very High',
          zh: '非常高',
          ms: 'Sangat tinggi',
        );

      case 'extreme':
        return _text(
          languageCode,
          en: 'Extreme',
          zh: '极高',
          ms: 'Ekstrem',
        );

      case 'no data':
        return _text(
          languageCode,
          en: 'No data',
          zh: '暂无数据',
          ms: 'Tiada data',
        );

      case 'unknown':
        return _text(
          languageCode,
          en: 'Unknown',
          zh: '未知',
          ms: 'Tidak diketahui',
        );

      default:
        return label;
    }
  }

  String _localizedTaskTitle(
    DailyTask task,
    String languageCode,
  ) {
    switch (task.id) {
      case 'monitor_air_quality':
        return _text(
          languageCode,
          en: 'Monitor the air quality',
          zh: '关注空气质量',
          ms: 'Pantau kualiti udara',
        );

      case 'pack_n95':
        return _text(
          languageCode,
          en: 'Pack an N95 mask',
          zh: '携带 N95 口罩',
          ms: 'Bawa pelitup N95',
        );

      case 'reduce_outdoor_exercise':
        return _text(
          languageCode,
          en: 'Reduce strenuous outdoor activity',
          zh: '减少剧烈的户外活动',
          ms: 'Kurangkan aktiviti luar yang lasak',
        );

      case 'stay_indoors_haze':
        return _text(
          languageCode,
          en: 'Stay indoors where possible',
          zh: '尽可能留在室内',
          ms: 'Kekal di dalam rumah jika boleh',
        );

      case 'prepare_n95_haze':
        return _text(
          languageCode,
          en: 'Keep an N95 mask ready',
          zh: '准备好 N95 口罩',
          ms: 'Sediakan pelitup N95',
        );

      case 'check_haze_symptoms':
        return _text(
          languageCode,
          en: 'Monitor your health',
          zh: '留意您的健康状况',
          ms: 'Pantau keadaan kesihatan anda',
        );

      case 'apply_sunscreen':
        return _text(
          languageCode,
          en: 'Apply sunscreen',
          zh: '涂抹防晒霜',
          ms: 'Gunakan pelindung matahari',
        );

      case 'seek_midday_shade':
        return _text(
          languageCode,
          en: 'Seek shade around midday',
          zh: '中午时尽量待在阴凉处',
          ms: 'Berteduh sekitar waktu tengah hari',
        );

      case 'reapply_sunscreen':
        return _text(
          languageCode,
          en: 'Reapply sunscreen',
          zh: '重新涂抹防晒霜',
          ms: 'Gunakan semula pelindung matahari',
        );

      case 'wear_sun_protection':
        return _text(
          languageCode,
          en: 'Wear sun protection',
          zh: '做好防晒保护',
          ms: 'Gunakan perlindungan matahari',
        );

      case 'avoid_midday_sun':
        return _text(
          languageCode,
          en: 'Avoid prolonged midday sun',
          zh: '避免长时间暴露在正午阳光下',
          ms: 'Elakkan pendedahan berpanjangan kepada matahari tengah hari',
        );

      case 'carry_water_heat':
        return _text(
          languageCode,
          en: 'Bring water with you',
          zh: '随身携带饮用水',
          ms: 'Bawa air bersama anda',
        );

      case 'hydration_goal_heat':
        return _text(
          languageCode,
          en: 'Track your water intake',
          zh: '记录您的饮水量',
          ms: 'Jejaki pengambilan air anda',
        );

      case 'cooling_break_heat':
        return _text(
          languageCode,
          en: 'Take regular cooling breaks',
          zh: '定时休息降温',
          ms: 'Ambil rehat untuk menyejukkan badan secara berkala',
        );

      case 'reduce_outdoor_heat':
        return _text(
          languageCode,
          en: 'Reduce strenuous outdoor activity',
          zh: '减少剧烈的户外活动',
          ms: 'Kurangkan aktiviti luar yang lasak',
        );

      case 'rain_preparation':
        return _text(
          languageCode,
          en: 'Prepare for heavy rain',
          zh: '为大雨做好准备',
          ms: 'Bersedia menghadapi hujan lebat',
        );

      default:
        return task.title;
    }
  }

  // Choose which unfinished task should be highlighted as the user's
  // next action. Rain, hydration and sunscreen are checked first.
  DailyTask _selectPriorityTask(List<DailyTask> tasks) {
    const priorityOrder = [
      'rain_preparation',
      'hydration_goal_heat',
      'apply_sunscreen',
    ];

    for (final id in priorityOrder) {
      for (final task in tasks) {
        if (task.id == id) {
          return task;
        }
      }
    }

    return tasks.first;
  }
}
