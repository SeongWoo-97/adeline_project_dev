class EquipItemTitle {
  String? imgUrl;
  String? parts;
  String? itemLevel;
  int? quality;

  EquipItemTitle({this.imgUrl, this.parts, this.itemLevel, this.quality});

  factory EquipItemTitle.fromJson(Map<String, dynamic> json) {
    return EquipItemTitle(
      imgUrl: json['img_url'],
      parts: json['parts'],
      itemLevel: json['item_level'],
      quality: json['quality'],
    );
  }
}