import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/mahasiswa_model.dart';

class MahasiswaRepository {
  final String baseUrl = "https://jsonplaceholder.typicode.com";
  final Dio _dio = Dio();

  // MODUL 5: Mengambil data dari API comments sebagai referensi mahasiswa
  Future<List<MahasiswaModel>> getMahasiswaList({bool useDio = true}) async {
    try {
      // Ambil data dari API comments (karena punya email, name)
      final comments = useDio 
          ? await _getCommentsWithDio() 
          : await _getCommentsWithHttp();
      
      // Transformasi data comments ke mahasiswa
      return comments.asMap().entries.map((entry) {
        final index = entry.key;
        final comment = entry.value;
        
        return MahasiswaModel(
          nama: comment['name'] ?? 'Mahasiswa ${index + 1}',
          nim: '2208101${(index + 1).toString().padLeft(3, '0')}',
          email: comment['email'] ?? 'mahasiswa${index + 1}@email.com',
          jurusan: 'Teknik Informatika',
          semester: (index % 8) + 1, // Semester 1-8
        );
      }).toList();
      
    } catch (e) {
      print('❌ Error: $e');
      // Fallback ke data dummy jika error
      return _getDummyData();
    }
  }

  // Mengambil data dari API comments dengan HTTP
  Future<List<dynamic>> _getCommentsWithHttp() async {
    final response = await http.get(
      Uri.parse('$baseUrl/comments'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Gagal memuat data');
    }
  }

  // Mengambil data dari API comments dengan DIO
  Future<List<dynamic>> _getCommentsWithDio() async {
    final response = await _dio.get('$baseUrl/comments');
    
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Gagal memuat data');
    }
  }

  // Data dummy sebagai fallback
  List<MahasiswaModel> _getDummyData() {
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