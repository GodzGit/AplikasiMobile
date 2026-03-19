import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/mahasiswa_aktif_model.dart';

class MahasiswaAktifRepository {
  final String baseUrl = "https://jsonplaceholder.typicode.com";
  final Dio _dio = Dio();

  // MODUL 5: Mengambil data dari API posts sebagai referensi mahasiswa aktif
  Future<List<MahasiswaAktifModel>> getMahasiswaAktifList({bool useDio = true}) async {
    try {
      // Ambil data dari API posts (karena punya title yang bisa jadi nama)
      final posts = useDio 
          ? await _getPostsWithDio() 
          : await _getPostsWithHttp();
      
      // Transformasi data posts ke mahasiswa aktif
      // Filter hanya userId 1,2,3 sebagai mahasiswa aktif
      return posts.where((post) {
        final userId = post['userId'] as int;
        return userId <= 3; // Ambil userId 1,2,3 saja
      }).map((post) {
        final userId = post['userId'] as int;
        final postId = post['id'] as int;
        
        // Gunakan title sebagai nama (ambil kata pertama)
        String nama = _extractNameFromTitle(post['title'] ?? '');
        
        return MahasiswaAktifModel(
          nama: nama,
          nim: '2208101${userId}0${postId % 10}',
          email: _generateEmail(nama, userId, postId),
          semester: 6 - (postId % 3) * 2, // Semester 2,4,6
        );
      }).toList();
      
    } catch (e) {
      print('❌ Error: $e');
      // Fallback ke data dummy jika error
      return _getDummyData();
    }
  }

  // Mengambil data dari API posts dengan HTTP
  Future<List<dynamic>> _getPostsWithHttp() async {
    final response = await http.get(
      Uri.parse('$baseUrl/posts'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Gagal memuat data');
    }
  }

  // Mengambil data dari API posts dengan DIO
  Future<List<dynamic>> _getPostsWithDio() async {
    final response = await _dio.get('$baseUrl/posts');
    
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Gagal memuat data');
    }
  }

  // Helper: Extract nama dari title
  String _extractNameFromTitle(String title) {
    List<String> words = title.split(' ');
    if (words.isEmpty) return 'Mahasiswa';
    
    // Ambil 2-3 kata pertama untuk nama
    int nameLength = words.length > 3 ? 3 : words.length;
    String name = words.sublist(0, nameLength).join(' ');
    
    // Kapitalisasi setiap kata
    return name.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

  // Helper: Generate email dari nama
  String _generateEmail(String nama, int userId, int postId) {
    String base = nama.toLowerCase().replaceAll(' ', '.');
    return '$base${userId}${postId % 10}@student.email.com';
  }

  // Data dummy sebagai fallback
  List<MahasiswaAktifModel> _getDummyData() {
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