import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static SharedPreferences? _prefs;

  static const String _tokenKey = 'authToken';
  static const String _phoneNumberKey = 'phoneNumber';
  static const String _isLoggedInKey = 'isLoggedIn';


  static get token => getAuthToken();

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // --- Setter Methods ---

  static Future<void> setAuthToken(String token) async {
    await _prefs?.setString(_tokenKey, token);
    await _prefs?.setBool(_isLoggedInKey, true);
  }

  static Future<void> setPhoneNumber(String phoneNumber) async {
    await _prefs?.setString(_phoneNumberKey, phoneNumber);
  }

  // --- Getter Methods ---

  static String? getAuthToken() {
    return _prefs?.getString(_tokenKey);
  }

  static String? getPhoneNumber() {
    return _prefs?.getString(_phoneNumberKey);
  }

  static bool isLoggedIn() {
    return _prefs?.getBool(_isLoggedInKey) ?? false;
  }

  // --- Clear Methods ---

  /// Clears all stored user data upon logout.
  static Future<void> clearAll() async {
    await _prefs?.clear();
  }
  static Future<bool> hasToken() async {
    final token = _prefs?.getString(_tokenKey);
    return token != null && token.isNotEmpty;
  }

}
