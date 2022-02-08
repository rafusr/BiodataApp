class Data {
  late int? id;
  late String nama;
  late String alamat;
  late String tanggalLahir;
  late String tinggi;
  late String berat;
  late String foto;

  Data(
      {this.id,
      required this.nama,
      required this.alamat,
      required this.tanggalLahir,
      required this.tinggi,
      required this.berat,
      required this.foto});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'alamat': alamat,
      'tanggalLahir': tanggalLahir,
      'tinggi': tinggi,
      'berat': berat,
      'foto': foto,
    };
  }

  Data.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nama = map['nama'];
    alamat = map['alamat'];
    tanggalLahir = map['tanggalLahir'];
    tinggi = map['tinggi'];
    berat = map['berat'];
    foto = map['foto'];
  }
}
