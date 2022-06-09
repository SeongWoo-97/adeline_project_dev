class AccItemTitle {
  String? parts;
  String? imgUrl;
  String? tier;
  int? quality;

  AccItemTitle({this.parts, this.imgUrl, this.tier, this.quality});

  AccItemTitle.fromJson(Map<String, dynamic> json) {
    parts = json['parts'];
    imgUrl = json['img_url'];
    tier = json['tier'];
    quality = json['quality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['parts'] = this.parts;
    data['img_url'] = this.imgUrl;
    data['tier'] = this.tier;
    data['quality'] = this.quality;
    return data;
  }
}