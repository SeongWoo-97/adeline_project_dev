class StoneEngrave {
  String? name;
  String? point;

  StoneEngrave({this.name, this.point});

  factory StoneEngrave.fromJson(Map<String, dynamic> json) {
    return StoneEngrave(
      name: json['name'],
      point: json['point'],
    );
  }
}