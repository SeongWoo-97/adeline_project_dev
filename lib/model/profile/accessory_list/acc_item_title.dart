class AccItemTitle {
  String? parts;
  String? imgUrl;
  String? tier;
  int? quality;

  AccItemTitle({this.parts, this.imgUrl, this.tier, this.quality});

  factory AccItemTitle.fromJson(Map<String, dynamic> json) {
    return AccItemTitle(
      parts: json['parts'] != null ? json['parts'] : null,
      imgUrl: json['img_url'] != null ? json['img_url'] : null,
      tier: json['tier'] != null ? json['tier'] : null,
      quality: json['quality'] != null ? json['quality'] : null,
    );
  }
}