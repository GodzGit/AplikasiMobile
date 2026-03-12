import '../models/mahasiswa_model.dart';

class MahasiswaRepository {

  Future<List<MahasiswaModel>> getMahasiswaList() async {

    await Future.delayed(const Duration(seconds: 1));

    return [
      MahasiswaModel(
        nama: 'Aldi Pratama',
        nim: '220810101',
        email: 'aldi.pratama@email.com',
        jurusan: 'Teknik Informatika',
        semester: 4,
      ),
      MahasiswaModel(
        nama: 'Budi Santoso',
        nim: '220810102',
        email: 'budi.santoso@email.com',
        jurusan: 'Teknik Informatika',
        semester: 6,
      ),
      MahasiswaModel(
        nama: 'Citra Dewi',
        nim: '220810103',
        email: 'citra.dewi@email.com',
        jurusan: 'Teknik Informatika',
        semester: 2,
      ),
    ];
  }
}