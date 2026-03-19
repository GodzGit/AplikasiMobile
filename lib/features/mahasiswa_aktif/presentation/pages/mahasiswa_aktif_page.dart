import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tes/core/widgets/widgets.dart';
import '../providers/mahasiswa_aktif_provider.dart';
import '../widgets/mahasiswa_aktif_widget.dart';

class MahasiswaAktifPage extends ConsumerWidget {
  const MahasiswaAktifPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mahasiswaState = ref.watch(mahasiswaAktifNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mahasiswa Aktif'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(mahasiswaAktifNotifierProvider);
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'http') {
                ref.read(mahasiswaAktifNotifierProvider.notifier).refresh();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Menggunakan HTTP')),
                );
              } else if (value == 'dio') {
                ref.read(mahasiswaAktifNotifierProvider.notifier).refresh();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Menggunakan DIO')),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'http',
                child: Row(
                  children: [
                    Icon(Icons.http, size: 20),
                    SizedBox(width: 8),
                    Text('HTTP Client'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'dio',
                child: Row(
                  children: [
                    Icon(Icons.rocket_launch, size: 20),
                    SizedBox(width: 8),
                    Text('DIO Client'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: mahasiswaState.when(
        loading: () => const LoadingWidget(),
        error: (error, stack) => CustomErrorWidget(
          message: error.toString(),
          onRetry: () {
            ref.read(mahasiswaAktifNotifierProvider.notifier).refresh();
          },
        ),
        data: (mahasiswaList) {
          return MahasiswaAktifListView(
            mahasiswaList: mahasiswaList,
            onRefresh: () async {  // ← Tambahkan async
              ref.invalidate(mahasiswaAktifNotifierProvider);
            },
          );
        },
      ),
    );
  }
}