class Gem {
  String? title;
  int? grade;
  String? tier;
  String? imgUrl;
  String? des;
  String? skill;

  Gem({this.title, this.grade, this.tier, this.imgUrl, this.des, this.skill});

  factory Gem.fromJson(Map<String, dynamic> json) {
    return Gem(
      title: json['title'],
      grade: json['grade'],
      tier: json['tier'],
      imgUrl: json['img_url'],
      des: json['des'],
      skill: json['skill'],
    );
  }
}
