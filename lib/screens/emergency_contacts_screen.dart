import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

/// Gives users quick access to important emergency and support
/// contact numbers in Singapore.
class EmergencyContactsScreen extends StatelessWidget {
  const EmergencyContactsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.emergencyHelpTitle,
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: scheme.errorContainer.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.emergency_rounded,
                        color: scheme.error,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          l10n.emergencyInEmergency,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    l10n.emergencyImmediateDangerDescription,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.emergencyServices,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            _EmergencyContactCard(
              icon: Icons.local_fire_department_outlined,
              title: l10n.emergencyFireRescueTitle,
              number: '995',
              description: l10n.emergencyFireRescueDescription,
              accentColor: Colors.red,
            ),
            const SizedBox(height: 12),
            _EmergencyContactCard(
              icon: Icons.local_police_outlined,
              title: l10n.emergencyPoliceTitle,
              number: '999',
              description: l10n.emergencyPoliceDescription,
              accentColor: Colors.blue,
            ),
            const SizedBox(height: 24),
            Text(
              l10n.emergencySms,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            _EmergencyContactCard(
              icon: Icons.sms_outlined,
              title: l10n.emergencyPoliceSmsTitle,
              number: '70999',
              description: l10n.emergencyPoliceSmsDescription,
              accentColor: Colors.blue,
            ),
            const SizedBox(height: 12),
            _EmergencyContactCard(
              icon: Icons.accessibility_new_rounded,
              title: l10n.emergencyScdfSmsTitle,
              number: '70995',
              description: l10n.emergencyScdfSmsDescription,
              accentColor: Colors.teal,
            ),
            const SizedBox(height: 24),
            Text(
              l10n.emergencyOtherUsefulContacts,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            _EmergencyContactCard(
              icon: Icons.health_and_safety_outlined,
              title: 'NurseFirst',
              number: '6262 6262',
              description: l10n.emergencyNurseFirstDescription,
              accentColor: Colors.green,
            ),
            const SizedBox(height: 12),
            _EmergencyContactCard(
              icon: Icons.eco_outlined,
              title: l10n.emergencyNeaHotline,
              number: '6225 5632',
              description: l10n.emergencyNeaDescription,
              accentColor: Colors.green,
            ),
            const SizedBox(height: 24),
            const _WhenToCallCard(),
            const SizedBox(height: 24),
            Text(
              l10n.emergencyDisclaimer,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

/// Reusable card for displaying an emergency service and its contact number.
class _EmergencyContactCard extends StatelessWidget {
  const _EmergencyContactCard({
    required this.icon,
    required this.title,
    required this.number,
    required this.description,
    required this.accentColor,
  });

  final IconData icon;
  final String title;
  final String number;
  final String description;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: accentColor,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    number,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
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
}

/// Helps users understand when a situation requires emergency
/// or non-emergency assistance.
class _WhenToCallCard extends StatelessWidget {
  const _WhenToCallCard();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.help_outline_rounded,
                  color: scheme.primary,
                ),
                const SizedBox(width: 10),
                Text(
                  l10n.emergencyWhenToCall,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _GuideRow(
              icon: Icons.warning_amber_rounded,
              title: l10n.emergencyEmergencyLabel,
              description: l10n.emergencyEmergencyGuide,
            ),
            const SizedBox(height: 14),
            _GuideRow(
              icon: Icons.info_outline_rounded,
              title: l10n.emergencyNonEmergencyLabel,
              description: l10n.emergencyNonEmergencyGuide,
            ),
          ],
        ),
      ),
    );
  }
}

/// Reusable row for the guidance shown in the "When to call" section.
class _GuideRow extends StatelessWidget {
  const _GuideRow({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 22,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 3),
              Text(description),
            ],
          ),
        ),
      ],
    );
  }
}
