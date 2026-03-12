import '../models/mahasiswa_aktif_model.dart';

class MahasiswaAktifRepository {

  Future<List<MahasiswaAktifModel>> getMahasiswaAktifList() async {

    await Future.delayed(const Duration(seconds: 1));

    return [
      MahasiswaAktifModel(
        nama: 'Budi Santoso',
        nim: '220810102',
        email: 'budi@email.com',
        semester: 6,
      ),
      MahasiswaAktifModel(
        nama: 'Citra Dewi',
        nim: '220810103',
        email: 'citra@email.com',
        semester: 4,
      ),
      MahasiswaAktifModel(
        nama: 'Dika Pratama',
        nim: '220810104',
        email: 'dika@email.com',
        semester: 2,
      ),
    ];
  }
}