class DailyModel {
  int id;
  String tarih;
  String ictimi;
  int kactane;
  int zorlanma;
  int cravings;

  DailyModel(this.id, this.tarih, this.ictimi, this.kactane, this.zorlanma,
      this.cravings);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = id;
    map["tarih"] = tarih;
    map["ictimi"] = ictimi;
    map["kactane"] = kactane;
    map["zorlanma"] = zorlanma;
    map["cravings"] = cravings;

    return map;
  }

  DailyModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    tarih = map["tarih"];
    ictimi = map["ictimi"];
    kactane = map["kactane"];
    zorlanma = map["zorlanma"];
    cravings = map["cravings"];
  }
}
