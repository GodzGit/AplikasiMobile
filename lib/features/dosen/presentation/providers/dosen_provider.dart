import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tes/features/dosen/data/models/dosen_model.dart';
import 'package:tes/features/dosen/data/repositories/dosen_repository.dart';

// MODUL 5: Provider untuk mengelola state data dosen
final dosenNotifierProvider = StateNotifierProvider<DosenNotifier, AsyncValue<List<DosenModel>>>((ref) {
  return DosenNotifier();
});

class DosenNotifier extends StateNotifier<AsyncValue<List<DosenModel>>> {
  DosenNotifier() : super(const AsyncValue.loading()) {
    fetchDosen();
  }

  // MODUL 5: Method untuk mengambil data dari API
  Future<void> fetchDosen() async {
    try {
      print('🔄 Memuat data dosen...');
      final repository = DosenRepository();
      
      // MODUL 5: Bisa pilih HTTP atau DIO (true = DIO, false = HTTP)
      final dosenList = await repository.getDosenList(useDio: true);
      
      print('✅ Data dosen berhasil dimuat: ${dosenList.length} item');
      state = AsyncValue.data(dosenList);
    } catch (error, stack) {
      print('❌ Gagal memuat data: $error');
      state = AsyncValue.error(error, stack);
    }
  }

  // MODUL 5: Method untuk refresh data
  Future<void> refresh() async {
    print('🔄 Refresh data dosen...');
    state = const AsyncValue.loading();
    await fetchDosen();
  }
}