import '../models/daily_task.dart';
import '../models/environmental_reading.dart';
import '../models/user_preferences.dart';
import 'risk_engine.dart';

/// Creates daily preparedness tasks based on current environmental
/// conditions and the user's preferences.
class DailyTaskService {
  const DailyTaskService();

  /// Generates today's tasks using live environmental readings.
  ///
  /// Tasks are added according to PSI, UV, heat stress and heavy rain,
  /// then ordered based on the user's usual outdoor habits.
  List<DailyTask> generateTasks({
    required EnvironmentalSnapshot snapshot,
    required SingaporeRegion region,
    UserPreferences preferences = const UserPreferences(),
  }) {
    final tasks = <DailyTask>[];

    final psiValue = snapshot.psi?.forRegion(region);
    final uvValue = snapshot.uv?.currentIndex;
    final heatStress = snapshot.heatStressForRegion(region);
    final hasHeavyRain = snapshot.heavyRainStations.isNotEmpty;

    // Always give the user at least one useful task,
    // even when today's conditions are safe.
    tasks.add(
      const DailyTask(
        id: 'review_conditions',
        title: 'Review today’s conditions',
        description:
            'Check the current PSI, UV Index, temperature and rainfall conditions before planning outdoor activities.',
        reason:
            'Reviewing live conditions helps you choose the right precautions before heading outdoors.',
        estimatedTime: '1 minute',
        category: 'General',
        points: 5,
      ),
    );

    // Convert each environmental reading into its risk level
    // before deciding which preparedness tasks are needed.
    if (psiValue != null) {
      final psiRisk = RiskEngine.psiLevel(psiValue);

      _addPsiTasks(
        tasks: tasks,
        level: psiRisk,
      );
    }

    if (uvValue != null) {
      final uvRisk = RiskEngine.uvLevel(uvValue);

      _addUvTasks(
        tasks: tasks,
        level: uvRisk,
      );
    }

    if (heatStress != null) {
      final heatRisk = RiskEngine.wbgtLevel(heatStress);

      _addHeatStressTasks(
        tasks: tasks,
        level: heatRisk,
      );
    }

    if (hasHeavyRain) {
      _addHeavyRainTasks(tasks);
    }

    final uniqueTasks = _removeDuplicates(tasks);

    return _prioritiseTasks(
      uniqueTasks,
      preferences,
    );
  }

  void _addPsiTasks({
    required List<DailyTask> tasks,
    required RiskLevel level,
  }) {
    switch (level) {
      case RiskLevel.good:
        break;

      case RiskLevel.moderate:
        tasks.add(
          const DailyTask(
            id: 'monitor_air_quality',
            title: 'Monitor the air quality',
            description:
                'Check the PSI again before prolonged outdoor activity, especially if you are sensitive to haze.',
            reason:
                'The current PSI indicates that additional caution may be useful, particularly for sensitive individuals.',
            estimatedTime: '1 minute',
            category: 'Haze',
            points: 5,
          ),
        );
        break;

      case RiskLevel.high:
        tasks.addAll(
          const [
            DailyTask(
              id: 'pack_n95',
              title: 'Pack an N95 mask',
              description:
                  'Bring a properly fitted N95 mask if outdoor activity cannot be avoided.',
              reason:
                  'Air quality is currently unhealthy enough for additional protection to be recommended outdoors.',
              estimatedTime: '30 seconds',
              category: 'Haze',
              points: 10,
            ),
            DailyTask(
              id: 'reduce_outdoor_exercise',
              title: 'Reduce strenuous outdoor activity',
              description:
                  'Choose lighter or indoor activities while the air quality is unhealthy.',
              reason:
                  'Strenuous activity increases breathing rate and may increase exposure to air pollutants.',
              estimatedTime: 'Plan for today',
              category: 'Haze',
              points: 10,
            ),
          ],
        );
        break;

      case RiskLevel.veryHigh:
      case RiskLevel.extreme:
        tasks.addAll(
          const [
            DailyTask(
              id: 'stay_indoors_haze',
              title: 'Stay indoors where possible',
              description:
                  'Keep windows and doors closed and minimise unnecessary outdoor exposure.',
              reason:
                  'Current air-quality conditions indicate a high level of exposure risk outdoors.',
              estimatedTime: 'Throughout the day',
              category: 'Haze',
              points: 15,
            ),
            DailyTask(
              id: 'prepare_n95_haze',
              title: 'Keep an N95 mask ready',
              description:
                  'Use an N95 mask if leaving the house is unavoidable.',
              reason:
                  'An N95 mask can help reduce exposure to fine haze particles during poor air-quality conditions.',
              estimatedTime: '30 seconds',
              category: 'Haze',
              points: 10,
            ),
            DailyTask(
              id: 'check_haze_symptoms',
              title: 'Monitor your health',
              description:
                  'Watch for breathing difficulty, coughing or eye irritation.',
              reason:
                  'Very poor air quality may affect respiratory comfort and other health symptoms.',
              estimatedTime: 'Throughout the day',
              category: 'Haze',
              points: 10,
            ),
          ],
        );
        break;
    }
  }

  void _addUvTasks({
    required List<DailyTask> tasks,
    required RiskLevel level,
  }) {
    switch (level) {
      case RiskLevel.good:
        break;

      case RiskLevel.moderate:
        tasks.add(
          const DailyTask(
            id: 'apply_sunscreen',
            contentKey: 'moderate',
            title: 'Apply sunscreen',
            description:
                'Apply broad-spectrum SPF 30+ sunscreen before prolonged outdoor activity.',
            reason:
                'Today’s UV level means sun protection is recommended when spending extended time outdoors.',
            estimatedTime: '30 seconds',
            category: 'UV',
            points: 10,
            type: DailyTaskType.counter,
            target: 4,
            unitLabel: 'steps',
          ),
        );
        break;

      case RiskLevel.high:
        tasks.addAll(
          const [
            DailyTask(
              id: 'apply_sunscreen',
              contentKey: 'high',
              title: 'Apply sunscreen',
              description:
                  'Apply broad-spectrum SPF 30+ sunscreen before going outdoors.',
              reason:
                  'The UV Index is high today, so sun protection is recommended before outdoor activity.',
              estimatedTime: '30 seconds',
              category: 'UV',
              points: 10,
              type: DailyTaskType.counter,
              target: 4,
              unitLabel: 'steps',
            ),
            DailyTask(
              id: 'seek_midday_shade',
              title: 'Seek shade around midday',
              description:
                  'Limit direct sun exposure during the strongest UV period.',
              reason:
                  'UV exposure is typically stronger around midday, making shade an effective protective measure.',
              estimatedTime: 'Plan for today',
              category: 'UV',
              points: 10,
            ),
          ],
        );
        break;

      case RiskLevel.veryHigh:
      case RiskLevel.extreme:
        tasks.addAll(
          const [
            DailyTask(
              id: 'apply_sunscreen',
              contentKey: 'veryHigh',
              title: 'Apply sunscreen',
              description:
                  'Apply broad-spectrum SPF 30+ sunscreen before going outdoors.',
              reason:
                  'Today’s UV level means strong sun protection is recommended before going outdoors.',
              estimatedTime: '30 seconds',
              category: 'UV',
              points: 10,
              type: DailyTaskType.counter,
              target: 4,
              unitLabel: 'steps',
            ),
            DailyTask(
              id: 'reapply_sunscreen',
              title: 'Reapply sunscreen',
              description:
                  'Reapply sunscreen according to the product instructions, especially after sweating.',
              reason:
                  'Very high UV exposure can require continued protection during prolonged outdoor activity.',
              estimatedTime: '30 seconds',
              category: 'UV',
              points: 10,
            ),
            DailyTask(
              id: 'wear_sun_protection',
              title: 'Wear sun protection',
              description: 'Bring a hat, sunglasses and protective clothing.',
              reason:
                  'Additional physical protection helps reduce direct UV exposure to the skin and eyes.',
              estimatedTime: '1 minute',
              category: 'UV',
              points: 10,
            ),
            DailyTask(
              id: 'avoid_midday_sun',
              title: 'Avoid prolonged midday sun',
              description:
                  'Move strenuous outdoor plans away from the strongest UV period.',
              reason:
                  'Very high UV levels make prolonged exposure around midday less advisable.',
              estimatedTime: 'Plan for today',
              category: 'UV',
              points: 10,
            ),
          ],
        );
        break;
    }
  }

  void _addHeatStressTasks({
    required List<DailyTask> tasks,
    required RiskLevel level,
  }) {
    switch (level) {
      case RiskLevel.good:
        break;

      case RiskLevel.moderate:
        tasks.add(
          const DailyTask(
            id: 'carry_water_heat',
            title: 'Bring water with you',
            description:
                'Keep water available if you will be spending time outdoors.',
            reason: 'Current WBGT conditions indicate Moderate heat stress.',
            estimatedTime: '30 seconds',
            category: 'Heat',
            points: 5,
          ),
        );
        break;

      case RiskLevel.high:
      case RiskLevel.veryHigh:
      case RiskLevel.extreme:
        tasks.addAll(
          const [
            DailyTask(
              id: 'hydration_goal_heat',
              title: 'Track your water intake',
              description: 'Record six glasses of water during the day.',
              reason: 'Current WBGT conditions indicate High heat stress.',
              estimatedTime: 'Throughout the day',
              category: 'Heat',
              points: 15,
              type: DailyTaskType.counter,
              target: 6,
              unitLabel: 'glasses',
            ),
            DailyTask(
              id: 'cooling_break_heat',
              title: 'Take regular cooling breaks',
              description:
                  'Spend regular breaks in shaded, ventilated or air-conditioned areas.',
              reason:
                  'High heat-stress conditions increase the need for rest and cooling.',
              estimatedTime: 'Throughout the day',
              category: 'Heat',
              points: 10,
            ),
            DailyTask(
              id: 'reduce_outdoor_heat',
              title: 'Reduce strenuous outdoor activity',
              description:
                  'Choose lighter activity or move strenuous plans to a cooler part of the day.',
              reason: 'Current WBGT conditions indicate High heat stress.',
              estimatedTime: 'Plan for today',
              category: 'Heat',
              points: 10,
            ),
          ],
        );
        break;
    }
  }

  void _addHeavyRainTasks(List<DailyTask> tasks) {
    tasks.add(
      const DailyTask(
        id: 'rain_preparation',
        title: 'Prepare for heavy rain',
        description:
            'Complete the key steps before travelling during heavy rainfall.',
        reason:
            'Heavy rainfall has been detected and may affect travel, flood risk and access to weather updates.',
        estimatedTime: '2–3 minutes',
        category: 'Rain',
        points: 30,
        type: DailyTaskType.counter,
        target: 4,
        unitLabel: 'steps',
      ),
    );
  }

  /// Orders tasks so the most relevant actions appear first for each user.
  List<DailyTask> _prioritiseTasks(
    List<DailyTask> tasks,
    UserPreferences preferences,
  ) {
    int priorityFor(DailyTask task) {
      var priority = 100;

      // Keep the daily conditions check near the top.
      if (task.id == 'review_conditions') {
        priority -= 50;
      }

      // Prioritise exposure-related tasks for users who spend
      // more time outdoors.
      if (preferences.outdoorActivityLevel == OutdoorActivityLevel.high) {
        if (task.category == 'UV' ||
            task.category == 'Heat' ||
            task.category == 'Haze') {
          priority -= 20;
        }
      }

      // Adjust the order using the times the user is usually outdoors.
      if (preferences.outdoorTimes.contains(OutdoorTime.midday) &&
          task.category == 'UV') {
        priority -= 15;
      }

      if (preferences.outdoorTimes.contains(OutdoorTime.morning) &&
          task.category == 'Heat') {
        priority -= 5;
      }

      if (preferences.outdoorTimes.contains(OutdoorTime.evening) &&
          task.category == 'Rain') {
        priority -= 5;
      }

      return priority;
    }

    final prioritised = [...tasks];

    prioritised.sort(
      (a, b) => priorityFor(a).compareTo(priorityFor(b)),
    );

    return prioritised;
  }

  List<DailyTask> _removeDuplicates(List<DailyTask> tasks) {
    final uniqueTasks = <String, DailyTask>{};

    for (final task in tasks) {
      uniqueTasks[task.id] = task;
    }

    return uniqueTasks.values.toList();
  }
}
