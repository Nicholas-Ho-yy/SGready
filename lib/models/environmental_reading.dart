/// Common risk levels used throughout SGReady to keep environmental
/// conditions and recommendations on a consistent severity scale.
enum RiskLevel {
  good,
  moderate,
  high,
  veryHigh,
  extreme;

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

  /// Numeric ordering used when different environmental risks need
  /// to be compared. A higher value represents a more severe condition.
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

/// Regions used to group environmental readings across Singapore.
enum SingaporeRegion {
  north,
  south,
  east,
  west,
  central;

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

  /// Converts a text region key into its corresponding Singapore region.
  /// An unknown key is treated as invalid data.
  static SingaporeRegion fromKey(String key) {
    final normalizedKey = key.trim().toLowerCase();

    for (final region in SingaporeRegion.values) {
      if (region.name == normalizedKey) {
        return region;
      }
    }

    throw FormatException(
      'Unknown Singapore region key: $key',
    );
  }

  /// Attempts to convert a region key without throwing an exception.
  static SingaporeRegion? tryFromKey(String key) {
    try {
      return fromKey(key);
    } on FormatException {
      return null;
    }
  }
}

/// Stores a PSI observation together with the values reported
/// for each Singapore region.
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

  /// Returns the highest available regional PSI value.
  /// This is also used as a fallback when a specific region has no reading.
  int get nationalMax {
    if (byRegion.isEmpty) {
      return 0;
    }

    return byRegion.values.reduce(
      (currentMaximum, value) =>
          value > currentMaximum ? value : currentMaximum,
    );
  }

  int? forRegionOrNull(SingaporeRegion region) {
    return byRegion[region];
  }

  /// Returns the regional PSI when available, otherwise the national maximum.
  int forRegion(SingaporeRegion region) {
    return byRegion[region] ?? nationalMax;
  }
}

/// Stores the latest UV Index together with the available
/// hourly UV history.
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

/// Represents one UV Index value at a specific hour.
class UvHourlyPoint {
  const UvHourlyPoint({
    required this.hour,
    required this.value,
  });

  final DateTime hour;
  final int value;
}

/// Represents a Wet Bulb Globe Temperature (WBGT) reading from
/// an environmental monitoring station.
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

  final double latitude;
  final double longitude;

  final double value;

  /// Official value returned by the WBGT API:
  /// Low, Moderate or High.
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

/// Represents a rainfall observation recorded at a monitoring station.
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

  final double latitude;
  final double longitude;

  /// Rainfall amount reported in millimetres.
  final double valueMm;
  final DateTime timestamp;
}

/// Represents a temperature observation associated with a
/// Singapore region.
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

/// Groups the latest environmental information used by SGReady
/// into a single snapshot.
///
/// Individual readings may be unavailable because the source datasets
/// are retrieved independently. Screens and services can therefore use
/// the available data without assuming that every indicator is present.
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

  /// Returns the average temperature from stations mapped to the
  /// requested region, or null when no regional readings are available.
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

  /// Returns the average WBGT from stations mapped to the requested
  /// region, or null when no regional readings are available.
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

  /// Returns the most severe heat-stress category reported within
  /// the requested region.
  ///
  /// High takes priority over Moderate, followed by Low. Null is
  /// returned when the region has no WBGT readings.
  String? heatStressForRegion(SingaporeRegion region) {
    final readings =
        wbgtReadings.where((reading) => reading.region == region).toList();

    if (readings.isEmpty) {
      return null;
    }

    if (readings.any(
      (reading) => reading.heatStress.toLowerCase() == 'high',
    )) {
      return 'High';
    }

    if (readings.any(
      (reading) => reading.heatStress.toLowerCase() == 'moderate',
    )) {
      return 'Moderate';
    }

    return 'Low';
  }

  bool get hasPsiData => psi != null;

  /// Indicates whether at least one environmental dataset contains
  /// usable information.
  bool get hasData =>
      psi != null ||
      uv != null ||
      wbgtReadings.isNotEmpty ||
      temperatureReadings.isNotEmpty ||
      heavyRainStations.isNotEmpty;

  bool get hasHeavyRainData => heavyRainStations.isNotEmpty;

  bool get hasError {
    return error != null && error!.trim().isNotEmpty;
  }
}

/// Represents user-facing preparedness guidance produced from
/// the interpreted environmental conditions.
class SafetyRecommendation {
  const SafetyRecommendation({
    required this.id,
    required this.title,
    required this.body,
    required this.riskLevel,
    required this.category,
    required this.actions,
  });

  /// Stable identifier used for localisation and UI logic.
  ///
  /// Examples include `haze`, `uv_exposure`, `heavy_rain` and
  /// `favourable_conditions`.
  final String id;

  final String title;
  final String body;
  final RiskLevel riskLevel;
  final String category;
  final List<String> actions;
}

/// Collects the interpreted environmental risk for a region together
/// with the preparedness recommendations generated for the user.
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

  SafetyRecommendation? get primaryRecommendation {
    if (recommendations.isEmpty) {
      return null;
    }

    return recommendations.first;
  }
}
