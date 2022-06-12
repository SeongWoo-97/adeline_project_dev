class BraItemTitle {
  String? parts;
  String? tier;
  String? imgUrl;

  BraItemTitle({
    this.parts,
    this.tier,
    this.imgUrl,
  });

  factory BraItemTitle.fromJson(Map<String, dynamic> json) {
    return BraItemTitle(
      parts: json['parts'] != null ? json['parts'] : null,
      tier: json['tier'] != null ? json['tier']: null,
      imgUrl: json['img_url'] != null ? json['img_url'] : null,
    );
  }
}
