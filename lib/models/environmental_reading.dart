// SGReady Final Year Project
// Developed by: Nicholas Ho
//
// This file was developed by me for SGReady. It contains the data models
// used to store environmental readings and the risk information used by
// other parts of the application.
//
// The environmental readings represented by these models come from the
// data.gov.sg APIs. The Dart models and processing methods in this file
// were implemented by me for the application.

/// Common risk levels used throughout SGReady.
///
/// I use the same levels across the different environmental conditions
/// so that risks can be compared using one consistent scale.
enum RiskLevel {
  good,
  moderate,
  high,
  veryHigh,
  extreme;

  // Converts the enum into text that can be shown in the interface.
  String get label {
    switch (this) {
      case RiskLevel.good:
        return 'Good';
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

  // Gives each risk level a number so I can compare which condition
  // is more serious. A larger number means a higher risk.
  int get severity {
    switch (this) {
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

/// Regions used by SGReady when displaying environmental readings
/// for different parts of Singapore.
enum SingaporeRegion {
  north,
  south,
  east,
  west,
  central;

  // Gives each region a readable name for the user interface.
  String get label {
    switch (this) {
      case SingaporeRegion.north:
        return 'North';
      case SingaporeRegion.south:
        return 'South';
      case SingaporeRegion.east:
        return 'East';
      case SingaporeRegion.west:
        return 'West';
      case SingaporeRegion.central:
        return 'Central';
    }
  }

  // Converts a region name received as text into the matching enum.
  // I normalise the text first so differences in spaces or capital
  // letters do not affect the result.
  static SingaporeRegion fromKey(String key) {
    final normalizedKey = key.trim().toLowerCase();

    for (final region in SingaporeRegion.values) {
      if (region.name == normalizedKey) {
        return region;
      }
    }

    // Throw an error if the value cannot be matched to a known region.
    throw FormatException(
      'Unknown Singapore region key: $key',
    );
  }

  // Safe version of fromKey(). Instead of throwing an error for an
  // unknown region, it returns null so the caller can handle it.
  static SingaporeRegion? tryFromKey(String key) {
    try {
      return fromKey(key);
    } on FormatException {
      return null;
    }
  }
}

/// Stores a PSI reading and the PSI values available for each region.
class PsiReading {
  const PsiReading({
    required this.timestamp,
    required this.updatedAt,
    required this.byRegion,
  });

  final DateTime timestamp;
  final DateTime updatedAt;
  final Map<SingaporeRegion, int> byRegion;

  bool get hasRegionalData => byRegion.isNotEmpty;

  // Find the highest PSI value across all available regions.
  // This is also useful as a fallback when a particular region
  // does not have a reading.
  int get nationalMax {
    if (byRegion.isEmpty) {
      return 0;
    }

    return byRegion.values.reduce(
      (currentMaximum, value) =>
          value > currentMaximum ? value : currentMaximum,
    );
  }

  // Return null when there is no PSI reading for the requested region.
  int? forRegionOrNull(SingaporeRegion region) {
    return byRegion[region];
  }

  // Return the regional PSI when possible, otherwise use the highest
  // available PSI so that the app still has a value to work with.
  int forRegion(SingaporeRegion region) {
    return byRegion[region] ?? nationalMax;
  }
}

/// Stores the latest UV Index together with the available hourly history.
class UvReading {
  const UvReading({
    required this.timestamp,
    required this.updatedAt,
    required this.currentIndex,
    required this.hourlyHistory,
  });

  final DateTime timestamp;
  final DateTime updatedAt;
  final int currentIndex;
  final List<UvHourlyPoint> hourlyHistory;

  bool get hasHistory => hourlyHistory.isNotEmpty;
}

/// Stores one UV Index reading for a particular hour.
class UvHourlyPoint {
  const UvHourlyPoint({
    required this.hour,
    required this.value,
  });

  final DateTime hour;
  final int value;
}

/// Stores a Wet Bulb Globe Temperature (WBGT) reading from an
/// environmental monitoring station.
class WbgtReading {
  const WbgtReading({
    required this.stationId,
    required this.stationName,
    required this.townCenter,
    required this.latitude,
    required this.longitude,
    required this.value,
    required this.heatStress,
    required this.timestamp,
    required this.region,
  });

  final String stationId;
  final String stationName;
  final String townCenter;

  // Coordinates are kept because they are also used for location-based
  // features such as finding a nearby station.
  final double latitude;
  final double longitude;

  final double value;

  // Heat-stress category returned together with the WBGT data.
  // The expected values are Low, Moderate or High.
  final String heatStress;

  final DateTime timestamp;

  final SingaporeRegion region;
}

/// Stores the location and identity of a rainfall monitoring station.
class RainfallStation {
  const RainfallStation({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  final String id;
  final String name;
  final double latitude;
  final double longitude;
}

/// Stores a rainfall observation recorded at one monitoring station.
class RainfallReading {
  const RainfallReading({
    required this.stationId,
    required this.stationName,
    required this.latitude,
    required this.longitude,
    required this.valueMm,
    required this.timestamp,
  });

  final String stationId;
  final String stationName;

  // Coordinates allow the Explore screen to work out which rainfall
  // observation is nearest to the user.
  final double latitude;
  final double longitude;

  // Rainfall amount reported in millimetres.
  final double valueMm;
  final DateTime timestamp;
}

/// Stores a temperature reading and the SGReady region it belongs to.
class TemperatureReading {
  const TemperatureReading({
    required this.stationId,
    required this.stationName,
    required this.valueCelsius,
    required this.timestamp,
    required this.region,
  });

  final String stationId;
  final String stationName;
  final double valueCelsius;
  final DateTime timestamp;
  final SingaporeRegion region;
}

/// Combines the latest environmental information into one object.
///
/// Some APIs may return data while another one may be unavailable, so
/// these values are kept separately instead of requiring every dataset
/// to be present at the same time.
class EnvironmentalSnapshot {
  const EnvironmentalSnapshot({
    required this.psi,
    required this.uv,
    required this.wbgtReadings,
    required this.temperatureReadings,
    required this.heavyRainStations,
    required this.fetchedAt,
    this.error,
  });

  final PsiReading? psi;
  final UvReading? uv;
  final List<WbgtReading> wbgtReadings;
  final List<TemperatureReading> temperatureReadings;
  final List<RainfallReading> heavyRainStations;
  final DateTime fetchedAt;
  final String? error;

  // Work out the average temperature for stations in the selected region.
  // Null is returned if there is no temperature data for that region.
  double? temperatureForRegion(SingaporeRegion region) {
    final readings = temperatureReadings
        .where((reading) => reading.region == region)
        .toList();

    if (readings.isEmpty) {
      return null;
    }

    final total = readings.fold<double>(
      0,
      (sum, reading) => sum + reading.valueCelsius,
    );

    return total / readings.length;
  }

  // Work out the average WBGT reading for the selected region.
  double? wbgtForRegion(SingaporeRegion region) {
    final readings =
        wbgtReadings.where((reading) => reading.region == region).toList();

    if (readings.isEmpty) {
      return null;
    }

    final total = readings.fold<double>(
      0,
      (sum, reading) => sum + reading.value,
    );

    return total / readings.length;
  }

  // Find the most serious heat-stress level reported by any station
  // within the selected region.
  String? heatStressForRegion(SingaporeRegion region) {
    final readings =
        wbgtReadings.where((reading) => reading.region == region).toList();

    if (readings.isEmpty) {
      return null;
    }

    // High takes priority because only one high station is needed for
    // the regional result to be treated as High.
    if (readings.any(
      (reading) => reading.heatStress.toLowerCase() == 'high',
    )) {
      return 'High';
    }

    // If there are no High readings, check for Moderate next.
    if (readings.any(
      (reading) => reading.heatStress.toLowerCase() == 'moderate',
    )) {
      return 'Moderate';
    }

    return 'Low';
  }

  bool get hasPsiData => psi != null;

  // Check whether at least one of the environmental APIs returned
  // something that the application can use.
  bool get hasData =>
      psi != null ||
      uv != null ||
      wbgtReadings.isNotEmpty ||
      temperatureReadings.isNotEmpty ||
      heavyRainStations.isNotEmpty;

  bool get hasHeavyRainData => heavyRainStations.isNotEmpty;

  // An empty error message is not treated as an actual error.
  bool get hasError {
    return error != null && error!.trim().isNotEmpty;
  }
}

/// Stores one piece of preparedness advice that can be shown to the user
/// after the environmental conditions have been interpreted.
class SafetyRecommendation {
  const SafetyRecommendation({
    required this.id,
    required this.title,
    required this.body,
    required this.riskLevel,
    required this.category,
    required this.actions,
  });

  // A fixed ID makes it easier for the app to recognise the same
  // recommendation for localisation and UI handling.
  // Examples are haze, uv_exposure and heavy_rain.
  final String id;

  final String title;
  final String body;
  final RiskLevel riskLevel;
  final String category;
  final List<String> actions;
}

/// Groups the calculated environmental risks and recommendations for
/// the region currently being viewed by the user.
class RiskSummary {
  const RiskSummary({
    required this.overallLevel,
    required this.psiLevel,
    required this.uvLevel,
    required this.floodRisk,
    required this.recommendations,
    required this.region,
  });

  final RiskLevel overallLevel;
  final RiskLevel psiLevel;
  final RiskLevel uvLevel;
  final bool floodRisk;
  final List<SafetyRecommendation> recommendations;
  final SingaporeRegion region;

  bool get hasRecommendations => recommendations.isNotEmpty;

  // The first recommendation is treated as the main recommendation.
  // Return null when there are no recommendations instead of causing
  // an error by trying to access an empty list.
  SafetyRecommendation? get primaryRecommendation {
    if (recommendations.isEmpty) {
      return null;
    }

    return recommendations.first;
  }
}
