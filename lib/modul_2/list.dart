import 'dart:io';

void main() {

  List<String> dataList = [];
  print('=== INPUT DATA LIST ===');
  stdout.write('Masukkan jumlah data: ');
  int count = int.parse(stdin.readLineSync()!);

  for (int i = 0; i < count; i++) {
    stdout.write('Data ke-${i+1}: ');
    String input = stdin.readLineSync()!;
    dataList.add(input);
  }
  // M
  print('\n=== OPERASI LIST ===');

  // tampilkan berdasarkan index
  stdout.write('Index yang ingin ditampilkan: ');
  int indexShow = int.parse(stdin.readLineSync()!);

  print('Data pada index $indexShow = ${dataList[indexShow]}');

  // ubah berdasarkan index
  stdout.write('Index yang ingin diubah: ');
  int indexEdit = int.parse(stdin.readLineSync()!);

  stdout.write('Masukkan data baru: ');
  String newData = stdin.readLineSync()!;

  dataList[indexEdit] = newData;

  // hapus berdasarkan index
  stdout.write('Index yang ingin dihapus: ');
  int indexDelete = int.parse(stdin.readLineSync()!);

  dataList.removeAt(indexDelete);

  // tampilkan hasil akhir
  print('\n=== SEMUA DATA ===');

  for(int i = 0; i < dataList.length; i++){
    print('Index $i: ${dataList[i]}');
  }
}