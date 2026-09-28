// SGReady Final Year Project
// Developed by: Nicholas Ho
//
// The SGReady-specific logic for loading, saving and resetting the user's
// local preferences in this file was developed by me.
//
// SharedPreferences is an external Flutter package used to store the
// preferences locally on the user's device.

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_preferences.dart';

/// Loads, saves, and resets the user's local app preferences.
class UserPreferencesService {
  UserPreferencesService({
    SharedPreferences? prefs,
  }) : _prefs = prefs;

  static const String _storageKey = 'user_preferences_v1';

  SharedPreferences? _prefs;

  /// Sets up access to the local SharedPreferences storage.
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Loads the user's saved preferences, or returns the default
  /// preferences if nothing has been saved yet.
  Future<UserPreferences> getPreferences() async {
    await init();

    final raw = _prefs!.getString(_storageKey);

    if (raw == null || raw.trim().isEmpty) {
      return const UserPreferences();
    }

    try {
      final decoded = jsonDecode(raw);

      if (decoded is Map) {
        return UserPreferences.fromMap(
          Map<String, dynamic>.from(decoded),
        );
      }
    } catch (_) {
      // Fall back to defaults if saved data is invalid.
    }

    return const UserPreferences();
  }

  /// Converts the preferences to JSON and saves them locally on the device.
  Future<UserPreferences> savePreferences(
    UserPreferences preferences,
  ) async {
    await init();

    final encoded = jsonEncode(
      preferences.toMap(),
    );

    final saved = await _prefs!.setString(
      _storageKey,
      encoded,
    );

    if (!saved) {
      throw StateError(
        'Unable to save user preferences.',
      );
    }

    return preferences;
  }

  /// Removes the saved preferences so the app can return to its defaults.
  Future<void> resetPreferences() async {
    await init();
    await _prefs!.remove(_storageKey);
  }
}
