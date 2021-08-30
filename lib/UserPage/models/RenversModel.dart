class RenversModel {
  final String? noTel, date;
  final int ? montant;

 RenversModel ({this.noTel, this.montant, this.date});

  Map<String, dynamic> toMap() {

    var map = new Map<String, dynamic>();
    map["noTel"] = noTel;
    map["date"] = date;
    map["montant"] = montant;

    return map;

  }

} 
