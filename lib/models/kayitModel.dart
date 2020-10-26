class KayitModel {
  int id;
  String adi;
  String soyadi;
  String il;
  int fiyat;
  int gunlukIcme;
  int icmeYil;
  String birakmaDate;
  String birthDate;

  KayitModel(this.adi, this.soyadi, this.il, this.fiyat, this.gunlukIcme,
      this.icmeYil, this.birthDate, this.birakmaDate, this.id);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["adi"] = adi;
    map["soyadi"] = soyadi;
    map["il"] = il;
    map["fiyat"] = fiyat;
    map["gunlukIcme"] = gunlukIcme;
    map["icmeYil"] = icmeYil;
    map["birakmaDate"] = birakmaDate;
    map["birthDate"] = birthDate;
    return map;
  }

  KayitModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    adi = map["adi"];
    soyadi = map["soyadi"];
    il = map["il"];
    fiyat = map["fiyat"];
    gunlukIcme = map["gunlukIcme"];
    birakmaDate = map["birakmaDate"];
    icmeYil = map["icmeYil"];

    birthDate = map["birthDate"];
  }
}
