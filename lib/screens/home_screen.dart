import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../models/environmental_reading.dart';
import '../providers/app_providers.dart';
import '../services/risk_engine.dart';

/// Gives users an overview of the latest environmental conditions
/// and preparedness guidance for their selected Singapore region.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    final snapshotAsync = ref.watch(snapshotProvider);
    final riskAsync = ref.watch(riskSummaryProvider);
    final region = ref.watch(selectedRegionProvider);

    final preferencesAsync = ref.watch(userPreferencesProvider);

    final largerControlsEnabled =
        preferencesAsync.valueOrNull?.largerControlsEnabled ?? false;

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(snapshotProvider);
        await ref.read(snapshotProvider.future);
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 4,
              ),
              child: Image.asset(
                'assets/images/logo.png',
                width: 75,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.todayInSingapore,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.homeDescription,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 16),
          _RegionSelector(
            selected: region,
            largerControlsEnabled: largerControlsEnabled,
            onChanged: (r) => ref
                .read(
                  selectedRegionProvider.notifier,
                )
                .state = r,
          ),
          const SizedBox(height: 16),
          snapshotAsync.when(
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: CircularProgressIndicator(),
              ),
            ),
            error: (e, _) => _ErrorCard(message: e.toString()),
            data: (snapshot) {
              if (snapshot.error != null) {
                return _ErrorCard(
                  message: snapshot.error!,
                );
              }

              return Column(
                children: [
                  riskAsync.when(
                    data: (risk) => _OverallRiskBanner(
                      summary: risk,
                    ),
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 12),
                  _MetricGrid(
                    snapshot: snapshot,
                    region: region,
                  ),
                  const SizedBox(height: 16),
                  riskAsync.when(
                    data: (risk) => _RecommendationsList(
                      recommendations: risk.recommendations,
                    ),
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.lastUpdated(
                      DateFormat(
                        'd MMM yyyy, HH:mm',
                      ).format(
                        snapshot.fetchedAt,
                      ),
                    ),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Lets users switch between Singapore regions to view
/// environmental conditions relevant to that area.
class _RegionSelector extends StatelessWidget {
  const _RegionSelector({
    required this.selected,
    required this.onChanged,
    required this.largerControlsEnabled,
  });

  final SingaporeRegion selected;
  final ValueChanged<SingaporeRegion> onChanged;
  final bool largerControlsEnabled;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final l10n = AppLocalizations.of(context)!;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: SingaporeRegion.values.map(
        (region) {
          final isSelected = region == selected;

          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              onChanged(region);
            },
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 180,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: largerControlsEnabled ? 26 : 16,
                vertical: largerControlsEnabled ? 18 : 10,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? scheme.primary.withValues(
                        alpha: 0.12,
                      )
                    : scheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? scheme.primary.withValues(
                          alpha: 0.25,
                        )
                      : scheme.outlineVariant,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isSelected) ...[
                    Icon(
                      Icons.check_rounded,
                      size: largerControlsEnabled ? 20 : 16,
                      color: scheme.primary,
                    ),
                    const SizedBox(width: 5),
                  ],
                  Text(
                    _regionLabel(
                      region,
                      l10n,
                    ),
                    style: TextStyle(
                      fontSize: largerControlsEnabled ? 15 : 13,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                      color:
                          isSelected ? scheme.primary : scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  String _regionLabel(
    SingaporeRegion region,
    AppLocalizations l10n,
  ) {
    switch (region) {
      case SingaporeRegion.central:
        return l10n.central;

      case SingaporeRegion.north:
        return l10n.north;

      case SingaporeRegion.south:
        return l10n.south;

      case SingaporeRegion.east:
        return l10n.east;

      case SingaporeRegion.west:
        return l10n.west;
    }
  }
}

/// Summarises the overall environmental risk and gives users
/// a quick indication of the current preparedness level.
class _OverallRiskBanner extends StatelessWidget {
  const _OverallRiskBanner({
    required this.summary,
  });

  final RiskSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final color = riskColor(summary.overallLevel);

    final status = _statusLabel(summary, l10n);

    final message = _statusMessage(summary, l10n);

    return Card(
      color: color.withValues(alpha: 0.10),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(
                  alpha: 0.14,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                Icons.shield_outlined,
                color: color,
                size: 28,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.todaysPreparedness,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    status,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    message,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _statusLabel(
    RiskSummary summary,
    AppLocalizations l10n,
  ) {
    if (summary.floodRisk) {
      return l10n.riskElevated;
    }

    switch (summary.overallLevel) {
      case RiskLevel.good:
        return l10n.riskLow;

      case RiskLevel.moderate:
        return l10n.riskModerate;

      case RiskLevel.high:
        return l10n.riskHigh;

      case RiskLevel.veryHigh:
        return l10n.riskVeryHigh;

      case RiskLevel.extreme:
        return l10n.riskExtreme;
    }
  }

  String _statusMessage(
    RiskSummary summary,
    AppLocalizations l10n,
  ) {
    if (summary.floodRisk) {
      return l10n.floodRiskMessage;
    }

    switch (summary.overallLevel) {
      case RiskLevel.good:
        return l10n.lowRiskMessage;

      case RiskLevel.moderate:
        return l10n.moderateRiskMessage;

      case RiskLevel.high:
        return l10n.highRiskMessage;

      case RiskLevel.veryHigh:
        return l10n.veryHighRiskMessage;

      case RiskLevel.extreme:
        return l10n.extremeRiskMessage;
    }
  }
}

/// Displays the main environmental readings for the selected region,
/// including PSI, UV, temperature and heat stress.
class _MetricGrid extends StatelessWidget {
  const _MetricGrid({
    required this.snapshot,
    required this.region,
  });

  final EnvironmentalSnapshot snapshot;
  final SingaporeRegion region;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final psi = snapshot.psi?.forRegion(region);

    final uv = snapshot.uv?.currentIndex;

    final temperature = snapshot.temperatureForRegion(region);

    final wbgt = snapshot.wbgtForRegion(region);

    final heatStress = snapshot.heatStressForRegion(region);

    final psiRisk = psi != null ? RiskEngine.psiLevel(psi) : null;

    final uvRisk = uv != null ? RiskEngine.uvLevel(uv) : null;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _MetricCard(
                title: l10n.psi24h,
                value: psi?.toString() ?? '—',
                subtitle: psiRisk != null
                    ? _psiLevelLabel(
                        psiRisk,
                        l10n,
                      )
                    : l10n.noData,
                icon: Icons.air,
                color: psiRisk != null ? riskColor(psiRisk) : Colors.grey,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _MetricCard(
                title: l10n.uvIndex,
                value: uv?.toString() ?? '—',
                subtitle: uvRisk != null
                    ? _riskLevelLabel(
                        uvRisk,
                        l10n,
                      )
                    : l10n.noData,
                icon: Icons.wb_sunny_outlined,
                color: uvRisk != null ? riskColor(uvRisk) : Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _MetricCard(
                title: l10n.temperature,
                value: temperature != null
                    ? '${temperature.toStringAsFixed(1)}°C'
                    : '—',
                subtitle: temperature != null
                    ? l10n.regionAverage(
                        _regionLabel(
                          region,
                          l10n,
                        ),
                      )
                    : l10n.noData,
                icon: Icons.thermostat_outlined,
                color: const Color(0xFFF97360),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _MetricCard(
                title: l10n.wbgtHeatStress,
                value: wbgt != null ? '${wbgt.toStringAsFixed(1)}°C' : '—',
                subtitle: heatStress != null
                    ? _heatStressLabel(
                        heatStress,
                        l10n,
                      )
                    : l10n.noData,
                icon: Icons.device_thermostat_outlined,
                color: heatStress == 'High'
                    ? Colors.red
                    : heatStress == 'Moderate'
                        ? Colors.orange
                        : heatStress == 'Low'
                            ? Colors.green
                            : Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _regionLabel(
    SingaporeRegion region,
    AppLocalizations l10n,
  ) {
    switch (region) {
      case SingaporeRegion.central:
        return l10n.central;

      case SingaporeRegion.north:
        return l10n.north;

      case SingaporeRegion.south:
        return l10n.south;

      case SingaporeRegion.east:
        return l10n.east;

      case SingaporeRegion.west:
        return l10n.west;
    }
  }

  String _psiLevelLabel(
    RiskLevel level,
    AppLocalizations l10n,
  ) {
    switch (level) {
      case RiskLevel.good:
        return l10n.psiGood;

      case RiskLevel.moderate:
        return l10n.psiModerate;

      case RiskLevel.high:
        return l10n.psiUnhealthy;

      case RiskLevel.veryHigh:
        return l10n.psiVeryUnhealthy;

      case RiskLevel.extreme:
        return l10n.psiHazardous;
    }
  }

  String _riskLevelLabel(
    RiskLevel level,
    AppLocalizations l10n,
  ) {
    switch (level) {
      case RiskLevel.good:
        return l10n.riskLow;

      case RiskLevel.moderate:
        return l10n.riskModerate;

      case RiskLevel.high:
        return l10n.riskHigh;

      case RiskLevel.veryHigh:
        return l10n.riskVeryHigh;

      case RiskLevel.extreme:
        return l10n.riskExtreme;
    }
  }

  String _heatStressLabel(
    String heatStress,
    AppLocalizations l10n,
  ) {
    switch (heatStress) {
      case 'Low':
        return l10n.riskLow;

      case 'Moderate':
        return l10n.riskModerate;

      case 'High':
        return l10n.riskHigh;

      default:
        return heatStress;
    }
  }
}

/// Reusable card for displaying one environmental reading
/// together with its status and visual indicator.
class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: color,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Displays the preparedness recommendations generated from
/// the current environmental conditions.
class _RecommendationsList extends StatelessWidget {
  const _RecommendationsList({
    required this.recommendations,
  });

  final List<SafetyRecommendation> recommendations;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.whatYouShouldDo,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        ...recommendations.map(
          (rec) => Padding(
            padding: const EdgeInsets.only(
              bottom: 12,
            ),
            child: _RecommendationCard(
              recommendation: rec,
            ),
          ),
        ),
      ],
    );
  }
}

/// Shows one preparedness recommendation with suggested actions
/// and optional details explaining why it is relevant.
class _RecommendationCard extends StatefulWidget {
  const _RecommendationCard({
    required this.recommendation,
  });

  final SafetyRecommendation recommendation;

  @override
  State<_RecommendationCard> createState() => _RecommendationCardState();
}

class _RecommendationCardState extends State<_RecommendationCard> {
  bool _showWhy = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final recommendation = widget.recommendation;

    final localizedTitle = _localizedTitle(
      recommendation,
      l10n,
    );

    final localizedBody = _localizedBody(
      recommendation,
      l10n,
    );

    final localizedActions = _localizedActions(
      recommendation,
      l10n,
    );

    final color = riskColor(
      recommendation.riskLevel,
    );

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: color.withValues(
                      alpha: 0.12,
                    ),
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                  ),
                  child: Icon(
                    _categoryIcon(
                      recommendation.category,
                    ),
                    color: color,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    localizedTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(
                      alpha: 0.12,
                    ),
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: Text(
                    _riskLevelLabel(
                      recommendation.riskLevel,
                      l10n,
                    ),
                    style: TextStyle(
                      color: color,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            if (recommendation.actions.isNotEmpty) ...[
              const SizedBox(height: 16),
              ...List.generate(
                recommendation.actions.take(3).length,
                (index) {
                  final originalAction = recommendation.actions[index];

                  final localizedAction = localizedActions[index];

                  return _ActionRow(
                    action: localizedAction,
                    color: color,
                    icon: _actionIcon(
                      originalAction,
                    ),
                  );
                },
              ),
            ],
            if (localizedBody.trim().isNotEmpty) ...[
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _showWhy = !_showWhy;
                    });
                  },
                  icon: Icon(
                    _showWhy
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.info_outline_rounded,
                    size: 19,
                  ),
                  label: Text(
                    _showWhy ? l10n.showLess : l10n.why,
                  ),
                ),
              ),
              AnimatedCrossFade(
                duration: const Duration(
                  milliseconds: 200,
                ),
                crossFadeState: _showWhy
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                firstChild: const SizedBox.shrink(),
                secondChild: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(
                    14,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .surfaceContainerHighest
                        .withValues(
                          alpha: 0.45,
                        ),
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                  ),
                  child: Text(
                    localizedBody,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.4,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _localizedTitle(
    SafetyRecommendation recommendation,
    AppLocalizations l10n,
  ) {
    switch (recommendation.id) {
      case 'environmental_data_unavailable':
        return l10n.recommendationEnvironmentalDataUnavailable;

      case 'psi_unavailable':
        return l10n.recommendationPsiUnavailable;

      case 'haze':
        final psi = _extractNumber(recommendation.title);

        return psi != null
            ? l10n.recommendationHaze(psi)
            : recommendation.title;

      case 'uv_unavailable':
        return l10n.recommendationUvUnavailable;

      case 'uv_exposure':
        final uv = _extractNumber(recommendation.title);

        return uv != null
            ? l10n.recommendationUvExposure(uv)
            : recommendation.title;

      case 'heavy_rain':
        return l10n.recommendationHeavyRain;

      case 'favourable_conditions':
        return l10n.recommendationFavourable;

      default:
        return recommendation.title;
    }
  }

  String _localizedBody(
    SafetyRecommendation recommendation,
    AppLocalizations l10n,
  ) {
    switch (recommendation.id) {
      case 'environmental_data_unavailable':
        return l10n.recommendationEnvironmentalDataUnavailableBody;

      case 'psi_unavailable':
        return l10n.recommendationPsiUnavailableBody;

      case 'haze':
        return _localizedPsiBody(
          recommendation.riskLevel,
          l10n,
        );

      case 'uv_unavailable':
        return l10n.recommendationUvUnavailableBody;

      case 'uv_exposure':
        return _localizedUvBody(
          recommendation.riskLevel,
          l10n,
        );

      case 'heavy_rain':
        final count = _extractNumber(recommendation.body);

        if (count == null || count == 1) {
          return l10n.heavyRainBodyOne;
        }

        return l10n.heavyRainBodyMany(
          count,
        );

      case 'favourable_conditions':
        return l10n.recommendationFavourableBody;

      default:
        return recommendation.body;
    }
  }

  List<String> _localizedActions(
    SafetyRecommendation recommendation,
    AppLocalizations l10n,
  ) {
    switch (recommendation.id) {
      case 'environmental_data_unavailable':
        return [
          l10n.actionCheckInternetConnection,
          l10n.actionRefreshEnvironmentalData,
          l10n.actionReferOfficialChannels,
        ];

      case 'psi_unavailable':
        return [
          l10n.actionRefreshDataLater,
          l10n.actionReferNeaHazeUpdates,
        ];

      case 'haze':
        return _localizedPsiActions(
          recommendation.riskLevel,
          l10n,
        );

      case 'uv_unavailable':
        return [
          l10n.actionRefreshDataLater,
          l10n.actionSunProtectionExtended,
        ];

      case 'uv_exposure':
        return _localizedUvActions(
          recommendation.riskLevel,
          l10n,
        );

      case 'heavy_rain':
        return [
          l10n.actionAvoidFloodWater,
          l10n.actionCheckPubUpdates,
          l10n.actionAvoidFloodProneRoutes,
          l10n.actionKeepEmergencyDevices,
        ];

      case 'favourable_conditions':
        return [
          l10n.actionContinueMonitoring,
          l10n.actionReviewEmergencyKit,
          l10n.actionCompletePreparednessActivity,
        ];

      default:
        return recommendation.actions;
    }
  }

  String _localizedPsiBody(
    RiskLevel level,
    AppLocalizations l10n,
  ) {
    switch (level) {
      case RiskLevel.good:
        return l10n.psiBodyGood;

      case RiskLevel.moderate:
        return l10n.psiBodyModerate;

      case RiskLevel.high:
        return l10n.psiBodyHigh;

      case RiskLevel.veryHigh:
        return l10n.psiBodyVeryHigh;

      case RiskLevel.extreme:
        return l10n.psiBodyExtreme;
    }
  }

  List<String> _localizedPsiActions(
    RiskLevel level,
    AppLocalizations l10n,
  ) {
    switch (level) {
      case RiskLevel.good:
        return [
          l10n.actionContinueNormalActivities,
          l10n.actionMonitorEnvironmentalUpdates,
        ];

      case RiskLevel.moderate:
        return [
          l10n.actionContinueNormalIfWell,
          l10n.actionMonitorHealthSymptoms,
          l10n.actionCheckPsiBeforeOutdoorActivity,
        ];

      case RiskLevel.high:
        return [
          l10n.actionReduceOutdoorActivity,
          l10n.actionWearN95Appropriate,
          l10n.actionKeepIndoorAirClean,
          l10n.actionSeekMedicalAdvice,
        ];

      case RiskLevel.veryHigh:
        return [
          l10n.actionMinimiseOutdoorActivity,
          l10n.actionRemainIndoors,
          l10n.actionWearN95IfUnavoidable,
          l10n.actionSeekHelpBreathing,
        ];

      case RiskLevel.extreme:
        return [
          l10n.actionAvoidOutdoorActivity,
          l10n.actionCloseDoorsWindows,
          l10n.actionWearN95Outside,
          l10n.actionSeekHelpSeriousSymptoms,
        ];
    }
  }

  String _localizedUvBody(
    RiskLevel level,
    AppLocalizations l10n,
  ) {
    switch (level) {
      case RiskLevel.good:
        return l10n.uvBodyGood;

      case RiskLevel.moderate:
        return l10n.uvBodyModerate;

      case RiskLevel.high:
        return l10n.uvBodyHigh;

      case RiskLevel.veryHigh:
        return l10n.uvBodyVeryHigh;

      case RiskLevel.extreme:
        return l10n.uvBodyExtreme;
    }
  }

  List<String> _localizedUvActions(
    RiskLevel level,
    AppLocalizations l10n,
  ) {
    switch (level) {
      case RiskLevel.good:
        return [
          l10n.actionBasicSunProtection,
        ];

      case RiskLevel.moderate:
        return [
          l10n.actionApplySunscreen,
          l10n.actionWearSunglasses,
          l10n.actionSeekShade,
        ];

      case RiskLevel.high:
        return [
          l10n.actionApplySunscreen,
          l10n.actionReapplySunscreen,
          l10n.actionWearHatSunglassesClothing,
          l10n.actionSeekMiddayShade,
        ];

      case RiskLevel.veryHigh:
        return [
          l10n.actionMinimiseMiddaySun,
          l10n.actionWearProtectiveClothing,
          l10n.actionRegularlyReapplySunscreen,
          l10n.actionTakeShadeBreaks,
        ];

      case RiskLevel.extreme:
        return [
          l10n.actionAvoidMiddaySun,
          l10n.actionUseShadeProtectiveClothing,
          l10n.actionRegularlyReapplySunscreen,
          l10n.actionOutdoorWorkersShadeBreaks,
        ];
    }
  }

  int? _extractNumber(
    String value,
  ) {
    final match = RegExp(r'\d+').firstMatch(value);

    if (match == null) {
      return null;
    }

    return int.tryParse(
      match.group(0)!,
    );
  }

  String _riskLevelLabel(
    RiskLevel level,
    AppLocalizations l10n,
  ) {
    switch (level) {
      case RiskLevel.good:
        return l10n.riskLow;

      case RiskLevel.moderate:
        return l10n.riskModerate;

      case RiskLevel.high:
        return l10n.riskHigh;

      case RiskLevel.veryHigh:
        return l10n.riskVeryHigh;

      case RiskLevel.extreme:
        return l10n.riskExtreme;
    }
  }

  IconData _categoryIcon(
    String category,
  ) {
    final value = category.toLowerCase();

    if (value.contains('haze') || value.contains('air')) {
      return Icons.air_rounded;
    }

    if (value.contains('uv') || value.contains('sun')) {
      return Icons.wb_sunny_outlined;
    }

    if (value.contains('heat')) {
      return Icons.thermostat_outlined;
    }

    if (value.contains('rain') || value.contains('flood')) {
      return Icons.water_drop_outlined;
    }

    return Icons.shield_outlined;
  }

  IconData _actionIcon(
    String action,
  ) {
    final value = action.toLowerCase();

    // Icons for sun and UV protection actions.
    if (value.contains('sunscreen')) {
      return Icons.wb_sunny_outlined;
    }

    if (value.contains('shade')) {
      return Icons.park_outlined;
    }

    if (value.contains('hat') ||
        value.contains('cap') ||
        value.contains(
          'protective clothing',
        )) {
      return Icons.checkroom_outlined;
    }

    // Icons for hydration and heat-related actions.
    if (value.contains('water') ||
        value.contains('hydrat') ||
        value.contains('drink')) {
      return Icons.water_drop_outlined;
    }

    if (value.contains('rest') || value.contains('break')) {
      return Icons.chair_outlined;
    }

    if (value.contains('indoor')) {
      return Icons.home_outlined;
    }

    // Icons for haze and air-quality actions.
    if (value.contains('psi') ||
        value.contains('reading') ||
        value.contains('update')) {
      return Icons.bar_chart_rounded;
    }

    if (value.contains('symptom') ||
        value.contains('heart') ||
        value.contains(
          'respiratory',
        ) ||
        value.contains('health')) {
      return Icons.favorite_outline_rounded;
    }

    if (value.contains('mask')) {
      return Icons.masks_outlined;
    }

    if (value.contains(
          'normal activities',
        ) ||
        value.contains('feel well')) {
      return Icons.directions_walk_rounded;
    }

    // Icons for rain and flood-related actions.
    if (value.contains('umbrella')) {
      return Icons.umbrella_outlined;
    }

    if (value.contains('flood')) {
      return Icons.flood_outlined;
    }

    if (value.contains('rain')) {
      return Icons.water_drop_outlined;
    }

    // Icons for outdoor activity advice.
    if (value.contains('outdoor') ||
        value.contains('exercise') ||
        value.contains('activity')) {
      return Icons.directions_walk_rounded;
    }

    // Icons for actions that warn users to avoid or limit something.
    if (value.contains('avoid') || value.contains('limit')) {
      return Icons.warning_amber_rounded;
    }

    return Icons.check_circle_outline_rounded;
  }
}

/// Reusable row for displaying one recommended preparedness action.
class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.action,
    required this.color,
    required this.icon,
  });

  final String action;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color.withValues(
                alpha: 0.10,
              ),
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            child: Icon(
              icon,
              size: 18,
              color: color,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 5,
              ),
              child: Text(
                action,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Displays environmental data errors without replacing
/// the surrounding Home screen layout.
class _ErrorCard extends StatelessWidget {
  const _ErrorCard({
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      color: isDark
          ? Colors.red.withValues(
              alpha: 0.12,
            )
          : Colors.red.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: isDark ? Colors.red.shade300 : Colors.red,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message),
            ),
          ],
        ),
      ),
    );
  }
}
