import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tes/features/dosen/data/models/dosen_model.dart';
import 'package:tes/features/dosen/data/repositories/dosen_repository.dart';
import 'package:tes/core/services/local_storage_service.dart';

final dosenRepositoryProvider = Provider<DosenRepository>((ref) {
  return DosenRepository();
});

// Provider untuk last update
final dosenLastUpdateProvider = Provider<DateTime?>((ref) {
  final repository = ref.watch(dosenRepositoryProvider);
  return repository.getLastUpdate();
});

// 🆕 Provider untuk saved users (data tersimpan di local storage)
final savedUsersProvider = FutureProvider<List<Map<String, String>>>((ref) async {
  final storage = LocalStorageService();
  final savedUsers = storage.getSavedUsers();
  return savedUsers;
});

class DosenNotifier extends StateNotifier<AsyncValue<List<DosenModel>>> {
  final DosenRepository _repository;
  final LocalStorageService _storage = LocalStorageService();

  DosenNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadDosen();
  }

  // Load data dengan offline first
  Future<void> loadDosen({bool forceRefresh = false}) async {
    try {
      print('📱 Load dosen - forceRefresh: $forceRefresh');
      final data = await _repository.getDosenList(forceRefresh: forceRefresh);
      state = AsyncValue.data(data);
    } catch (error, stack) {
      print('❌ Error loading dosen: $error');
      state = AsyncValue.error(error, stack);
    }
  }

  // Refresh dengan force dari API
  Future<void> refresh({bool forceRefresh = true}) async {
    state = const AsyncValue.loading();
    await loadDosen(forceRefresh: forceRefresh);
  }

  // 🆕 Menyimpan dosen yang dipilih ke local storage
  Future<void> saveSelectedDosen(DosenModel dosen) async {
    await _storage.saveUser(
      userId: dosen.id.toString(),
      username: dosen.username,
    );
  }

  // 🆕 Menghapus satu user dari local storage
  Future<void> removeSavedUser(String userId) async {
    await _storage.removeUser(userId);
  }

  // 🆕 Menghapus semua user dari local storage
  Future<void> clearSavedUsers() async {
    await _storage.clearAllSavedUsers();
  }
}

final dosenNotifierProvider = StateNotifierProvider<DosenNotifier, AsyncValue<List<DosenModel>>>((ref) {
  final repository = ref.watch(dosenRepositoryProvider);
  return DosenNotifier(repository);
});