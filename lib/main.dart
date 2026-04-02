import 'package:tes/core/constants/constants.dart';
import 'package:tes/core/theme/theme.dart';
import 'package:tes/core/services/local_storage_service.dart';  // ← TAMBAHKAN IMPORT INI
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tes/features/dashboard/presentation/pages/dashboard_page.dart';

void main() async {  // ← TAMBAHKAN async
  WidgetsFlutterBinding.ensureInitialized();  // ← TAMBAHKAN INI
  await LocalStorageService.init();  // ← TAMBAHKAN INI (inisialisasi local storage)
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});  // ← TAMBAHKAN const

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: const DashboardPage(),  // ← TAMBAHKAN const
    );
  }
}