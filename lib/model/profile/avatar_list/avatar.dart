class Avatar {
  String? name;
  int? grade;
  AvatarItemTitle? itemTitle;
  AvatarEffect? avatarEffect;

  Avatar({
    this.name,
    this.grade,
    this.itemTitle,
    this.avatarEffect,
  });

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      name: json['name'] != null ? json['name'] : null,
      grade: json['grade'] != null ? json['grade'] : null,
      itemTitle: AvatarItemTitle.fromJson(json['item_title']),
      avatarEffect: AvatarEffect.fromJson(json['effect']),
    );
  }
}

class AvatarItemTitle {
  String? imgUrl;
  String? parts;

  AvatarItemTitle({this.imgUrl, this.parts});

  factory AvatarItemTitle.fromJson(Map<String, dynamic> json) {
    return AvatarItemTitle(
      imgUrl: json['img_url'],
      parts: json['parts'],
    );
  }
}

class AvatarEffect {
  String? basicEffect;
  List<String>? plusEffect;

  AvatarEffect({this.basicEffect, this.plusEffect});

  factory AvatarEffect.fromJson(Map<String, dynamic> json) {
    // List<String> basic = [];
    List<String> plus = [];
    // if (json['basic_effect'] != null) {
    //   json['basic_effect'].forEach((v) {
    //     basic.add(v);
    //   });
    // }
    if (json['plus_effect'] != null) {
      json['plus_effect'].forEach((v) {
        plus.add(v.trim());
      });
    }
    return AvatarEffect(
      basicEffect: json['basic_effect'],
      plusEffect: json['plus_effect'] != null ? plus : null,
    );
  }
}
