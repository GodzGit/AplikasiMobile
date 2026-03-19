import 'package:flutter/material.dart';
import 'package:tes/features/mahasiswa/data/models/mahasiswa_model.dart';

// CARD MAHASISWA
class MahasiswaCard extends StatelessWidget {
  final MahasiswaModel mahasiswa;
  final VoidCallback? onTap;

  const MahasiswaCard({
    Key? key,
    required this.mahasiswa,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Text(
            mahasiswa.nama.substring(0, 1),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
        ),
        title: Text(
          mahasiswa.nama,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('NIM: ${mahasiswa.nim}'),
            Text('Email: ${mahasiswa.email}'),
            Row(
              children: [
                Text('Jurusan: ${mahasiswa.jurusan}'),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Semester ${mahasiswa.semester}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.green.shade800,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}

// LISTVIEW MAHASISWA
class MahasiswaListView extends StatelessWidget {
  final List<MahasiswaModel> mahasiswaList;
  final Future<void> Function()? onRefresh;

  const MahasiswaListView({
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
            Icon(Icons.person_off, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'Tidak ada data mahasiswa',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh ?? () async {},
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mahasiswaList.length,
        itemBuilder: (context, index) {
          final mahasiswa = mahasiswaList[index];
          return MahasiswaCard(
            mahasiswa: mahasiswa,
            onTap: () {
              _showDetailDialog(context, mahasiswa);
            },
          );
        },
      ),
    );
  }

  void _showDetailDialog(BuildContext context, MahasiswaModel mahasiswa) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(mahasiswa.nama),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('NIM', mahasiswa.nim),
            _buildDetailRow('Email', mahasiswa.email),
            _buildDetailRow('Jurusan', mahasiswa.jurusan),
            _buildDetailRow('Semester', mahasiswa.semester.toString()),
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