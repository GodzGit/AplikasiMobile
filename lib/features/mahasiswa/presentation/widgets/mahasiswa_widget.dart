import 'package:flutter/material.dart';
import '../../data/models/mahasiswa_model.dart';

class MahasiswaListView extends StatelessWidget {

  final List<MahasiswaModel> mahasiswaList;
  final VoidCallback? onRefresh;

  const MahasiswaListView({
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
                child: Text(mhs.nama[0]),
              ),
              title: Text(mhs.nama),
              subtitle: Text("NIM : ${mhs.nim}\nSemester : ${mhs.semester}"),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          );
        },
      ),
    );
  }
}