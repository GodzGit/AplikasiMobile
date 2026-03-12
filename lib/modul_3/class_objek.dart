import 'dart:io';

class Mahasiswa {
  String? nama;
  int? nim;
  String? jurusan;

  void inputData() {
    print("Masukkan Nama:");
    nama = stdin.readLineSync();

    print("Masukkan NIP:");
    nim = int.tryParse(stdin.readLineSync() ?? '');

    print("Masukkan Jurusan:");
    jurusan = stdin.readLineSync();
  }

  void tampilkanData() {
    print("Nama    : ${nama ?? "Belum diisi"}");
    print("NIM     : ${nim ?? "Belum diisi"}");
    print("Jurusan : ${jurusan ?? "Belum diisi"}");
  }
}

/// MIXIN 1
mixin Absensi {
  void isiAbsensi() {
    print("Absensi berhasil diisi.");
  }
}

/// MIXIN 2
mixin Penilaian {
  void beriNilai() {
    print("Nilai berhasil diberikan.");
  }
}

/// MIXIN 3
mixin Informasi {
  void tampilkanInfoTambahan() {
    print("Menampilkan informasi tambahan.");
  }
}

/// DOSEN (EXTENDS + MIXIN)
class Dosen extends Mahasiswa with Absensi, Penilaian {
  String? mataKuliah;

  void inputMataKuliah() {
    print("Masukkan Mata Kuliah:");
    mataKuliah = stdin.readLineSync();
  }

  void tampilkanDosen() {
    print("Status  : Dosen");
    print("Mata Kuliah : ${mataKuliah ?? "Belum diisi"}");
  }
}

/// FAKULTAS (EXTENDS + MIXIN)
class Fakultas extends Mahasiswa with Informasi {
  String? namaFakultas;

  void inputFakultas() {
    print("Masukkan Nama Fakultas:");
    namaFakultas = stdin.readLineSync();
  }

  void tampilkanFakultas() {
    print("Status        : Fakultas");
    print("Nama Fakultas : ${namaFakultas ?? "Belum diisi"}");
  }
}

/// MAIN
void main() {
  print("Pilih Role:");
  print("1. Dosen");
  print("2. Fakultas");

  String? pilihan = stdin.readLineSync();

  if (pilihan == "1") {
    Dosen dosen = Dosen();
    dosen.inputData();
    dosen.inputMataKuliah();

    print("\n=== DATA DOSEN ===");
    dosen.tampilkanData();
    dosen.tampilkanDosen();

    // Dari mixin
    dosen.isiAbsensi();
    dosen.beriNilai();

  } else if (pilihan == "2") {
    Fakultas fakultas = Fakultas();
    fakultas.inputData();
    fakultas.inputFakultas();

    print("\n=== DATA FAKULTAS ===");
    fakultas.tampilkanData();
    fakultas.tampilkanFakultas();

    // Dari mixin
    fakultas.tampilkanInfoTambahan();

  } else {
    print("Pilihan tidak valid.");
  }
}