import 'package:flutter/material.dart';
import '../../data/models/mahasiswa_aktif_model.dart';

class MahasiswaAktifListView extends StatelessWidget {

  final List<MahasiswaAktifModel> mahasiswaList;
  final VoidCallback? onRefresh;

  const MahasiswaAktifListView({
    super.key,
    required this.mahasiswaList,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
      onRefresh: () async {
        onRefresh?.call();
      },
      child: ListView.builder(
        itemCount: mahasiswaList.length,
        itemBuilder: (context, index) {

          final mhs = mahasiswaList[index];

          return Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                child: Text(
                  mhs.nama[0],
                  style: const TextStyle(color: Colors.white),
                ),
              ),

              title: Text(mhs.nama),

              subtitle: Text(
                "NIM : ${mhs.nim}\nSemester : ${mhs.semester}",
              ),

              trailing: const Icon(Icons.school),
            ),
          );
        },
      ),
    );
  }
}