import 'package:adeline_app/model/profile/avatar_list/avatar.dart';

class AvatarList {
  Avatar? head;
  Avatar? top;
  Avatar? face;
  Avatar? bottom;
  Avatar? weapon;
  Avatar? instrument; // 악기

  Avatar? overHead;
  Avatar? overTop;
  Avatar? overFace;
  Avatar? overBottom;
  Avatar? overWeapon;

  AvatarList({
    this.head,
    this.bottom,
    this.weapon,
    this.face,
    this.instrument,
    this.overBottom,
    this.overFace,
    this.overHead,
    this.overTop,
    this.overWeapon,
    this.top,
  });

  factory AvatarList.fromJson(Map<String,dynamic> json) {
    return AvatarList(
      head: json['head'] != null ? Avatar.fromJson(json['head']) : null,
      top: json['top'] != null ? Avatar.fromJson(json['top']) : null,
      face: json['face1'] != null ? Avatar.fromJson(json['face1']) : null,
      bottom: json['bottom'] != null ? Avatar.fromJson(json['bottom']) : null,
      weapon: json['weapon'] != null ? Avatar.fromJson(json['weapon']) : null,
      instrument: json['instrument'] != null ? Avatar.fromJson(json['instrument']) : null,
      overHead: json['over_head'] != null ? Avatar.fromJson(json['over_head']) : null,
      overTop: json['over_top'] != null ? Avatar.fromJson(json['over_top']) : null,
      overFace: json['face2'] != null ? Avatar.fromJson(json['face2']) : null,
      overBottom: json['over_bottom'] != null ? Avatar.fromJson(json['over_bottom']) : null,
      overWeapon: json['over_weapon'] != null ? Avatar.fromJson(json['over_weapon']) : null,
    );
  }
}
