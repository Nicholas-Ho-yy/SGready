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

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

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

  Future<void> resetPreferences() async {
    await init();
    await _prefs!.remove(_storageKey);
  }
}
