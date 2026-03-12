import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tes/core/widgets/widgets.dart';
import 'package:tes/features/dosen/presentation/providers/dosen_provider.dart';
import 'package:tes/features/dosen/presentation/widgets/dosen_widget.dart';

class DosenPage extends ConsumerWidget {
  const DosenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dosenState = ref.watch(dosenNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Dosen'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              ref.invalidate(dosenNotifierProvider);
            },
            tooltip: 'Refresh',
          ),
        ],
      ),

      body: dosenState.when(

        // State: Loading
        loading: () => const LoadingWidget(),

        // State: Error
        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat data dosen: ${error.toString()}',
          onRetry: () {
            ref.read(dosenNotifierProvider.notifier).refresh();
          },
        ),

        // State: Data
        data: (dosenList) {
          return DosenListView(
            dosenList: dosenList,
            onRefresh: () {
              ref.invalidate(dosenNotifierProvider);
            },
            useModernCard: true, // Set to false for simple card
          );
        },
      ),
    );
  }
}