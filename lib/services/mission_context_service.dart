import '../models/environmental_reading.dart';
import '../models/mission_context.dart';
import 'risk_engine.dart';

/// Builds the main preparedness message shown to the user.
///
/// It looks at the latest PSI, UV, heat stress and heavy rain conditions,
/// then chooses the most relevant safety message for the current situation.
class MissionContextService {
  const MissionContextService();

  /// Generates a preparedness context from the latest environmental data.
  MissionContext generate({
    required EnvironmentalSnapshot snapshot,
    required SingaporeRegion region,
    DateTime? currentTime,
  }) {
    final now = currentTime ?? DateTime.now();

    // Read the latest environmental values for the selected region.
    final psiValue = snapshot.psi?.forRegion(region);
    final uvValue = snapshot.uv?.currentIndex;
    final heatStress = snapshot.heatStressForRegion(region);
    final heavyRainDetected = snapshot.heavyRainStations.isNotEmpty;

    // Convert raw readings into risk levels used by the app.
    final psiLevel = psiValue == null ? null : RiskEngine.psiLevel(psiValue);

    final uvLevel = uvValue == null ? null : RiskEngine.uvLevel(uvValue);

    final heatLevel =
        heatStress == null ? null : RiskEngine.wbgtLevel(heatStress);

    // Prepare readable labels for the UI.
    final psiLabel =
        psiLevel == null ? 'No data' : RiskEngine.psiLabel(psiLevel);

    final uvLabel = uvLevel == null ? 'No data' : RiskEngine.uvLabel(uvLevel);

    final heatStressLabel = heatLevel == null ? 'No data' : heatLevel.label;

    // These flags decide which preparedness message should be shown first.
    final hazeRelevant =
        psiLevel != null && psiLevel.index >= RiskLevel.moderate.index;

    final uvRelevant =
        uvLevel != null && uvLevel.index >= RiskLevel.moderate.index;

    final heatRelevant =
        heatLevel != null && heatLevel.index >= RiskLevel.moderate.index;

    final overallRisk = _overallRiskLabel(
      psiLevel: psiLevel,
      uvLevel: uvLevel,
      heatLevel: heatLevel,
      heavyRainDetected: heavyRainDetected,
    );

    final greeting = _greetingFor(now);

    // Heavy rain takes priority because it may affect travel and safety.
    if (heavyRainDetected) {
      return MissionContext(
        focus: MissionFocus.rain,
        greeting: greeting,
        title: 'Rain preparedness is recommended',
        message:
            'Heavy rainfall may affect travel and outdoor plans. Review today’s rain and flood-safety actions.',
        overallRiskLabel: overallRisk,
        psiValue: psiValue,
        psiLabel: psiLabel,
        uvValue: uvValue,
        uvLabel: uvLabel,
        heatStress: heatStress,
        heatStressLabel: heatStressLabel,
        heavyRainDetected: true,
      );
    }

    // Show combined guidance when both heat and UV are elevated.
    if (heatRelevant && uvRelevant) {
      return MissionContext(
        focus: MissionFocus.uv,
        greeting: greeting,
        title: 'Heat and UV precautions are recommended',
        message:
            'Heat stress and UV exposure may affect outdoor activity today. Stay hydrated, use sun protection and take regular cooling breaks.',
        overallRiskLabel: overallRisk,
        psiValue: psiValue,
        psiLabel: psiLabel,
        uvValue: uvValue,
        uvLabel: uvLabel,
        heatStress: heatStress,
        heatStressLabel: heatStressLabel,
        heavyRainDetected: false,
      );
    }

    if (heatRelevant) {
      return MissionContext(
        focus: MissionFocus.general,
        greeting: greeting,
        title: 'Heat precautions are recommended',
        message:
            'Heat stress is elevated today. Stay hydrated, take cooling breaks and reduce strenuous outdoor activity where possible.',
        overallRiskLabel: overallRisk,
        psiValue: psiValue,
        psiLabel: psiLabel,
        uvValue: uvValue,
        uvLabel: uvLabel,
        heatStress: heatStress,
        heatStressLabel: heatStressLabel,
        heavyRainDetected: false,
      );
    }

    // If haze and UV are both relevant, show guidance for both.
    if (hazeRelevant && uvRelevant) {
      return MissionContext(
        focus: MissionFocus.hazeAndUv,
        greeting: greeting,
        title: 'Air-quality and UV precautions are recommended',
        message:
            'Review both air-quality and sun-protection actions before spending time outdoors.',
        overallRiskLabel: overallRisk,
        psiValue: psiValue,
        psiLabel: psiLabel,
        uvValue: uvValue,
        uvLabel: uvLabel,
        heatStress: heatStress,
        heatStressLabel: heatStressLabel,
        heavyRainDetected: false,
      );
    }

    if (hazeRelevant) {
      return MissionContext(
        focus: MissionFocus.haze,
        greeting: greeting,
        title: 'Air-quality precautions are recommended',
        message:
            'Monitor the PSI and adjust prolonged outdoor activities where necessary.',
        overallRiskLabel: overallRisk,
        psiValue: psiValue,
        psiLabel: psiLabel,
        uvValue: uvValue,
        uvLabel: uvLabel,
        heatStress: heatStress,
        heatStressLabel: heatStressLabel,
        heavyRainDetected: false,
      );
    }

    if (uvRelevant) {
      return MissionContext(
        focus: MissionFocus.uv,
        greeting: greeting,
        title: 'UV protection is recommended',
        message:
            'Sun protection and hydration may be important for outdoor activities today.',
        overallRiskLabel: overallRisk,
        psiValue: psiValue,
        psiLabel: psiLabel,
        uvValue: uvValue,
        uvLabel: uvLabel,
        heatStress: heatStress,
        heatStressLabel: heatStressLabel,
        heavyRainDetected: false,
      );
    }

    // Default message when no major environmental risk is detected.
    return MissionContext(
      focus: MissionFocus.general,
      greeting: greeting,
      title: 'Conditions are generally manageable',
      message:
          'Review today’s readings and complete the basic preparedness actions.',
      overallRiskLabel: overallRisk,
      psiValue: psiValue,
      psiLabel: psiLabel,
      uvValue: uvValue,
      uvLabel: uvLabel,
      heatStress: heatStress,
      heatStressLabel: heatStressLabel,
      heavyRainDetected: false,
    );
  }

  /// Returns a greeting based on the user's current time.
  String _greetingFor(DateTime time) {
    if (time.hour < 12) {
      return 'Good morning';
    }

    if (time.hour < 18) {
      return 'Good afternoon';
    }

    return 'Good evening';
  }

  /// Returns the highest overall environmental risk currently detected.
  String _overallRiskLabel({
    required RiskLevel? psiLevel,
    required RiskLevel? uvLevel,
    required RiskLevel? heatLevel,
    required bool heavyRainDetected,
  }) {
    if (heavyRainDetected) {
      return 'High';
    }

    final levels = <RiskLevel>[
      if (psiLevel != null) psiLevel,
      if (uvLevel != null) uvLevel,
      if (heatLevel != null) heatLevel,
    ];

    if (levels.isEmpty) {
      return 'Unknown';
    }

    final highest = levels.reduce(
      (current, next) {
        return current.index >= next.index ? current : next;
      },
    );

    switch (highest) {
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
}
