class Gem {
  String? title;
  String? grade;
  String? imgUrl;
  String? des;
  String? skill;

  Gem({this.title, this.grade, this.imgUrl, this.des, this.skill});

  factory Gem.fromJson(Map<String, dynamic> json) {
    return Gem(
      title: json['title'],
      grade: json['grade'],
      imgUrl: json['img_url'],
      des: json['des'],
      skill: json['skill'],
    );
  }
}
