import '../models/mahasiswa_model.dart';

class MahasiswaRepository {

  Future<List<MahasiswaModel>> getMahasiswaList() async {

    await Future.delayed(const Duration(seconds: 1));

    return [
      MahasiswaModel(
        nama: 'Ahmad Kasim',
        nim: '220810101',
        email: 'ahmad.kasim@email.com',
        jurusan: 'Teknik Informatika',
        semester: 4,
      ),
      MahasiswaModel(
        nama: 'Billy D. Wijoyo',
        nim: '220810102',
        email: 'billy.wijoyo@email.com',
        jurusan: 'Teknik Informatika',
        semester: 6,
      ),
      MahasiswaModel(
        nama: 'Cantika Kusumawati',
        nim: '220810103',
        email: 'cantika.kusumawati@email.com',
        jurusan: 'Teknik Informatika',
        semester: 2,
      ),
    ];
  }
}