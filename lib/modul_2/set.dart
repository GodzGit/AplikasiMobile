import 'dart:io';

void main() {

  // data awal
  Set<String> dataSet = {'a','b','c','d','e'};
  print('=== SEMUA DATA ===');

  int no = 1;
  for(String data in dataSet){
    print('$no. $data');
    no++;
  }

  // hitung jumlah data
  print('Total data: ${dataSet.length}');

  // tambah data
  stdout.write('Masukkan data baru: ');
  String newData = stdin.readLineSync()!;

  // cek duplicate
  if(dataSet.add(newData)){
    print('Data "$newData" berhasil ditambahkan!');
  }else{
    print('Data "$newData" sudah ada (duplicate)!');
  }

  // hapus data
  stdout.write('Masukkan data yang ingin dihapus: ');
  String deleteData = stdin.readLineSync()!;

  if(dataSet.remove(deleteData)){
    print('Data "$deleteData" berhasil dihapus!');
  }else{
    print('Data tidak ditemukan!');
  }

  // cek data
  stdout.write('Masukkan data yang ingin dicek: ');
  String checkData = stdin.readLineSync()!;

  if(dataSet.contains(checkData)){
    print('Data "$checkData" ada di Set!');
  }else{
    print('Data "$checkData" tidak ada di Set!');
  }

}