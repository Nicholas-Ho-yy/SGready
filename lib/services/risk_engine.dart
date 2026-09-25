import '../models/environmental_reading.dart';

/// Converts environmental readings into risk levels
/// and produces an overall risk summary for the selected region.
class RiskEngine {
  const RiskEngine._();

  static RiskLevel psiLevel(int psi) {
    if (psi <= 50) return RiskLevel.good;
    if (psi <= 100) return RiskLevel.moderate;
    if (psi <= 200) return RiskLevel.high;
    if (psi <= 300) return RiskLevel.veryHigh;
    return RiskLevel.extreme;
  }

  static RiskLevel uvLevel(int uvi) {
    if (uvi <= 2) return RiskLevel.good;
    if (uvi <= 5) return RiskLevel.moderate;
    if (uvi <= 7) return RiskLevel.high;
    if (uvi <= 10) return RiskLevel.veryHigh;
    return RiskLevel.extreme;
  }

  static RiskLevel temperatureLevel(double temperature) {
    if (temperature < 30) {
      return RiskLevel.good;
    }

    if (temperature < 32) {
      return RiskLevel.moderate;
    }

    if (temperature < 34) {
      return RiskLevel.high;
    }

    if (temperature < 36) {
      return RiskLevel.veryHigh;
    }

    return RiskLevel.extreme;
  }

  static RiskLevel wbgtLevel(String heatStress) {
    switch (heatStress.trim().toLowerCase()) {
      case 'low':
        return RiskLevel.good;

      case 'moderate':
        return RiskLevel.moderate;

      case 'high':
        return RiskLevel.high;

      default:
        return RiskLevel.good;
    }
  }

  static String psiLabel(RiskLevel level) {
    switch (level) {
      case RiskLevel.good:
        return 'Good';

      case RiskLevel.moderate:
        return 'Moderate';

      case RiskLevel.high:
        return 'Unhealthy';

      case RiskLevel.veryHigh:
        return 'Very Unhealthy';

      case RiskLevel.extreme:
        return 'Hazardous';
    }
  }

  static String uvLabel(RiskLevel level) {
    switch (level) {
      case RiskLevel.good:
        return 'Low';

      case RiskLevel.moderate:
        return 'Moderate';

      case RiskLevel.high:
        return 'High';

      case RiskLevel.veryHigh:
        return 'Very High';

      case RiskLevel.extreme:
        return 'Extreme';
    }
  }

  static String temperatureLabel(RiskLevel level) {
    switch (level) {
      case RiskLevel.good:
        return 'Comfortable';

      case RiskLevel.moderate:
        return 'Warm';

      case RiskLevel.high:
        return 'Hot';

      case RiskLevel.veryHigh:
        return 'Very Hot';

      case RiskLevel.extreme:
        return 'Extreme Heat';
    }
  }

  static RiskSummary analyze({
    required EnvironmentalSnapshot snapshot,
    required SingaporeRegion region,
  }) {
    final hasPsiData = snapshot.psi != null;

    final hasUvData = snapshot.uv != null;

    final psiValue = hasPsiData ? snapshot.psi!.forRegion(region) : 0;

    final uvValue = hasUvData ? snapshot.uv!.currentIndex : 0;

    final psiRisk = hasPsiData ? psiLevel(psiValue) : RiskLevel.good;

    final uvRisk = hasUvData ? uvLevel(uvValue) : RiskLevel.good;

    final floodRisk = snapshot.heavyRainStations.isNotEmpty;

    final availableRiskLevels = <RiskLevel>[
      if (hasPsiData) psiRisk,
      if (hasUvData) uvRisk,
      if (floodRisk) RiskLevel.high,
    ];

    // RiskLevel has no unknown state, so unavailable data falls back to
    // good while the guidance message explains that readings are unavailable.
    final overall = availableRiskLevels.isEmpty
        ? RiskLevel.good
        : _highestRisk(
            availableRiskLevels,
          );

    final recommendations = GuidanceService.recommendations(
      psiLevel: psiRisk,
      uvLevel: uvRisk,
      floodRisk: floodRisk,
      psiValue: psiValue,
      uvValue: uvValue,
      heavyRainCount: snapshot.heavyRainStations.length,
      hasPsiData: hasPsiData,
      hasUvData: hasUvData,
      snapshotError: snapshot.error,
    );

    return RiskSummary(
      overallLevel: overall,
      psiLevel: psiRisk,
      uvLevel: uvRisk,
      floodRisk: floodRisk,
      recommendations: recommendations,
      region: region,
    );
  }

  static RiskLevel _highestRisk(Iterable<RiskLevel> levels) {
    return levels.reduce(
      (currentHighest, candidate) =>
          _severity(candidate) > _severity(currentHighest)
              ? candidate
              : currentHighest,
    );
  }

  static int _severity(RiskLevel level) {
    switch (level) {
      case RiskLevel.good:
        return 0;

      case RiskLevel.moderate:
        return 1;

      case RiskLevel.high:
        return 2;

      case RiskLevel.veryHigh:
        return 3;

      case RiskLevel.extreme:
        return 4;
    }
  }
}

/// Builds safety guidance based on the calculated environmental risks.
class GuidanceService {
  const GuidanceService._();

  static List<SafetyRecommendation> recommendations({
    required RiskLevel psiLevel,
    required RiskLevel uvLevel,
    required bool floodRisk,
    required int psiValue,
    required int uvValue,
    required int heavyRainCount,
    required bool hasPsiData,
    required bool hasUvData,
    String? snapshotError,
  }) {
    final recommendations = <SafetyRecommendation>[];

    if (!hasPsiData && !hasUvData && !floodRisk) {
      recommendations.add(
        SafetyRecommendation(
          id: 'environmental_data_unavailable',
          title: 'Environmental data unavailable',
          body: snapshotError ??
              'Current environmental readings could not be retrieved. '
                  'Please try refreshing the data later.',
          riskLevel: RiskLevel.good,
          category: 'System',
          actions: const [
            'Check your internet connection',
            'Refresh the environmental data',
            'Refer to official NEA and PUB channels if conditions appear unsafe',
          ],
        ),
      );

      return recommendations;
    }

    if (!hasPsiData) {
      recommendations.add(
        const SafetyRecommendation(
          id: 'psi_unavailable',
          title: 'PSI reading unavailable',
          body: 'The latest air-quality reading could not be retrieved.',
          riskLevel: RiskLevel.good,
          category: 'System',
          actions: [
            'Refresh the data later',
            'Refer to official NEA haze updates when planning outdoor activity',
          ],
        ),
      );
    } else if (psiLevel.index >= RiskLevel.moderate.index) {
      recommendations.add(
        SafetyRecommendation(
          id: 'haze',
          title: 'Haze / Air Quality (PSI $psiValue)',
          body: _psiBody(psiLevel),
          riskLevel: psiLevel,
          category: 'Haze',
          actions: _psiActions(psiLevel),
        ),
      );
    }

    if (!hasUvData) {
      recommendations.add(
        const SafetyRecommendation(
          id: 'uv_unavailable',
          title: 'UV reading unavailable',
          body: 'The latest ultraviolet-index reading could not be retrieved.',
          riskLevel: RiskLevel.good,
          category: 'System',
          actions: [
            'Refresh the data later',
            'Use sun protection when spending extended periods outdoors',
          ],
        ),
      );
    } else if (uvLevel.index >= RiskLevel.moderate.index) {
      recommendations.add(
        SafetyRecommendation(
          id: 'uv_exposure',
          title: 'UV Exposure (Index $uvValue)',
          body: _uvBody(uvLevel),
          riskLevel: uvLevel,
          category: 'UV',
          actions: _uvActions(uvLevel),
        ),
      );
    }

    if (floodRisk) {
      recommendations.add(
        SafetyRecommendation(
          id: 'heavy_rain',
          title: 'Heavy Rainfall Alert',
          body: heavyRainCount == 1
              ? 'One weather station is reporting rainfall above the '
                  'configured heavy-rain threshold. Flooding may occur '
                  'in vulnerable or low-lying areas.'
              : '$heavyRainCount weather stations are reporting rainfall '
                  'above the configured heavy-rain threshold. Flooding may '
                  'occur in vulnerable or low-lying areas.',
          riskLevel: RiskLevel.high,
          category: 'Flood',
          actions: const [
            'Avoid entering moving or deep flood water',
            'Check official PUB flood and heavy-rain updates',
            'Avoid flood-prone or low-lying routes',
            'Keep a charged phone, torch and power bank available',
          ],
        ),
      );
    }

    if (recommendations.isEmpty) {
      recommendations.add(
        const SafetyRecommendation(
          id: 'favourable_conditions',
          title: 'Conditions look favourable',
          body: 'Current available PSI and UV readings are within lower-risk '
              'ranges, and no heavy-rain threshold has been detected.',
          riskLevel: RiskLevel.good,
          category: 'General',
          actions: [
            'Continue monitoring environmental updates',
            'Review your emergency kit and preparedness checklist',
            'Complete a preparedness activity to maintain awareness',
          ],
        ),
      );
    }

    return recommendations;
  }

  static String _psiBody(
    RiskLevel level,
  ) {
    switch (level) {
      case RiskLevel.good:
        return 'Air quality is within the Good range.';

      case RiskLevel.moderate:
        return 'Air quality is within the Moderate range. Most people can '
            'continue normal activities, while vulnerable individuals '
            'should monitor their health and symptoms.';

      case RiskLevel.high:
        return 'Air quality is Unhealthy. Reduce prolonged or strenuous '
            'outdoor activity, particularly if you are vulnerable to air '
            'pollution.';

      case RiskLevel.veryHigh:
        return 'Air quality is Very Unhealthy. Minimise outdoor activity '
            'and reduce exposure where possible.';

      case RiskLevel.extreme:
        return 'Air quality is Hazardous. Remain indoors where possible '
            'and minimise exposure to outdoor air.';
    }
  }

  static List<String> _psiActions(
    RiskLevel level,
  ) {
    switch (level) {
      case RiskLevel.good:
        return const [
          'Continue normal activities',
          'Monitor official environmental updates',
        ];

      case RiskLevel.moderate:
        return const [
          'Continue normal activities if you feel well',
          'Monitor symptoms if you have heart or respiratory conditions',
          'Check updated PSI readings before prolonged outdoor activity',
        ];

      case RiskLevel.high:
        return const [
          'Reduce prolonged or strenuous outdoor activity',
          'Wear a properly fitted N95 mask when appropriate',
          'Keep indoor air as clean as reasonably possible',
          'Seek medical advice if you feel unwell',
        ];

      case RiskLevel.veryHigh:
        return const [
          'Minimise outdoor activity',
          'Remain indoors where possible',
          'Wear a properly fitted N95 mask if outdoor exposure is unavoidable',
          'Seek medical help if breathing difficulties develop',
        ];

      case RiskLevel.extreme:
        return const [
          'Avoid outdoor activity where possible',
          'Remain indoors with doors and windows closed',
          'Wear a properly fitted N95 mask if you must go outside',
          'Seek medical help promptly if you experience serious symptoms',
        ];
    }
  }

  static String _uvBody(
    RiskLevel level,
  ) {
    switch (level) {
      case RiskLevel.good:
        return 'UV exposure is Low. Minimal protection is normally required.';

      case RiskLevel.moderate:
        return 'UV exposure is Moderate. Use sun protection during extended '
            'periods outdoors.';

      case RiskLevel.high:
        return 'UV exposure is High. Use sunscreen, protective clothing and '
            'shade, especially around midday.';

      case RiskLevel.veryHigh:
        return 'UV exposure is Very High. Minimise direct midday sun exposure '
            'and use comprehensive sun protection.';

      case RiskLevel.extreme:
        return 'UV exposure is Extreme. Avoid unnecessary direct sun exposure '
            'during peak hours and use comprehensive protection.';
    }
  }

  static List<String> _uvActions(
    RiskLevel level,
  ) {
    switch (level) {
      case RiskLevel.good:
        return const [
          'Use basic sun protection during extended outdoor exposure',
        ];

      case RiskLevel.moderate:
        return const [
          'Apply broad-spectrum SPF 30+ sunscreen',
          'Wear sunglasses during extended outdoor activity',
          'Seek shade when practical',
        ];

      case RiskLevel.high:
        return const [
          'Apply broad-spectrum SPF 30+ sunscreen',
          'Reapply sunscreen according to product directions',
          'Wear a hat, sunglasses and protective clothing',
          'Seek shade during midday hours',
        ];

      case RiskLevel.veryHigh:
        return const [
          'Minimise direct sun exposure around midday',
          'Wear protective clothing, a hat and sunglasses',
          'Apply and regularly reapply SPF 30+ sunscreen',
          'Take regular shade breaks when working outdoors',
        ];

      case RiskLevel.extreme:
        return const [
          'Avoid unnecessary direct sun exposure around midday',
          'Use shade and protective clothing',
          'Apply and regularly reapply SPF 30+ sunscreen',
          'Outdoor workers should take frequent shaded rest breaks',
        ];
    }
  }
}
