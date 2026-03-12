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
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(mahasiswaAktifNotifierProvider);
            },
          )
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
            onRefresh: () {
              ref.invalidate(mahasiswaAktifNotifierProvider);
            },
          );
        },
      ),
    );
  }
}