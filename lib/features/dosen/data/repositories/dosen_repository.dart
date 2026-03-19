// MODUL 5: Repository untuk memanggil API
import 'package:tes/features/dosen/data/models/dosen_model.dart';
import 'package:http/http.dart' as http;  // MODUL 5: Menggunakan http
import 'dart:convert';
import 'package:dio/dio.dart';  // MODUL 5: Menggunakan dio

class DosenRepository {
  final String baseUrl = "https://jsonplaceholder.typicode.com";
  final Dio _dio = Dio();  // MODUL 5: Inisialisasi dio

  // MODUL 5: Method dengan pilihan menggunakan http atau dio
  Future<List<DosenModel>> getDosenList({bool useDio = true}) async {
    if (useDio) {
      return getDosenListWithDio();  // MODUL 5: Menggunakan dio
    } else {
      return getDosenListWithHttp(); // MODUL 5: Menggunakan http
    }
  }

  // MODUL 5: GET data menggunakan HTTP
  Future<List<DosenModel>> getDosenListWithHttp() async {
    try {
      print('📡 Mengambil data dosen dengan HTTP...');
      final response = await http.get(
        Uri.parse('$baseUrl/users'),
        headers: {'Content-Type': 'application/json'},
      );

      print('📥 Status Code: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        print('✅ Berhasil mengambil ${data.length} data dosen');
        return data.map((json) => DosenModel.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat data: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error: $e');
      throw Exception('Error: $e');
    }
  }

  // MODUL 5: GET data menggunakan DIO
  Future<List<DosenModel>> getDosenListWithDio() async {
    try {
      print('📡 Mengambil data dosen dengan DIO...');
      final response = await _dio.get(
        '$baseUrl/users',
        options: Options(
          headers: {'Content-Type': 'application/json'},
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

      print('📥 Status Code: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        print('✅ Berhasil mengambil ${data.length} data dosen');
        return data.map((json) => DosenModel.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('❌ Dio Error: ${e.message}');
      throw Exception('Dio Error: ${e.message}');
    } catch (e) {
      print('❌ Error: $e');
      throw Exception('Error: $e');
    }
  }
}