import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/widgets.dart';
import '../providers/mahasiswa_provider.dart';
import '../widgets/mahasiswa_widget.dart';

class MahasiswaPage extends ConsumerWidget {
  const MahasiswaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final mahasiswaState = ref.watch(mahasiswaNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Mahasiswa"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(mahasiswaNotifierProvider);
            },
          )
        ],
      ),

      body: mahasiswaState.when(

        loading: () => const LoadingWidget(),

        error: (error, stack) => CustomErrorWidget(
          message: error.toString(),
          onRetry: () {
            ref.read(mahasiswaNotifierProvider.notifier).refresh();
          },
        ),

        data: (mahasiswaList) {
          return MahasiswaListView(
            mahasiswaList: mahasiswaList,
            onRefresh: () async {  // ← tambahkan async
              ref.invalidate(mahasiswaNotifierProvider);
            },
          );
        },
      ),
    );
  }
}