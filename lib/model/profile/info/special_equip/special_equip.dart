class SpecialEquip {
  List<String>? specialName;
  List<String>? specialImgUrl;

  SpecialEquip({this.specialName, this.specialImgUrl});

  factory SpecialEquip.fromJson(Map<String, dynamic> json) {
    return SpecialEquip(
      specialName: json['special_name'],
      specialImgUrl: json['special_img_url'],
    );
  }
}