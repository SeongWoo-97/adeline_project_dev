class StoneItemTitle {
  String? parts;
  String? tier;
  String? imgUrl;

  StoneItemTitle({this.parts, this.tier, this.imgUrl});

  factory StoneItemTitle.fromJson(Map<String, dynamic> json) {
    return StoneItemTitle(
      parts: json['parts'] != null ? json['parts'] : null,
      tier: json['tier'] != null ? json['tier'] : null,
      imgUrl: json['img_url'] != null ? json['img_url'] : null,
    );
  }
}
