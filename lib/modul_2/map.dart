import 'dart:io';

void main() {

  // single

  print('=== INPUT DATA MAHASISWA ===');

  Map<String, dynamic> mahasiswa = {};

  stdout.write('Masukkan NIM: ');
  mahasiswa['nim'] = stdin.readLineSync()!;

  stdout.write('Masukkan Nama: ');
  mahasiswa['nama'] = stdin.readLineSync()!;

  stdout.write('Masukkan Jurusan: ');
  mahasiswa['jurusan'] = stdin.readLineSync()!;

  stdout.write('Masukkan IPK: ');
  mahasiswa['ipk'] = double.parse(stdin.readLineSync()!);

  print('\nData Mahasiswa: $mahasiswa');


  // multiple

  print('\n=== INPUT MULTIPLE MAHASISWA ===');

  stdout.write('Masukkan jumlah mahasiswa: ');
  int jumlah = int.parse(stdin.readLineSync()!);

  List<Map<String,dynamic>> listMahasiswa = [];

  for(int i=0;i<jumlah;i++){

    print('\n--- Mahasiswa ke-${i+1} ---');

    Map<String,dynamic> mhs = {};

    stdout.write('Masukkan NIM: ');
    mhs['nim'] = stdin.readLineSync()!;

    stdout.write('Masukkan Nama: ');
    mhs['nama'] = stdin.readLineSync()!;

    stdout.write('Masukkan Jurusan: ');
    mhs['jurusan'] = stdin.readLineSync()!;

    stdout.write('Masukkan IPK: ');
    mhs['ipk'] = double.parse(stdin.readLineSync()!);

    listMahasiswa.add(mhs);
  }

  print('\nData semua mahasiswa:');
  print(listMahasiswa);

}