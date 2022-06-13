class EquipEngrave {
  String? name;
  String? point;
  String? imgUrl;
  String? des;
  String? levelDes;

  EquipEngrave({this.name, this.point, this.imgUrl, this.des, this.levelDes});

  factory EquipEngrave.fromJson(Map<String, dynamic> json) {
    return EquipEngrave(
      name: json['name'] != null ? json['name'] : null,
      point: json['point'] != null ? json['point'] : null,
      imgUrl: json['img_url'] != null ? json['img_url'] : null,
      des: json['des'] != null ? json['des'] : null,
      levelDes: json['level_des'] != null ? json['level_des'] : null,
    );
  }
}
