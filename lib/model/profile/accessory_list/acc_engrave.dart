class AccEngrave {
  String? name;
  String? point;

  AccEngrave({this.name, this.point});

  factory AccEngrave.fromJson(Map<String, dynamic> json) {
    return AccEngrave(
      name: json['name'],
      point: json['point'],
    );
  }
}