import 'package:flutter/material.dart';
import '../../data/models/mahasiswa_aktif_model.dart';

class MahasiswaAktifListView extends StatelessWidget {
  final List<MahasiswaAktifModel> mahasiswaList;
  final Future<void> Function()? onRefresh;

  const MahasiswaAktifListView({
    super.key,
    required this.mahasiswaList,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (mahasiswaList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'Tidak ada mahasiswa aktif',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh ?? () async {},
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: mahasiswaList.length,
        itemBuilder: (context, index) {
          final mhs = mahasiswaList[index];
          return _buildCard(context, mhs);  // ← Tambahkan context sebagai parameter
        },
      ),
    );
  }

  // Perbaiki: Tambahkan context sebagai parameter
  Widget _buildCard(BuildContext context, MahasiswaAktifModel mhs) {
    // Tentukan warna berdasarkan semester
    Color getSemesterColor() {
      switch (mhs.semester) {
        case 6:
          return Colors.purple;
        case 4:
          return Colors.blue;
        case 2:
          return Colors.green;
        default:
          return Colors.orange;
      }
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          _showDetailDialog(context, mhs);  // ← context sudah tersedia
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Avatar dengan inisial
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      getSemesterColor(),
                      getSemesterColor().withOpacity(0.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    mhs.nama.isNotEmpty ? mhs.nama[0] : 'M',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Informasi mahasiswa
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mhs.nama,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'NIM: ${mhs.nim}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      mhs.email,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: getSemesterColor().withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Semester ${mhs.semester}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: getSemesterColor(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Icon
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: getSemesterColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.school,
                  size: 20,
                  color: getSemesterColor(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method untuk menampilkan dialog detail
  void _showDetailDialog(BuildContext context, MahasiswaAktifModel mhs) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(mhs.nama),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('NIM', mhs.nim),
            _buildDetailRow('Email', mhs.email),
            _buildDetailRow('Semester', mhs.semester.toString()),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  // Method helper untuk membuat row detail
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 70,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}