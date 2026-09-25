import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workmanager/workmanager.dart';

import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'providers/app_providers.dart';
import 'screens/create_account_screen.dart';
import 'screens/login_screen.dart';
import 'screens/main_shell.dart';
import 'screens/onboarding_screen.dart';
import 'screens/welcome_screen.dart';
import 'theme/app_theme.dart';
import 'services/background_notification_service.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize notifications and background work on mobile platforms.
  if (!kIsWeb) {
    await NotificationService.instance.init();

    await Workmanager().initialize(
      notificationCallbackDispatcher,
    );

    await BackgroundNotificationService.register();
  }

  runApp(
    const ProviderScope(
      child: SGReadyApp(),
    ),
  );
}

/// Configures the app theme, localization, accessibility settings,
/// and the authentication entry point.
class SGReadyApp extends ConsumerWidget {
  const SGReadyApp({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    ref.watch(
      initialisePreferredRegionProvider,
    );

    final themeMode = ref.watch(themeModeProvider);

    final preferencesAsync = ref.watch(userPreferencesProvider);

    final largerTextEnabled =
        preferencesAsync.valueOrNull?.largerTextEnabled ?? false;

    final languageCode = preferencesAsync.valueOrNull?.languageCode ?? 'en';

    return MaterialApp(
      title: 'SGReady',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,

      locale: Locale(languageCode),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      // Apply the accessibility text-size preference
      // throughout SGReady.
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);

        return MediaQuery(
          data: mediaQuery.copyWith(
            textScaler: largerTextEnabled
                ? const TextScaler.linear(1.2)
                : const TextScaler.linear(1.0),
          ),
          child: child!,
        );
      },

      home: const AuthGate(),
    );
  }
}

/// Routes the user to the correct screen based on authentication
/// and onboarding status.
class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _showLogin = false;
  bool _showCreateAccount = false;

  void _showWelcome() {
    setState(() {
      _showLogin = false;
      _showCreateAccount = false;
    });
  }

  void _showLoginScreen() {
    setState(() {
      _showLogin = true;
      _showCreateAccount = false;
    });
  }

  void _showCreateAccountScreen() {
    setState(() {
      _showCreateAccount = true;
      _showLogin = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, authSnapshot) {
        if (authSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final user = authSnapshot.data;

        if (user != null) {
          return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .snapshots(),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (userSnapshot.hasError) {
                return const Scaffold(
                  body: Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'Unable to load your account. Please try again.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              }

              final data = userSnapshot.data?.data();

              final onboardingCompleted =
                  data?['onboardingCompleted'] as bool? ?? false;

              if (onboardingCompleted) {
                return const MainShell();
              }

              return const OnboardingScreen();
            },
          );
        }

        if (_showCreateAccount) {
          return CreateAccountScreen(
            onAccountCreated: () {},
            onLogin: _showLoginScreen,
            onBack: _showWelcome,
          );
        }

        if (_showLogin) {
          return LoginScreen(
            onLoggedIn: () {},
            onCreateAccount: _showCreateAccountScreen,
            onBack: _showWelcome,
          );
        }

        return WelcomeScreen(
          onCreateAccount: _showCreateAccountScreen,
          onLogin: _showLoginScreen,
        );
      },
    );
  }
}
