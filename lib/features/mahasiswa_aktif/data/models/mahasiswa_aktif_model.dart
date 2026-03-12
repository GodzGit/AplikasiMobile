class MahasiswaAktifModel {
  final String nama;
  final String nim;
  final String email;
  final int semester;

  MahasiswaAktifModel({
    required this.nama,
    required this.nim,
    required this.email,
    required this.semester,
  });

  factory MahasiswaAktifModel.fromJson(Map<String, dynamic> json) {
    return MahasiswaAktifModel(
      nama: json['nama'] ?? '',
      nim: json['nim'] ?? '',
      email: json['email'] ?? '',
      semester: json['semester'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'nim': nim,
      'email': email,
      'semester': semester,
    };
  }
}