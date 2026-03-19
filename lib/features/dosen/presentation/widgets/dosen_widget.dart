import 'package:flutter/material.dart';
import 'package:tes/core/constants/constants.dart';
import 'package:tes/features/dosen/data/models/dosen_model.dart';

// MODUL 5: Widget card modern untuk menampilkan data dosen dari API
class ModernDosenCard extends StatefulWidget {
  final DosenModel dosen;
  final VoidCallback? onTap;
  final List<Color>? gradientColors;

  const ModernDosenCard({
    Key? key,
    required this.dosen,
    this.onTap,
    this.gradientColors,
  }) : super(key: key);

  @override
  State<ModernDosenCard> createState() => _ModernDosenCardState();
}

class _ModernDosenCardState extends State<ModernDosenCard>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.97,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gradientColors = widget.gradientColors ??
        [
          Theme.of(context).primaryColor,
          Theme.of(context).primaryColor.withOpacity(0.7),
        ];

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, gradientColors[0].withOpacity(0.05)],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: gradientColors[0].withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: gradientColors[0].withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Avatar dengan inisial dari API
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: gradientColors,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: gradientColors[0].withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      widget.dosen.name.substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Informasi Dosen dari API
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.dosen.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.3,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 8),

                      _buildInfoRow(
                        Icons.person_outline,
                        '@${widget.dosen.username}',
                      ),

                      const SizedBox(height: 4),

                      _buildInfoRow(
                        Icons.email_outlined,
                        widget.dosen.email,
                      ),

                      const SizedBox(height: 4),

                      _buildInfoRow(
                        Icons.phone_outlined,
                        widget.dosen.phone,
                      ),

                      const SizedBox(height: 4),

                      _buildInfoRow(
                        Icons.location_city,
                        '${widget.dosen.address.city}, ${widget.dosen.address.street}',
                      ),
                    ],
                  ),
                ),

                // Arrow Icon
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: gradientColors[0].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: gradientColors[0],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// MODUL 5: ListView untuk menampilkan data dari API
class DosenListView extends StatelessWidget {
  final List<DosenModel> dosenList;
  final Future<void> Function()? onRefresh;
  final bool useModernCard;

  const DosenListView({
    super.key,
    required this.dosenList,
    this.onRefresh,
    this.useModernCard = true,
  });

  List<Color> _getGradient(int index) {
    final gradients = [
      [Color(0xFF667eea), Color(0xFF764ba2)], // ungu
      [Color(0xFFFF7E5F), Color(0xFFFD3A69)], // pink
      [Color(0xFF36D1DC), Color(0xFF5B86E5)], // biru
      [Color(0xFF43e97b), Color(0xFF38f9d7)], // hijau
    ];
    return gradients[index % gradients.length];
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh ?? () async {},
      child: ListView.builder(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        itemCount: dosenList.length,
        itemBuilder: (context, index) {
          final dosen = dosenList[index];

          return useModernCard
              ? ModernDosenCard(
                  dosen: dosen,
                  gradientColors: _getGradient(index),
                  onTap: () {
                    // MODUL 5: Menampilkan detail data dari API
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${dosen.name} - ${dosen.email}'),
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                )
              : Card(
                  child: ListTile(
                    title: Text(dosen.name),
                    subtitle: Text(dosen.email),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Detail: ${dosen.name}')),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}