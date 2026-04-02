import 'package:tes/core/network/dio_client.dart';
import 'package:tes/core/services/local_storage_service.dart';
import 'package:tes/features/dosen/data/models/dosen_model.dart';

class DosenRepository {
  final String baseUrl = "https://jsonplaceholder.typicode.com";
  final DioClient _dioClient = DioClient();
  final LocalStorageService _storage = LocalStorageService();

  Future<List<DosenModel>> getDosenList({bool forceRefresh = false}) async {
    try {
      if (!forceRefresh && _isCacheValid()) {
        print('📦 Mengambil data dari LOCAL STORAGE (cache)');
        final cachedData = _storage.getCachedDosenList();
        if (cachedData != null && cachedData.isNotEmpty) {
          return cachedData.map((json) => DosenModel.fromJson(json)).toList();
        }
      }

      print('🌐 Mengambil data dari API (online)');
      final response = await _dioClient.get('$baseUrl/users');
      
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        final dosenList = data.map((json) => DosenModel.fromJson(json)).toList();
        
        await _saveToCache(data);
        await _storage.saveLastUpdate('dosen_last_update', DateTime.now());
        
        print('✅ Berhasil mengambil ${dosenList.length} data dari API');
        return dosenList;
      } else {
        throw Exception('Gagal memuat data: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error: $e, mencoba mengambil dari cache...');
      
      final cachedData = _storage.getCachedDosenList();
      if (cachedData != null && cachedData.isNotEmpty) {
        print('📦 Mengambil data dari LOCAL STORAGE (offline fallback)');
        return cachedData.map((json) => DosenModel.fromJson(json)).toList();
      }
      
      throw Exception('Tidak ada koneksi dan tidak ada data cache: $e');
    }
  }

  bool _isCacheValid() {
    return _storage.isCacheValid('dosen_last_update', maxAge: const Duration(hours: 1));
  }

  Future<void> _saveToCache(List<dynamic> data) async {
    final List<Map<String, dynamic>> jsonList = 
        data.map((item) => item as Map<String, dynamic>).toList();
    await _storage.saveDosenList(jsonList);
    print('💾 Data disimpan ke local storage');
  }

  Future<List<DosenModel>> refreshDosenList() async {
    return await getDosenList(forceRefresh: true);
  }

  Future<List<DosenModel>?> getCachedDosenList() async {
    final cachedData = _storage.getCachedDosenList();
    if (cachedData != null) {
      return cachedData.map((json) => DosenModel.fromJson(json)).toList();
    }
    return null;
  }

  DateTime? getLastUpdate() {
    return _storage.getLastUpdate('dosen_last_update');
  }

  Future<bool> clearCache() async {
    return await _storage.clearCache();
  }
}