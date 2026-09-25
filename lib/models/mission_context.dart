/// Identifies the environmental condition that should receive the
/// most attention in the user's current preparedness mission.
enum MissionFocus {
  general,
  haze,
  uv,
  hazeAndUv,
  rain,
}

/// Brings together the current environmental conditions and the
/// user-facing context needed to personalise the Today experience.
///
/// The context is used to explain why particular preparedness actions
/// are relevant to the user under the current conditions.
class MissionContext {
  const MissionContext({
    required this.focus,
    required this.greeting,
    required this.title,
    required this.message,
    required this.overallRiskLabel,
    required this.psiValue,
    required this.psiLabel,
    required this.uvValue,
    required this.uvLabel,
    required this.heatStress,
    required this.heatStressLabel,
    required this.heavyRainDetected,
  });

  final MissionFocus focus;

  /// Time-sensitive greeting shown at the top of the mission banner.
  final String greeting;

  /// Short explanation of the current environmental focus.
  final String title;

  /// Supporting summary for the user.
  final String message;

  /// Overall interpreted risk, such as Low, Moderate or High.
  final String overallRiskLabel;

  final int? psiValue;
  final String psiLabel;

  final int? uvValue;
  final String uvLabel;

  final String? heatStress;
  final String heatStressLabel;

  final bool heavyRainDetected;

  /// Formats the environmental values into concise labels for display.
  String get psiDisplay {
    return 'PSI ${psiValue ?? '—'} · $psiLabel';
  }

  String get uvDisplay {
    return 'UV ${uvValue ?? '—'} · $uvLabel';
  }

  String get heatDisplay {
    return 'Heat stress · $heatStressLabel';
  }
}
