import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_preferences.dart';
import '../providers/app_providers.dart';

/// Introduces new users to SGReady and collects a few preferences
/// used to personalise their preparedness experience.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();

  int _currentPage = 0;
  bool _isSaving = false;

  String _homeRegion = 'Central';

  OutdoorActivityLevel _activityLevel = OutdoorActivityLevel.moderate;

  final Set<OutdoorTime> _outdoorTimes = {
    OutdoorTime.midday,
  };

  bool _remindersEnabled = true;

  static const List<_OnboardingPageData> _pages = [
    _OnboardingPageData(
      icon: Icons.cloud_outlined,
      title: 'Stay informed',
      description:
          'See live PSI, UV, heat stress, temperature and rainfall conditions across Singapore.',
      highlight: 'Know what conditions are like before you head out.',
    ),
    _OnboardingPageData(
      icon: Icons.today_outlined,
      title: 'Prepare every day',
      description:
          'Get simple preparedness tasks based on current environmental conditions.',
      highlight: 'Small actions each day can help you stay ready.',
    ),
    _OnboardingPageData(
      icon: Icons.school_outlined,
      title: 'Learn & stay ready',
      description:
          'Build your emergency kit, complete quizzes and scenarios, and earn XP and badges.',
      highlight:
          'Learn practical preparedness skills while tracking your progress.',
    ),
  ];

  static const List<String> _regions = [
    'Central',
    'North',
    'South',
    'East',
    'West',
  ];

  int get _totalPages => _pages.length + 1;

  bool get _isPersonalisationPage => _currentPage == _pages.length;

  /// Saves the user's selected preferences and marks onboarding
  /// as completed for their Firebase account.
  Future<void> _finishOnboarding() async {
    if (_isSaving) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final preferences = UserPreferences(
        homeRegion: _homeRegion,
        outdoorActivityLevel: _activityLevel,
        outdoorTimes: _outdoorTimes,
        preparednessRemindersEnabled: _remindersEnabled,
      );

      final service = ref.read(userPreferencesServiceProvider);

      await service.savePreferences(preferences);

      ref.invalidate(userPreferencesProvider);

      ref.read(selectedRegionProvider.notifier).state =
          regionFromPreference(_homeRegion);

      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception(
          'No authenticated user found.',
        );
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'onboardingCompleted': true,
      });
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isSaving = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Unable to save your preferences. Please try again.',
          ),
        ),
      );
    }
  }

  /// Skips personalisation and marks onboarding as completed
  /// without changing the user's default preferences.
  Future<void> _skipOnboarding() async {
    if (_isSaving) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception(
          'No authenticated user found.',
        );
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'onboardingCompleted': true,
      });
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isSaving = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Unable to complete onboarding. Please try again.',
          ),
        ),
      );
    }
  }

  void _nextPage() {
    if (_isPersonalisationPage) {
      _finishOnboarding();
      return;
    }

    _pageController.nextPage(
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeOut,
    );
  }

  void _previousPage() {
    if (_currentPage == 0) {
      return;
    }

    _pageController.previousPage(
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeOut,
    );
  }

  /// Adds or removes an outdoor time while keeping at least
  /// one time selected.
  void _toggleOutdoorTime(
    OutdoorTime time,
  ) {
    setState(() {
      if (_outdoorTimes.contains(time)) {
        if (_outdoorTimes.length > 1) {
          _outdoorTimes.remove(time);
        }
      } else {
        _outdoorTimes.add(time);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                16,
                20,
                0,
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 75,
                    fit: BoxFit.contain,
                  ),
                  const Spacer(),
                  if (!_isPersonalisationPage)
                    TextButton(
                      onPressed: _skipOnboarding,
                      child: const Text('Skip'),
                    ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _totalPages,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  if (index < _pages.length) {
                    return _OnboardingPage(
                      data: _pages[index],
                    );
                  }

                  return _PersonalisationPage(
                    homeRegion: _homeRegion,
                    regions: _regions,
                    activityLevel: _activityLevel,
                    outdoorTimes: _outdoorTimes,
                    remindersEnabled: _remindersEnabled,
                    onRegionChanged: (value) {
                      if (value == null) {
                        return;
                      }

                      setState(() {
                        _homeRegion = value;
                      });
                    },
                    onActivityChanged: (value) {
                      setState(() {
                        _activityLevel = value;
                      });
                    },
                    onOutdoorTimeChanged: _toggleOutdoorTime,
                    onRemindersChanged: (value) {
                      setState(() {
                        _remindersEnabled = value;
                      });
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                24,
                0,
                24,
                24,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _totalPages,
                      (index) {
                        final selected = index == _currentPage;

                        return AnimatedContainer(
                          duration: const Duration(
                            milliseconds: 200,
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 4,
                          ),
                          width: selected ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: selected
                                ? scheme.primary
                                : scheme.outlineVariant,
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      if (_currentPage > 0) ...[
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _isSaving ? null : _previousPage,
                            child: const Text('Back'),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                      Expanded(
                        flex: _currentPage > 0 ? 1 : 2,
                        child: FilledButton(
                          onPressed: _isSaving ? null : _nextPage,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                            ),
                            child: _isSaving
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    _isPersonalisationPage
                                        ? 'Get started'
                                        : 'Continue',
                                  ),
                          ),
                        ),
                      ),
                    ],
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

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.data,
  });

  final _OnboardingPageData data;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 28,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 132,
            height: 132,
            decoration: BoxDecoration(
              color: scheme.primaryContainer.withValues(alpha: 0.65),
              shape: BoxShape.circle,
            ),
            child: Icon(
              data.icon,
              size: 64,
              color: scheme.primary,
            ),
          ),
          const SizedBox(height: 36),
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 14),
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: scheme.onSurfaceVariant,
                  height: 1.5,
                ),
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: scheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    data.highlight,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Collects the preferences used to tailor SGReady's
/// environmental guidance and preparedness reminders.
class _PersonalisationPage extends StatelessWidget {
  const _PersonalisationPage({
    required this.homeRegion,
    required this.regions,
    required this.activityLevel,
    required this.outdoorTimes,
    required this.remindersEnabled,
    required this.onRegionChanged,
    required this.onActivityChanged,
    required this.onOutdoorTimeChanged,
    required this.onRemindersChanged,
  });

  final String homeRegion;
  final List<String> regions;

  final OutdoorActivityLevel activityLevel;

  final Set<OutdoorTime> outdoorTimes;

  final bool remindersEnabled;

  final ValueChanged<String?> onRegionChanged;

  final ValueChanged<OutdoorActivityLevel> onActivityChanged;

  final ValueChanged<OutdoorTime> onOutdoorTimeChanged;

  final ValueChanged<bool> onRemindersChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        24,
        20,
        24,
        24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: scheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.tune_rounded,
                size: 38,
                color: scheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Personalise SGReady',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tell us a little about your routine so SGReady can tailor preparedness information to you.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: scheme.onSurfaceVariant,
                  height: 1.4,
                ),
          ),
          const SizedBox(height: 28),
          Text(
            'Home region',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: homeRegion,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.location_on_outlined),
              border: OutlineInputBorder(),
            ),
            items: regions
                .map(
                  (region) => DropdownMenuItem<String>(
                    value: region,
                    child: Text(region),
                  ),
                )
                .toList(),
            onChanged: onRegionChanged,
          ),
          const SizedBox(height: 26),
          Text(
            'Outdoor activity',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'How active are you usually outdoors?',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: OutdoorActivityLevel.values
                .map(
                  (level) => ChoiceChip(
                    label: Text(
                      _activityLabel(level),
                    ),
                    selected: activityLevel == level,
                    onSelected: (_) {
                      onActivityChanged(level);
                    },
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 26),
          Text(
            'Usually outdoors',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'Select one or more times.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: OutdoorTime.values
                .map(
                  (time) => FilterChip(
                    label: Text(
                      _timeLabel(time),
                    ),
                    selected: outdoorTimes.contains(time),
                    onSelected: (_) {
                      onOutdoorTimeChanged(time);
                    },
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 26),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: SwitchListTile(
              contentPadding: EdgeInsets.zero,
              secondary: Icon(
                Icons.notifications_outlined,
                color: scheme.primary,
              ),
              title: const Text(
                'Preparedness reminders',
              ),
              subtitle: const Text(
                'Receive reminders about daily preparedness actions.',
              ),
              value: remindersEnabled,
              onChanged: onRemindersChanged,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  static String _activityLabel(
    OutdoorActivityLevel level,
  ) {
    switch (level) {
      case OutdoorActivityLevel.low:
        return 'Low';

      case OutdoorActivityLevel.moderate:
        return 'Moderate';

      case OutdoorActivityLevel.high:
        return 'High';
    }
  }

  static String _timeLabel(
    OutdoorTime time,
  ) {
    switch (time) {
      case OutdoorTime.morning:
        return 'Morning';

      case OutdoorTime.midday:
        return 'Midday';

      case OutdoorTime.evening:
        return 'Evening';
    }
  }
}

/// Stores the content displayed on each introductory onboarding page.
class _OnboardingPageData {
  const _OnboardingPageData({
    required this.icon,
    required this.title,
    required this.description,
    required this.highlight,
  });

  final IconData icon;
  final String title;
  final String description;
  final String highlight;
}
