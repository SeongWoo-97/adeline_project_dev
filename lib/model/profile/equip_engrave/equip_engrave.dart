class EquipEngrave {
  String? name;
  String? point;
  String? imgUrl;
  String? des;
  String? levelDes;

  EquipEngrave({this.name, this.point, this.imgUrl, this.des, this.levelDes});

  factory EquipEngrave.fromJson(Map<String, dynamic> json) {
    return EquipEngrave(
      name: json['name'],
      point: json['point'],
      imgUrl: json['img_url'],
      des: json['des'],
      levelDes: json['level_des'],
    );
  }
}