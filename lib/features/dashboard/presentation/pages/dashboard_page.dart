import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tes/core/constants/constants.dart';
import 'package:tes/core/widgets/widgets.dart';
import 'package:tes/features/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:tes/features/dashboard/presentation/widgets/dashboard_widgets.dart';
import 'package:tes/features/mahasiswa/presentation/pages/mahasiswa_page.dart';
import 'package:tes/features/mahasiswa_aktif/presentation/pages/mahasiswa_aktif_page.dart';
import 'package:tes/features/dosen/presentation/pages/dosen_page.dart';
import 'package:tes/features/profile/presentation/pages/profile_page.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({Key? key}) : super(key: key);

  // get icon
  IconData _getIconForStat(String title) {
    switch (title) {
      case 'Total Mahasiswa':
        return Icons.school_rounded;
      case 'Mahasiswa Aktif':
        return Icons.person_outline_rounded;
      case 'Profile':
        return Icons.workspace_premium_rounded;
      case 'Dosen':
        return Icons.people_outline_rounded;
      default:
        return Icons.analytics_outlined;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardNotifierProvider);
    final selectedIndex = ref.watch(selectedStatIndexProvider);

    return Scaffold(
        body: dashboardState.when(
            loading: () => const LoadingWidget(),

            error: (error, stack) => CustomErrorWidget(
              message: 'Gagal memuat data: ${error.toString()}',
              onRetry: () {
                ref.read(dashboardNotifierProvider.notifier).refresh();
              },
            ),

            data: (dashboardData) {
              return RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(dashboardNotifierProvider);
                },
                child: CustomScrollView(
                  slivers: [

                /// HEADER
                SliverToBoxAdapter(
                child: Container(
                decoration: BoxDecoration(
                gradient: LinearGradient(
                begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withBlue(220),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context)
                        .primaryColor
                        .withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),

              child: SafeArea(
              bottom: false,
              child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

              /// ROW HEADER
              Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
              Expanded(
              child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

              Text(
              'Selamat Datang! 👋',
              style: TextStyle(
              color: Colors.white
                  .withOpacity(0.9),
              fontSize: 16,
              fontWeight: FontWeight.w500,
              ),
              ),

              const SizedBox(height: 8),

              Text(
              dashboardData.userName,
              style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
              ),
              ),
              ],
              ),
              ),

              /// NOTIFICATION ICON
              Container(
              decoration: BoxDecoration(
              color:
              Colors.white.withOpacity(0.2),
              borderRadius:
              BorderRadius.circular(16),
              border: Border.all(
              color: Colors.white
                  .withOpacity(0.3),
              width: 2,
              ),
              ),
              child: IconButton(
              icon: const Icon(
              Icons.notifications_outlined,
              color: Colors.white,
              size: 26,
              ),
              onPressed: () {},
              ),
              ),
              ],
              ),

              const SizedBox(height: 20),

              /// LAST UPDATE CARD
              Container(
              padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
              ),
              decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius:
              BorderRadius.circular(16),
              border: Border.all(
              color:
              Colors.white.withOpacity(0.2),
              width: 1,
              ),
              ),
              child: Row(
              children: [
              Icon(
              Icons.calendar_today_rounded,
              color: Colors.white
                  .withOpacity(0.9),
              size: 18,
              ),
              const SizedBox(width: 12),

              Text(
              'Update: ${_formatDate(dashboardData.lastUpdate)}',
              style: TextStyle(
              color: Colors.white
                  .withOpacity(0.9),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              ),
              ),
              ],
              ),
              ),
              ],
              ),
              ),
              ),
              ),
              ),

                    /// STAT SECTION
                    SliverPadding(
                      padding: const EdgeInsets.all(24),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            /// HEADER STATISTIK
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [

                                const Text(
                                  'Statistik',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -0.5,
                                  ),
                                ),

                                TextButton.icon(
                                  onPressed: () {
                                    ref.invalidate(
                                        dashboardNotifierProvider);
                                  },
                                  icon: const Icon(
                                    Icons.refresh_rounded,
                                    size: 18,
                                  ),
                                  label: const Text('Refresh'),
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            /// GRID STAT CARD
                            GridView.builder(
                              shrinkWrap: true,
                              physics:
                              const NeverScrollableScrollPhysics(),
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 1.1,
                              ),
                              itemCount: dashboardData.stats.length,

                              itemBuilder: (context, index) {
                                final stat =
                                dashboardData.stats[index];

                                return ModernStatCard(
                                  stats: stat,
                                  icon: _getIconForStat(stat.title),
                                  gradientColors:
                                  AppConstants.dashboardGradients[
                                  index %
                                      AppConstants
                                          .dashboardGradients
                                          .length],
                                  isSelected: selectedIndex == index,

                                  onTap: () {

                                    ref
                                        .read(
                                        selectedStatIndexProvider
                                            .notifier)
                                        .state = index;

                                    final statTitle = stat.title;
                                    Widget? targetPage;

                                    switch (statTitle) {

                                      case 'Total Mahasiswa':
                                        targetPage =
                                        const MahasiswaPage();
                                        break;

                                      case 'Mahasiswa Aktif':
                                        targetPage =
                                        const MahasiswaAktifPage();
                                        break;

                                      case 'Dosen':
                                        targetPage =
                                        const DosenPage();
                                        break;

                                      case 'Profile':
                                        targetPage =
                                        const ProfilePage();
                                        break;
                                    }

                                    if (targetPage != null) {
                                      Navigator.push(
                                        context,
                                        _createRoute(targetPage),
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SliverPadding(
                      padding: EdgeInsets.only(bottom: 24),
                    ),
                  ],
                ),
              );
            },
        ),
    );
  }

  /// Custom Slide Animation Routing
  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
      page,
      transitionsBuilder:
          (context, animation, secondaryAnimation, child) {

        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;

        const curve = Curves.easeInOutCubic;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration:
      const Duration(milliseconds: 400),
    );
  }

  /// Format tanggal
  String _formatDate(DateTime date) {

    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];

    return
      '${date.day} ${months[date.month - 1]} ${date.year}, '
          '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}