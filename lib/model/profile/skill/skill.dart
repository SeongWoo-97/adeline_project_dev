class Skill {
  String? name;
  String? type;
  String? level;
  String? imgUrl;
  Lun? lun;
  Tripod? tripod1;
  Tripod? tripod2;
  Tripod? tripod3;

  Skill({this.name, this.type, this.level, this.imgUrl, this.lun, this.tripod1, this.tripod2, this.tripod3});

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      name: json['skill_name'] != null ? json['skill_name'] : null,
      type: json['skill_type'] != null ? json['skill_type'] : null,
      level: json['skill_level'] != null ? json['skill_level'] : null,
      imgUrl: json['skill_img_url'] != null ? json['skill_img_url'] : null,
      lun: json['lun'] != null ? Lun.fromJson(json['lun']) : null,
      tripod1: json['tripod1'] != null ? Tripod.fromJson(json['tripod1']) : null,
      tripod2: json['tripod2'] != null ? Tripod.fromJson(json['tripod2']) : null,
      tripod3: json['tripod3'] != null ? Tripod.fromJson(json['tripod3']) : null,
    );
  }
}

class Lun {
  String? title;
  String? des;
  String? tier;
  int? grade;
  String? imgUrl;

  Lun({this.title, this.des, this.tier, this.grade, this.imgUrl});

  factory Lun.fromJson(Map<String, dynamic> json) {
    return Lun(
      title: json['title'] != null ? json['title'] : null,
      des: json['des'] != null ? json['des'] : null,
      tier: json['tier'] != null ? json['tier'] : null,
      grade: json['grade'] != null ? json['grade'] : null,
      imgUrl: json['img_url'] != null ? json['img_url'] : null,
    );
  }
}

class Tripod {
  String? name;
  String? level;
  String? imgUrl;

  Tripod({this.name, this.level, this.imgUrl});

  factory Tripod.fromJson(Map<String, dynamic> json) {
    return Tripod(
      name: json['name'] != null ? json['name'] : null,
      level: json['level'] != null ? json['level'] : null,
      imgUrl: json['img_url'] != null ? json['img_url'] : null,
    );
  }
}
