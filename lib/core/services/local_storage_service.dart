import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();
  static late SharedPreferences _prefs;

  LocalStorageService._internal();

  factory LocalStorageService() {
    return _instance;
  }

  // Inisialisasi shared preferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    print('📦 LocalStorageService initialized');
  }

  // ==================== GENERIC METHODS ====================

  Future<bool> saveString(String key, String value) async {
    try {
      final result = await _prefs.setString(key, value);
      print('✅ Data saved: $key = $value');
      return result;
    } catch (e) {
      print('❌ Failed to save $key: $e');
      return false;
    }
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<bool> saveInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  Future<bool> saveBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  Future<bool> saveStringList(String key, List<String> value) async {
    return await _prefs.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }

  // ==================== JSON METHODS ====================

  Future<bool> saveObject(String key, Map<String, dynamic> value) async {
    try {
      final jsonString = jsonEncode(value);
      return await saveString(key, jsonString);
    } catch (e) {
      print('❌ Failed to save object $key: $e');
      return false;
    }
  }

  Map<String, dynamic>? getObject(String key) {
    final jsonString = getString(key);
    if (jsonString != null) {
      try {
        return jsonDecode(jsonString);
      } catch (e) {
        print('❌ Failed to parse object $key: $e');
        return null;
      }
    }
    return null;
  }

  Future<bool> saveObjectList(String key, List<Map<String, dynamic>> value) async {
    try {
      final jsonString = jsonEncode(value);
      return await saveString(key, jsonString);
    } catch (e) {
      print('❌ Failed to save object list $key: $e');
      return false;
    }
  }

  List<Map<String, dynamic>>? getObjectList(String key) {
    final jsonString = getString(key);
    if (jsonString != null) {
      try {
        final List<dynamic> decoded = jsonDecode(jsonString);
        return decoded.map((e) => e as Map<String, dynamic>).toList();
      } catch (e) {
        print('❌ Failed to parse object list $key: $e');
        return null;
      }
    }
    return null;
  }

  // ==================== DOSEN SPECIFIC METHODS (CACHE) ====================

  Future<bool> saveDosenList(List<Map<String, dynamic>> dosenList) async {
    return await saveObjectList('cached_dosen_list', dosenList);
  }

  List<Map<String, dynamic>>? getCachedDosenList() {
    return getObjectList('cached_dosen_list');
  }

  Future<bool> clearCache() async {
    return await remove('cached_dosen_list');
  }

  Future<bool> saveLastUpdate(String key, DateTime time) async {
    return await saveString(key, time.toIso8601String());
  }

  DateTime? getLastUpdate(String key) {
    final timeString = getString(key);
    if (timeString != null) {
      try {
        return DateTime.parse(timeString);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  bool isCacheValid(String key, {Duration maxAge = const Duration(hours: 1)}) {
    final lastUpdate = getLastUpdate(key);
    if (lastUpdate == null) return false;
    final now = DateTime.now();
    return now.difference(lastUpdate) < maxAge;
  }

  // ==================== 🆕 SAVED USERS METHODS (UNTUK DATA TERSIMPAN) ====================

  // Key untuk menyimpan daftar user yang disimpan
  static const String _savedUsersKey = 'saved_users_list';

  // Menyimpan user yang dipilih
  Future<void> saveUser({required String userId, required String username}) async {
    // Ambil data yang sudah ada
    List<Map<String, String>> currentUsers = getSavedUsers();
    
    // Cek apakah user sudah ada
    bool exists = currentUsers.any((user) => user['user_id'] == userId);
    
    if (!exists) {
      // Tambah user baru
      currentUsers.add({
        'user_id': userId,
        'username': username,
        'saved_at': DateTime.now().toIso8601String(),
      });
      
      // Simpan kembali
      await saveObjectList(_savedUsersKey, currentUsers.map((e) => e as Map<String, dynamic>).toList());
      print('✅ User $username berhasil disimpan');
    } else {
      print('⚠️ User $username sudah tersimpan');
    }
  }

  // Mendapatkan semua user yang tersimpan
  List<Map<String, String>> getSavedUsers() {
    final List<Map<String, dynamic>>? saved = getObjectList(_savedUsersKey);
    if (saved != null) {
      return saved.map((e) => Map<String, String>.from(e)).toList();
    }
    return [];
  }

  // Menghapus satu user berdasarkan userId
  Future<void> removeUser(String userId) async {
    List<Map<String, String>> currentUsers = getSavedUsers();
    currentUsers.removeWhere((user) => user['user_id'] == userId);
    await saveObjectList(_savedUsersKey, currentUsers.map((e) => e as Map<String, dynamic>).toList());
    print('✅ User ID $userId dihapus');
  }

  // Menghapus semua user yang tersimpan
  Future<void> clearAllSavedUsers() async {
    await remove(_savedUsersKey);
    print('✅ Semua user tersimpan dihapus');
  }

  // ==================== UTILITY METHODS ====================

  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  Future<bool> clearAll() async {
    return await _prefs.clear();
  }

  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }

  Set<String> getKeys() {
    return _prefs.getKeys();
  }
}