class StoneItemTitle {
  String? parts;
  String? tier;
  String? imgUrl;

  StoneItemTitle({this.parts, this.tier, this.imgUrl});

  factory StoneItemTitle.fromJson(Map<String, dynamic> json) {
    return StoneItemTitle(
      parts: json['parts'],
      tier: json['tier'],
      imgUrl: json['img_url'],
    );
  }
}
