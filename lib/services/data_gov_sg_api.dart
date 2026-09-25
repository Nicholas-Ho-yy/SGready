import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/environmental_reading.dart';

/// NEA real-time APIs via data.gov.sg (v2).
/// Docs: https://guide.data.gov.sg/developer-guide/real-time-apis
class DataGovSgApi {
  DataGovSgApi({
    http.Client? client,
    this.apiKey,
  }) : _client = client ?? http.Client();

  static const String _dataGovBaseUrl =
      'https://api-open.data.gov.sg/v2/real-time/api';

  static const String _webProxyUrl =
      'https://sgready-api-proxy.sj-74879.workers.dev';

  static const Duration _requestTimeout = Duration(seconds: 10);
  static const Duration _snapshotCacheDuration = Duration(minutes: 5);
  static const Duration _rainfallCacheDuration = Duration(minutes: 2);

  final http.Client _client;
  final String? apiKey;

  EnvironmentalSnapshot? _cachedSnapshot;
  DateTime? _cachedSnapshotAt;
  Future<EnvironmentalSnapshot>? _snapshotRequest;

  List<RainfallReading>? _cachedRainfall;
  DateTime? _cachedRainfallAt;

  String _urlForPath(String path) {
    if (kIsWeb) {
      final endpoint = path == 'weather?api=wbgt' ? 'wbgt' : path;
      return '$_webProxyUrl/?endpoint=$endpoint';
    }

    return '$_dataGovBaseUrl/$path';
  }

  Map<String, String> get _headers {
    if (apiKey == null || apiKey!.isEmpty) {
      return {};
    }

    return {
      'x-api-key': apiKey!,
    };
  }

  /// Sends a GET request and retries once if the API rate-limits the request.
  Future<http.Response?> _get(String path) async {
    const maxAttempts = 2;

    for (var attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        final response = await _client
            .get(
              Uri.parse(_urlForPath(path)),
              headers: _headers,
            )
            .timeout(_requestTimeout);

        if (response.statusCode != 429) {
          return response;
        }

        if (attempt < maxAttempts) {
          final retryAfterSeconds =
              int.tryParse(response.headers['retry-after'] ?? '');

          final delay = retryAfterSeconds != null
              ? Duration(seconds: retryAfterSeconds)
              : const Duration(milliseconds: 1500);

          await Future.delayed(delay);
        }
      } on TimeoutException {
        if (attempt == maxAttempts) {
          return null;
        }

        await Future.delayed(
          const Duration(milliseconds: 750),
        );
      } catch (_) {
        return null;
      }
    }

    return null;
  }

  Future<PsiReading?> fetchPsi() async {
    try {
      final response = await _get('psi');

      if (response == null || response.statusCode != 200) {
        return null;
      }

      final decoded = jsonDecode(response.body);

      if (decoded is! Map<String, dynamic>) {
        return null;
      }

      if (decoded['code'] != 0) {
        return null;
      }

      final data = decoded['data'];

      if (data is! Map<String, dynamic>) {
        return null;
      }

      final items = data['items'];

      if (items is! List<dynamic> || items.isEmpty) {
        return null;
      }

      final latest = items.last;

      if (latest is! Map<String, dynamic>) {
        return null;
      }

      final readings = latest['readings'];

      if (readings is! Map<String, dynamic>) {
        return null;
      }

      final psiData = readings['psi_twenty_four_hourly'];

      if (psiData is! Map<String, dynamic> || psiData.isEmpty) {
        return null;
      }

      final byRegion = <SingaporeRegion, int>{};

      for (final entry in psiData.entries) {
        final value = entry.value;

        if (value is! num) {
          continue;
        }

        try {
          final region = SingaporeRegion.fromKey(entry.key);
          byRegion[region] = value.toInt();
        } catch (_) {
          // Ignore unexpected region keys instead of crashing the app.
        }
      }

      if (byRegion.isEmpty) {
        return null;
      }

      final timestampValue = latest['timestamp'];
      final updatedTimestampValue = latest['updatedTimestamp'];

      if (timestampValue is! String || updatedTimestampValue is! String) {
        return null;
      }

      return PsiReading(
        timestamp: DateTime.parse(timestampValue),
        updatedAt: DateTime.parse(updatedTimestampValue),
        byRegion: byRegion,
      );
    } on TimeoutException {
      return null;
    } on FormatException {
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<UvReading?> fetchUv() async {
    try {
      final response = await _get('uv');

      if (response == null || response.statusCode != 200) {
        return null;
      }

      final decoded = jsonDecode(response.body);

      if (decoded is! Map<String, dynamic>) {
        return null;
      }

      if (decoded['code'] != 0) {
        return null;
      }

      final data = decoded['data'];

      if (data is! Map<String, dynamic>) {
        return null;
      }

      final records = data['records'];

      if (records is! List<dynamic> || records.isEmpty) {
        return null;
      }

      final latest = records.last;

      if (latest is! Map<String, dynamic>) {
        return null;
      }

      final indexList = latest['index'];

      if (indexList is! List<dynamic> || indexList.isEmpty) {
        return null;
      }

      final history = <UvHourlyPoint>[];

      for (final item in indexList) {
        if (item is! Map<String, dynamic>) {
          continue;
        }

        final hourValue = item['hour'];
        final uvValue = item['value'];

        if (hourValue is! String || uvValue is! num) {
          continue;
        }

        history.add(
          UvHourlyPoint(
            hour: DateTime.parse(hourValue),
            value: uvValue.toInt(),
          ),
        );
      }

      if (history.isEmpty) {
        return null;
      }

      history.sort(
        (a, b) => b.hour.compareTo(a.hour),
      );

      final timestampValue = latest['timestamp'];
      final updatedTimestampValue = latest['updatedTimestamp'];

      if (timestampValue is! String || updatedTimestampValue is! String) {
        return null;
      }

      return UvReading(
        timestamp: DateTime.parse(timestampValue),
        updatedAt: DateTime.parse(updatedTimestampValue),
        currentIndex: history.first.value,
        hourlyHistory: history,
      );
    } on TimeoutException {
      return null;
    } on FormatException {
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<List<WbgtReading>> fetchWbgt() async {
    try {
      final response = await _get('weather?api=wbgt');

      if (response == null || response.statusCode != 200) {
        return [];
      }

      final decoded = jsonDecode(response.body);

      if (decoded is! Map<String, dynamic>) {
        return [];
      }

      if (decoded['code'] != 0) {
        return [];
      }

      final data = decoded['data'];

      if (data is! Map<String, dynamic>) {
        return [];
      }

      final records = data['records'];

      if (records is! List<dynamic> || records.isEmpty) {
        return [];
      }

      final latest = records.last;

      if (latest is! Map<String, dynamic>) {
        return [];
      }

      final datetimeValue = latest['datetime'];

      if (datetimeValue is! String) {
        return [];
      }

      final timestamp = DateTime.parse(datetimeValue);
      final item = latest['item'];

      if (item is! Map<String, dynamic>) {
        return [];
      }

      final readings = item['readings'];

      if (readings is! List<dynamic>) {
        return [];
      }

      final wbgtReadings = <WbgtReading>[];

      for (final reading in readings) {
        if (reading is! Map<String, dynamic>) {
          continue;
        }

        final station = reading['station'];
        final location = reading['location'];
        final wbgtRaw = reading['wbgt'];
        final heatStress = reading['heatStress'];

        if (station is! Map<String, dynamic> ||
            location is! Map<String, dynamic> ||
            heatStress is! String) {
          continue;
        }

        final stationId = station['id'];
        final stationName = station['name'];
        final townCenter = station['townCenter'];

        if (stationId is! String ||
            stationName is! String ||
            townCenter is! String) {
          continue;
        }

        final wbgtValue = double.tryParse(
          wbgtRaw.toString(),
        );

        final latitude = double.tryParse(
          location['latitude'].toString(),
        );

        final longitude = double.tryParse(
          location['longitude'].toString(),
        );

        if (wbgtValue == null || latitude == null || longitude == null) {
          continue;
        }

        wbgtReadings.add(
          WbgtReading(
            stationId: stationId,
            stationName: stationName,
            townCenter: townCenter,
            latitude: latitude,
            longitude: longitude,
            value: wbgtValue,
            heatStress: heatStress,
            timestamp: timestamp,
            region: _wbgtRegionForStation(stationId),
          ),
        );
      }

      return wbgtReadings;
    } on TimeoutException {
      return [];
    } on FormatException {
      return [];
    } catch (_) {
      return [];
    }
  }

  SingaporeRegion _wbgtRegionForStation(String stationId) {
    switch (stationId) {
      // North
      case 'S125':
      case 'S135':
      case 'S140':
      case 'S141':
      case 'S143':
      case 'S184':
        return SingaporeRegion.north;

      // South
      case 'S137':
      case 'S139':
      case 'S142':
      case 'S144':
      case 'S147':
        return SingaporeRegion.south;

      // East
      case 'S124':
      case 'S127':
      case 'S129':
      case 'S148':
      case 'S149':
      case 'S151':
        return SingaporeRegion.east;

      // West
      case 'S126':
      case 'S132':
      case 'S146':
      case 'S153':
      case 'S180':
        return SingaporeRegion.west;

      // Central
      case 'S128':
      case 'S145':
      case 'S150':
      case 'S187':
      default:
        return SingaporeRegion.central;
    }
  }

  Future<List<TemperatureReading>> fetchTemperature() async {
    try {
      final response = await _get('air-temperature');

      if (response == null || response.statusCode != 200) {
        return [];
      }

      final decoded = jsonDecode(response.body);

      if (decoded is! Map<String, dynamic>) {
        return [];
      }

      if (decoded['code'] != 0) {
        return [];
      }

      final data = decoded['data'];

      if (data is! Map<String, dynamic>) {
        return [];
      }

      final stations = data['stations'];

      if (stations is! List<dynamic>) {
        return [];
      }

      final stationNames = <String, String>{};

      for (final station in stations) {
        if (station is! Map<String, dynamic>) {
          continue;
        }

        final id = station['id'];
        final name = station['name'];

        if (id is String && name is String) {
          stationNames[id] = name;
        }
      }

      final readings = data['readings'];

      if (readings is! List<dynamic> || readings.isEmpty) {
        return [];
      }

      final latest = readings.last;

      if (latest is! Map<String, dynamic>) {
        return [];
      }

      final timestampValue = latest['timestamp'];

      if (timestampValue is! String) {
        return [];
      }

      final timestamp = DateTime.parse(timestampValue);
      final stationData = latest['data'];

      if (stationData is! List<dynamic>) {
        return [];
      }

      final temperatureReadings = <TemperatureReading>[];

      for (final item in stationData) {
        if (item is! Map<String, dynamic>) {
          continue;
        }

        final stationId = item['stationId'];
        final value = item['value'];

        if (stationId is! String || value is! num) {
          continue;
        }

        temperatureReadings.add(
          TemperatureReading(
            stationId: stationId,
            stationName: stationNames[stationId] ?? stationId,
            valueCelsius: value.toDouble(),
            timestamp: timestamp,
            region: _temperatureRegionForStation(stationId),
          ),
        );
      }

      return temperatureReadings;
    } on TimeoutException {
      return [];
    } on FormatException {
      return [];
    } catch (_) {
      return [];
    }
  }

  SingaporeRegion _temperatureRegionForStation(String stationId) {
    switch (stationId) {
      // North
      case 'S104': // Woodlands Avenue 9
      case 'S109': // Ang Mo Kio Avenue 5
        return SingaporeRegion.north;

      // South
      case 'S60': // Sentosa
      case 'S102': // Semakau Island
      case 'S117': // Banyan Road
        return SingaporeRegion.south;

      // East
      case 'S06': // Paya Lebar Airport
      case 'S24': // Upper Changi Road North
      case 'S43': // Kim Chuan Road
      case 'S106': // Pulau Ubin
      case 'S107': // East Coast Parkway
        return SingaporeRegion.east;

      // West
      case 'S23':
      case 'S44': // Nanyang Avenue
      case 'S50': // Clementi Road
      case 'S115': // Tuas South Avenue 3
      case 'S116': // West Coast Highway
        return SingaporeRegion.west;

      // Central
      case 'S111': // Scotts Road
      default:
        return SingaporeRegion.central;
    }
  }

  /// Returns stations reporting rainfall above [thresholdMm]
  /// in the latest available reading window.
  Future<List<RainfallReading>> fetchHeavyRainfall({
    double thresholdMm = 50,
  }) async {
    final readings = await fetchRainfall();

    return readings
        .where(
          (reading) => reading.valueMm >= thresholdMm,
        )
        .toList();
  }

  Future<List<RainfallReading>> fetchRainfall() async {
    try {
      final now = DateTime.now();

      if (_cachedRainfall != null &&
          _cachedRainfallAt != null &&
          now.difference(_cachedRainfallAt!) < _rainfallCacheDuration) {
        return _cachedRainfall!;
      }

      final response = await _get('rainfall');

      if (response == null || response.statusCode != 200) {
        return _cachedRainfall ?? [];
      }

      final decoded = jsonDecode(response.body);

      if (decoded is! Map<String, dynamic>) {
        return [];
      }

      if (decoded['code'] != 0) {
        return [];
      }

      final data = decoded['data'];

      if (data is! Map<String, dynamic>) {
        return [];
      }

      // Build a lookup table so each rainfall reading can include
      // its station name and location.
      final stations = data['stations'];
      final stationInfo = <String, RainfallStation>{};

      if (stations is List<dynamic>) {
        for (final station in stations) {
          if (station is! Map<String, dynamic>) {
            continue;
          }

          final id = station['id'];
          final name = station['name'];
          final location = station['location'];

          if (id is! String ||
              name is! String ||
              location is! Map<String, dynamic>) {
            continue;
          }

          final latitude = double.tryParse(
            location['latitude'].toString(),
          );

          final longitude = double.tryParse(
            location['longitude'].toString(),
          );

          if (latitude == null || longitude == null) {
            continue;
          }

          stationInfo[id] = RainfallStation(
            id: id,
            name: name,
            latitude: latitude,
            longitude: longitude,
          );
        }
      }

      final readings = data['readings'];

      if (readings is! List<dynamic> || readings.isEmpty) {
        return [];
      }

      final latest = readings.last;

      if (latest is! Map<String, dynamic>) {
        return [];
      }

      final timestampValue = latest['timestamp'];

      if (timestampValue is! String) {
        return [];
      }

      final timestamp = DateTime.parse(timestampValue);
      final stationData = latest['data'];

      if (stationData is! List<dynamic>) {
        return [];
      }

      final rainfallReadings = <RainfallReading>[];

      for (final item in stationData) {
        if (item is! Map<String, dynamic>) {
          continue;
        }

        final stationId = item['stationId'];
        final value = item['value'];

        if (stationId is! String || value is! num) {
          continue;
        }

        final station = stationInfo[stationId];

        if (station == null) {
          continue;
        }

        rainfallReadings.add(
          RainfallReading(
            stationId: stationId,
            stationName: station.name,
            latitude: station.latitude,
            longitude: station.longitude,
            valueMm: value.toDouble(),
            timestamp: timestamp,
          ),
        );
      }

      _cachedRainfall = rainfallReadings;
      _cachedRainfallAt = DateTime.now();

      return rainfallReadings;
    } on TimeoutException {
      return [];
    } on FormatException {
      return [];
    } catch (_) {
      return [];
    }
  }

  Future<EnvironmentalSnapshot> fetchSnapshot({
    bool forceRefresh = false,
  }) async {
    final now = DateTime.now();

    if (!forceRefresh &&
        _cachedSnapshot != null &&
        _cachedSnapshotAt != null &&
        now.difference(_cachedSnapshotAt!) < _snapshotCacheDuration) {
      return _cachedSnapshot!;
    }

    // Reuse a request that is already running so multiple screens
    // do not send the same group of API requests at the same time.
    if (_snapshotRequest != null) {
      return _snapshotRequest!;
    }

    _snapshotRequest = _fetchSnapshotFromApi();

    try {
      return await _snapshotRequest!;
    } finally {
      _snapshotRequest = null;
    }
  }

  Future<EnvironmentalSnapshot> _fetchSnapshotFromApi() async {
    final psi = await fetchPsi();
    await Future.delayed(const Duration(milliseconds: 300));

    final uv = await fetchUv();
    await Future.delayed(const Duration(milliseconds: 300));

    final wbgtReadings = await fetchWbgt();
    await Future.delayed(const Duration(milliseconds: 300));

    final temperatureReadings = await fetchTemperature();
    await Future.delayed(const Duration(milliseconds: 300));

    final heavyRain = await fetchHeavyRainfall(
      thresholdMm: 50,
    );

    String? error;

    if (psi == null &&
        uv == null &&
        wbgtReadings.isEmpty &&
        temperatureReadings.isEmpty &&
        heavyRain.isEmpty) {
      // Keep the previous successful data if the APIs are temporarily
      // unavailable instead of clearing the whole dashboard.
      if (_cachedSnapshot != null) {
        return _cachedSnapshot!;
      }

      error =
          'Environmental data is currently unavailable. Please try again later.';
    }

    final snapshot = EnvironmentalSnapshot(
      psi: psi,
      uv: uv,
      wbgtReadings: wbgtReadings,
      temperatureReadings: temperatureReadings,
      heavyRainStations: heavyRain,
      fetchedAt: DateTime.now(),
      error: error,
    );

    if (error == null) {
      _cachedSnapshot = snapshot;
      _cachedSnapshotAt = DateTime.now();
    }

    return snapshot;
  }

  void dispose() {
    _client.close();
  }
}