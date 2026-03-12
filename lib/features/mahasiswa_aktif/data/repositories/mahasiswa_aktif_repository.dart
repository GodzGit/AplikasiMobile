import '../models/mahasiswa_aktif_model.dart';

class MahasiswaAktifRepository {

  Future<List<MahasiswaAktifModel>> getMahasiswaAktifList() async {

    await Future.delayed(const Duration(seconds: 1));

    return [
      MahasiswaAktifModel(
        nama: 'Ahmad Kasim',
        nim: '220810102',
        email: 'ahmad.kasim@email.com',
        semester: 6,
      ),
      MahasiswaAktifModel(
        nama: 'Citra Kusumawati',
        nim: '220810103',
        email: 'citra.kusumawati@email.com',
        semester: 4,
      ),
      MahasiswaAktifModel(
        nama: 'Dika Pratama',
        nim: '220810104',
        email: 'dika.pratama@email.com',
        semester: 2,
      ),
    ];
  }
}