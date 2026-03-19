import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tes/features/dosen/presentation/providers/dosen_provider.dart';
import 'package:tes/features/dosen/presentation/widgets/dosen_widget.dart';

// MODUL 5: Halaman untuk menampilkan data dari API
class DosenPage extends ConsumerWidget {
  const DosenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dosenState = ref.watch(dosenNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Dosen - REST API'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              ref.read(dosenNotifierProvider.notifier).refresh();
            },
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: dosenState.when(
        loading: () => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Mengambil data dari API...'),
            ],
          ),
        ),
        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                const SizedBox(height: 16),
                Text(
                  'Gagal memuat data: ${error.toString()}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    ref.read(dosenNotifierProvider.notifier).refresh();
                  },
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          ),
        ),
        data: (dosenList) {
          return DosenListView(
            dosenList: dosenList,
            onRefresh: () async {
              ref.read(dosenNotifierProvider.notifier).refresh();
            },
            useModernCard: true,
          );
        },
      ),
    );
  }
}