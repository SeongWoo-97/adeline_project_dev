class BraItemTitle {
  String? parts;
  String? tier;
  String? imgUrl;

  BraItemTitle({this.parts, this.tier, this.imgUrl});

  factory BraItemTitle.fromJson(Map<String, dynamic> json) {
    return BraItemTitle(
      parts: json['parts'],
      tier: json['tier'],
      imgUrl: json['img_url'],
    );
  }
}
