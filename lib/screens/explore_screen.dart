import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_providers.dart';
import '../models/environmental_reading.dart';

/// Lets users explore heat stress, PSI and rainfall conditions
/// across Singapore using an interactive map.
class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  String _selectedLayer = 'heat';

  /// Uses the user's location to find the most relevant reading nearby.
  ///
  /// Rain and heat use the nearest monitoring station, while PSI uses
  /// the Singapore region that roughly matches the user's location.
  Future<void> _findConditionsNearMe() async {
    final l10n = AppLocalizations.of(context)!;

    try {
      var permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              l10n.exploreLocationAccessNeeded,
            ),
          ),
        );

        return;
      }

      final position = await Geolocator.getCurrentPosition();

      if (!mounted) return;

      // Find the nearest rainfall station.
      if (_selectedLayer == 'rain') {
        final readings = await ref.read(
          rainfallProvider.future,
        );

        if (readings.isEmpty) {
          if (!mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                l10n.exploreNoRainfallStations,
              ),
            ),
          );

          return;
        }

        RainfallReading? nearestStation;
        double? nearestDistance;

        for (final reading in readings) {
          final distance = Geolocator.distanceBetween(
            position.latitude,
            position.longitude,
            reading.latitude,
            reading.longitude,
          );

          if (nearestDistance == null || distance < nearestDistance) {
            nearestDistance = distance;
            nearestStation = reading;
          }
        }

        if (!mounted || nearestStation == null) {
          return;
        }

        _showRainDetails(
          nearestStation,
          distanceMetres: nearestDistance,
        );

        return;
      }

      // Match the user's location to the appropriate PSI region.
      if (_selectedLayer == 'psi') {
        final snapshot = await ref.read(
          snapshotProvider.future,
        );

        final psi = snapshot.psi;

        if (psi == null || !psi.hasRegionalData) {
          if (!mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                l10n.exploreNoRegionalPsiNearby,
              ),
            ),
          );

          return;
        }

        final region = _regionFromLocation(
          position.latitude,
          position.longitude,
        );

        final value = psi.forRegionOrNull(region);

        if (value == null) {
          if (!mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                l10n.exploreUnableFindPsiArea,
              ),
            ),
          );

          return;
        }

        if (!mounted) return;

        _showPsiDetails(
          region,
          value,
          fromNearMe: true,
        );

        return;
      }

      // Find the nearest heat stress monitoring station.
      final snapshot = await ref.read(
        snapshotProvider.future,
      );

      final readings = snapshot.wbgtReadings;

      if (readings.isEmpty) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              l10n.exploreNoWbgtStations,
            ),
          ),
        );

        return;
      }

      WbgtReading? nearestStation;
      double? nearestDistance;

      for (final reading in readings) {
        final distance = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          reading.latitude,
          reading.longitude,
        );

        if (nearestDistance == null || distance < nearestDistance) {
          nearestDistance = distance;
          nearestStation = reading;
        }
      }

      if (!mounted || nearestStation == null) {
        return;
      }

      _showHeatStationDetails(
        nearestStation,
        distanceMetres: nearestDistance,
      );
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n.exploreUnableFindNearby,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final snapshotAsync = ref.watch(snapshotProvider);

    final rainfallAsync = ref.watch(rainfallProvider);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          l10n.exploreTitle,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),

        const SizedBox(height: 4),

        Text(
          l10n.exploreDescription,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),

        const SizedBox(height: 20),

        // Environmental layer selector
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: _buildLayerButton(
                  value: 'heat',
                  label: l10n.exploreHeat,
                  icon: Icons.thermostat_outlined,
                ),
              ),
              Expanded(
                child: _buildLayerButton(
                  value: 'psi',
                  label: l10n.explorePsi,
                  icon: Icons.air,
                ),
              ),
              Expanded(
                child: _buildLayerButton(
                  value: 'rain',
                  label: l10n.exploreRain,
                  icon: Icons.water_drop_outlined,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 28),

        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _findConditionsNearMe,
            icon: const Icon(
              Icons.my_location_rounded,
            ),
            label: Text(
              l10n.exploreFindNearMe,
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Singapore environmental map
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: AspectRatio(
              aspectRatio: 1.65,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      Positioned.fill(
                        child: SvgPicture.asset(
                          'assets/images/singapore_map.svg',
                          fit: BoxFit.contain,
                          colorFilter: ColorFilter.mode(
                            Colors.blueGrey.shade200,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),

                      // Heat markers
                      if (_selectedLayer == 'heat')
                        snapshotAsync.when(
                          loading: () => const SizedBox.shrink(),
                          error: (error, stackTrace) => const SizedBox.shrink(),
                          data: (snapshot) {
                            return Stack(
                              children: snapshot.wbgtReadings
                                  .map(
                                    (reading) => _buildHeatMarker(
                                      reading,
                                      constraints.maxWidth,
                                      constraints.maxHeight,
                                    ),
                                  )
                                  .toList(),
                            );
                          },
                        ),

                      // PSI markers
                      if (_selectedLayer == 'psi')
                        snapshotAsync.when(
                          loading: () => const SizedBox.shrink(),
                          error: (error, stackTrace) => const SizedBox.shrink(),
                          data: (snapshot) {
                            final psi = snapshot.psi;

                            if (psi == null || !psi.hasRegionalData) {
                              return const SizedBox.shrink();
                            }

                            return Stack(
                              children: SingaporeRegion.values.map(
                                (region) {
                                  final value = psi.forRegionOrNull(
                                    region,
                                  );

                                  if (value == null) {
                                    return const SizedBox.shrink();
                                  }

                                  return _buildPsiMarker(
                                    region,
                                    value,
                                    constraints.maxWidth,
                                    constraints.maxHeight,
                                  );
                                },
                              ).toList(),
                            );
                          },
                        ),

                      // Rain markers
                      if (_selectedLayer == 'rain')
                        rainfallAsync.when(
                          loading: () => const SizedBox.shrink(),
                          error: (error, stackTrace) => const SizedBox.shrink(),
                          data: (readings) {
                            return Stack(
                              children: readings
                                  .where(
                                    (reading) => reading.valueMm > 0,
                                  )
                                  .map(
                                    (reading) => _buildRainMarker(
                                      reading,
                                      constraints.maxWidth,
                                      constraints.maxHeight,
                                    ),
                                  )
                                  .toList(),
                            );
                          },
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.touch_app_outlined,
              size: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 6),
            Text(
              l10n.exploreTapMarker,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        // Heat legend
        if (_selectedLayer == 'heat')
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem(
                l10n.exploreLow,
                Colors.green,
              ),
              const SizedBox(width: 20),
              _buildLegendItem(
                l10n.exploreModerate,
                Colors.orange,
              ),
              const SizedBox(width: 20),
              _buildLegendItem(
                l10n.exploreHigh,
                Colors.red,
              ),
            ],
          ),

        // PSI legend
        if (_selectedLayer == 'psi')
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 8,
            children: [
              _buildLegendItem(
                l10n.psiGood,
                Colors.green,
              ),
              const SizedBox(width: 20),
              _buildLegendItem(
                l10n.psiModerate,
                Colors.yellow,
              ),
              const SizedBox(width: 20),
              _buildLegendItem(
                l10n.psiUnhealthy,
                Colors.orange,
              ),
              const SizedBox(width: 20),
              _buildLegendItem(
                l10n.psiVeryUnhealthy,
                Colors.red,
              ),
            ],
          ),

        if (_selectedLayer == 'heat' || _selectedLayer == 'psi')
          const SizedBox(height: 16),

        // Rainfall summary / empty state
        if (_selectedLayer == 'rain')
          rainfallAsync.when(
            loading: () => const Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            error: (error, stackTrace) => Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  l10n.exploreUnableLoadRain,
                ),
              ),
            ),
            data: (readings) {
              final rainingStations = readings
                  .where(
                    (reading) => reading.valueMm > 0,
                  )
                  .toList();

              if (rainingStations.isEmpty) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.water_drop_outlined,
                          color: Colors.blue.shade400,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.exploreNoRainfall,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                l10n.exploreNoRainfallDescription,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final highest = rainingStations.reduce(
                (a, b) => a.valueMm >= b.valueMm ? a : b,
              );

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.water_drop_outlined,
                            color: Colors.blue.shade600,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            l10n.exploreRainfall,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.exploreStationsReportingRain(
                          rainingStations.length,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        l10n.exploreHighestObserved,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${highest.valueMm.toStringAsFixed(1)} mm',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        highest.stationName,
                      ),
                      const SizedBox(height: 14),
                      Divider(
                        color: Theme.of(context)
                            .colorScheme
                            .outlineVariant
                            .withValues(alpha: 0.6),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.lightbulb_outline_rounded,
                            size: 18,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: l10n.exploreForYou,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  TextSpan(
                                    text: _localizedRainAdvice(
                                      highest.valueMm,
                                      l10n,
                                    ),
                                  ),
                                ],
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    height: 1.35,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

        // PSI summary
        if (_selectedLayer == 'psi')
          snapshotAsync.when(
            loading: () => const Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            error: (error, stackTrace) => Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  l10n.exploreUnableLoadPsi,
                ),
              ),
            ),
            data: (snapshot) {
              final psi = snapshot.psi;

              if (psi == null || !psi.hasRegionalData) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      l10n.exploreNoRegionalPsi,
                    ),
                  ),
                );
              }

              SingaporeRegion? highestRegion;
              int? highestValue;

              for (final region in SingaporeRegion.values) {
                final value = psi.forRegionOrNull(region);

                if (value != null &&
                    (highestValue == null || value > highestValue)) {
                  highestValue = value;
                  highestRegion = region;
                }
              }

              if (highestValue == null || highestRegion == null) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      l10n.exploreNoRegionalPsi,
                    ),
                  ),
                );
              }

              final status = _localizedPsiStatus(
                highestValue,
                l10n,
              );

              final advice = _localizedPsiAdvice(
                highestValue,
                l10n,
              );

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.air_rounded,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            l10n.exploreAirQuality,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.exploreSingaporeRegionalPsi,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        l10n.exploreHighestObserved,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$highestValue · $status',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${_localizedRegion(highestRegion, l10n)} Singapore',
                      ),
                      const SizedBox(height: 14),
                      Divider(
                        color: Theme.of(context)
                            .colorScheme
                            .outlineVariant
                            .withValues(
                              alpha: 0.6,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.lightbulb_outline_rounded,
                            size: 18,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: l10n.exploreForYou,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  TextSpan(
                                    text: advice,
                                  ),
                                ],
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    height: 1.35,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

        const SizedBox(height: 16),

        // Heat summary
        if (_selectedLayer == 'heat')
          snapshotAsync.when(
            loading: () => const Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            error: (error, stackTrace) => Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  l10n.exploreUnableLoadHeat,
                ),
              ),
            ),
            data: (snapshot) {
              final readings = snapshot.wbgtReadings;

              if (readings.isEmpty) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      l10n.exploreNoWbgtObservations,
                    ),
                  ),
                );
              }

              final hottest = readings.reduce(
                (a, b) => a.value >= b.value ? a : b,
              );

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.thermostat_outlined,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            l10n.exploreHeatStress,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.exploreWbgtStationsReporting(
                          readings.length,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        l10n.exploreHighestObserved,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${hottest.value.toStringAsFixed(1)}°C · '
                        '${_localizedHeatStress(hottest.heatStress, l10n)}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        hottest.townCenter.isNotEmpty
                            ? hottest.townCenter
                            : hottest.stationName,
                      ),
                      const SizedBox(height: 14),
                      Divider(
                        color: Theme.of(context)
                            .colorScheme
                            .outlineVariant
                            .withValues(alpha: 0.6),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.lightbulb_outline_rounded,
                            size: 18,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: l10n.exploreForYou,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  TextSpan(
                                    text: l10n.exploreHeatAdvice,
                                  ),
                                ],
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    height: 1.35,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
      ],
    );
  }

  /// Places a heat stress station on the Singapore map using its
  /// latitude and longitude.
  Widget _buildHeatMarker(
    WbgtReading reading,
    double mapWidth,
    double mapHeight,
  ) {
    const minLongitude = 103.60;
    const maxLongitude = 104.10;
    const minLatitude = 1.20;
    const maxLatitude = 1.48;

    final x =
        (reading.longitude - minLongitude) / (maxLongitude - minLongitude);

    final y = (maxLatitude - reading.latitude) / (maxLatitude - minLatitude);

    final left = x * mapWidth;
    final top = y * mapHeight;

    const tapSize = 40.0;

    return Positioned(
      left: left - tapSize / 2,
      top: top - tapSize / 2,
      child: Tooltip(
        message: reading.stationName,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () {
            _showHeatStationDetails(reading);
          },
          child: SizedBox(
            width: tapSize,
            height: tapSize,
            child: Center(
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: _heatMarkerColor(
                    reading.heatStress,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 3,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Opens the details for a heat stress station selected from the map
  /// or found using the user's location.
  void _showHeatStationDetails(
    WbgtReading reading, {
    double? distanceMetres,
  }) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;

        final location = reading.townCenter.trim().isNotEmpty
            ? reading.townCenter
            : reading.stationName;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              24,
              4,
              24,
              24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: _heatMarkerColor(
                          reading.heatStress,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        location,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
                if (distanceMetres != null) ...[
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.near_me_rounded,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        distanceMetres < 1000
                            ? l10n.exploreMetresAway(
                                distanceMetres.round(),
                              )
                            : l10n.exploreKilometresAway(
                                (distanceMetres / 1000).toStringAsFixed(1),
                              ),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ],
                if (reading.stationName != location) ...[
                  const SizedBox(height: 4),
                  Text(
                    reading.stationName,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
                const SizedBox(height: 24),
                _buildDetailRow(
                  'WBGT',
                  '${reading.value.toStringAsFixed(1)}°C',
                ),
                const SizedBox(height: 12),
                _buildDetailRow(
                  l10n.exploreHeatStressLabel,
                  _localizedHeatStress(
                    reading.heatStress,
                    l10n,
                  ),
                ),
                const SizedBox(height: 12),
                _buildDetailRow(
                  l10n.exploreRegion,
                  _localizedRegion(
                    reading.region,
                    l10n,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.exploreLatestStationReading,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(
    String label,
    String value,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(
    String label,
    Color color,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  /// Places a regional PSI reading at its approximate position on the map.
  Widget _buildPsiMarker(
    SingaporeRegion region,
    int value,
    double mapWidth,
    double mapHeight,
  ) {
    final position = _psiRegionPosition(region);

    final left = position.$1 * mapWidth;
    final top = position.$2 * mapHeight;

    return Positioned(
      left: left - 24,
      top: top - 24,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          _showPsiDetails(
            region,
            value,
          );
        },
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: _psiColor(value),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            boxShadow: const [
              BoxShadow(
                blurRadius: 4,
                color: Colors.black26,
              ),
            ],
          ),
          child: Center(
            child: Text(
              '$value',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Places a rainfall station on the Singapore map using its
  /// latitude and longitude.
  Widget _buildRainMarker(
    RainfallReading reading,
    double mapWidth,
    double mapHeight,
  ) {
    const minLongitude = 103.60;
    const maxLongitude = 104.10;
    const minLatitude = 1.20;
    const maxLatitude = 1.48;

    final x =
        (reading.longitude - minLongitude) / (maxLongitude - minLongitude);

    final y = (maxLatitude - reading.latitude) / (maxLatitude - minLatitude);

    final left = x * mapWidth;
    final top = y * mapHeight;

    const tapSize = 40.0;

    return Positioned(
      left: left - tapSize / 2,
      top: top - tapSize / 2,
      child: Tooltip(
        message: reading.stationName,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () {
            _showRainDetails(reading);
          },
          child: SizedBox(
            width: tapSize,
            height: tapSize,
            child: Center(
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: _rainColor(
                    reading.valueMm,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 3,
                      color: Colors.black26,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.water_drop,
                  size: 11,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds one of the Heat, PSI or Rain controls used to switch
  /// the environmental layer shown on the map.
  Widget _buildLayerButton({
    required String value,
    required String label,
    required IconData icon,
  }) {
    final selected = _selectedLayer == value;
    final scheme = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        setState(() {
          _selectedLayer = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: selected ? scheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              selected ? Icons.check_rounded : icon,
              size: 17,
              color: selected ? scheme.onPrimary : scheme.onSurfaceVariant,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                color: selected ? scheme.onPrimary : scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Shows the selected region's PSI reading together with its
  /// air-quality status and preparedness advice.
  void _showPsiDetails(
    SingaporeRegion region,
    int value, {
    bool fromNearMe = false,
  }) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;

        final status = _localizedPsiStatus(
          value,
          l10n,
        );

        final advice = _localizedPsiAdvice(
          value,
          l10n,
        );

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              24,
              4,
              24,
              24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: _psiColor(value),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '${_localizedRegion(region, l10n)} Singapore',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
                if (fromNearMe) ...[
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.near_me_rounded,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          l10n.exploreBasedOnLocation,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 24),
                _buildDetailRow(
                  'PSI',
                  '$value',
                ),
                const SizedBox(height: 12),
                _buildDetailRow(
                  l10n.exploreAirQualityLabel,
                  status,
                ),
                const SizedBox(height: 20),
                Text(
                  advice,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Shows the selected rainfall station's latest reading and intensity.
  void _showRainDetails(
    RainfallReading reading, {
    double? distanceMetres,
  }) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              24,
              4,
              24,
              24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: _rainColor(
                          reading.valueMm,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reading.stationName,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          if (distanceMetres != null) ...[
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(
                                  Icons.near_me_rounded,
                                  size: 16,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  distanceMetres < 1000
                                      ? l10n.exploreMetresAway(
                                          distanceMetres.round(),
                                        )
                                      : l10n.exploreKilometresAway(
                                          (distanceMetres / 1000)
                                              .toStringAsFixed(1),
                                        ),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 24),
                _buildDetailRow(
                  l10n.exploreRainfall,
                  '${reading.valueMm.toStringAsFixed(1)} mm',
                ),
                const SizedBox(height: 12),
                _buildDetailRow(
                  l10n.exploreRainIntensity,
                  _localizedRainStatus(
                    reading.valueMm,
                    l10n,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.exploreLatestRainfallReading,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  SingaporeRegion _regionFromLocation(
    double latitude,
    double longitude,
  ) {
    // PSI is reported by region, so coordinates are mapped to an
    // approximate Singapore region rather than a specific station.
    if (latitude >= 1.39) {
      return SingaporeRegion.north;
    }

    if (latitude <= 1.28) {
      return SingaporeRegion.south;
    }

    if (longitude >= 103.90) {
      return SingaporeRegion.east;
    }

    if (longitude <= 103.76) {
      return SingaporeRegion.west;
    }

    return SingaporeRegion.central;
  }

  String _localizedPsiStatus(
    int value,
    AppLocalizations l10n,
  ) {
    if (value <= 50) {
      return l10n.psiGood;
    }

    if (value <= 100) {
      return l10n.psiModerate;
    }

    if (value <= 200) {
      return l10n.psiUnhealthy;
    }

    if (value <= 300) {
      return l10n.psiVeryUnhealthy;
    }

    return l10n.psiHazardous;
  }

  String _localizedPsiAdvice(
    int value,
    AppLocalizations l10n,
  ) {
    if (value <= 50) {
      return l10n.explorePsiAdviceGood;
    }

    if (value <= 100) {
      return l10n.explorePsiAdviceModerate;
    }

    if (value <= 200) {
      return l10n.explorePsiAdviceUnhealthy;
    }

    if (value <= 300) {
      return l10n.explorePsiAdviceVeryUnhealthy;
    }

    return l10n.explorePsiAdviceHazardous;
  }

  String _localizedRegion(
    SingaporeRegion region,
    AppLocalizations l10n,
  ) {
    switch (region) {
      case SingaporeRegion.north:
        return l10n.north;
      case SingaporeRegion.south:
        return l10n.south;
      case SingaporeRegion.east:
        return l10n.east;
      case SingaporeRegion.west:
        return l10n.west;
      case SingaporeRegion.central:
        return l10n.central;
    }
  }

  String _localizedRainStatus(
    double valueMm,
    AppLocalizations l10n,
  ) {
    if (valueMm < 2.5) {
      return l10n.exploreRainLight;
    }

    if (valueMm < 7.5) {
      return l10n.exploreRainModerate;
    }

    return l10n.exploreRainHeavy;
  }

  String _localizedRainAdvice(
    double valueMm,
    AppLocalizations l10n,
  ) {
    if (valueMm < 2.5) {
      return l10n.exploreRainAdviceLight;
    }

    if (valueMm < 7.5) {
      return l10n.exploreRainAdviceModerate;
    }

    return l10n.exploreRainAdviceHeavy;
  }

  String _localizedHeatStress(
    String heatStress,
    AppLocalizations l10n,
  ) {
    switch (heatStress.trim().toLowerCase()) {
      case 'high':
        return l10n.exploreHigh;
      case 'moderate':
        return l10n.exploreModerate;
      default:
        return l10n.exploreLow;
    }
  }

  Color _heatMarkerColor(String heatStress) {
    switch (heatStress.trim().toLowerCase()) {
      case 'high':
        return Colors.red;

      case 'moderate':
        return Colors.orange;

      default:
        return Colors.green;
    }
  }
}

(double, double) _psiRegionPosition(
  SingaporeRegion region,
) {
  switch (region) {
    case SingaporeRegion.north:
      return (0.48, 0.25);

    case SingaporeRegion.south:
      return (0.50, 0.72);

    case SingaporeRegion.east:
      return (0.76, 0.49);

    case SingaporeRegion.west:
      return (0.24, 0.50);

    case SingaporeRegion.central:
      return (0.50, 0.48);
  }
}

Color _psiColor(int psi) {
  if (psi <= 50) {
    return Colors.green;
  }

  if (psi <= 100) {
    return Colors.orange;
  }

  if (psi <= 200) {
    return Colors.red;
  }

  if (psi <= 300) {
    return Colors.purple;
  }

  return Colors.deepPurple.shade900;
}

Color _rainColor(double valueMm) {
  if (valueMm < 2.5) {
    return Colors.lightBlue;
  }

  if (valueMm < 7.5) {
    return Colors.blue;
  }

  return Colors.indigo;
}
