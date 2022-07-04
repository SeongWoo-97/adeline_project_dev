import 'package:adeline_app/model/profile/card/card.dart';
import 'package:adeline_app/model/profile/info/fief/fief.dart';
import 'package:adeline_app/model/profile/info/special_equip/special_equip.dart';

class Info {
  String nickName;
  String job;
  String server;
  String expeditionLevel;
  String battleLevel;
  String achieveItemLevel;
  String guild;
  String pvp;
  String badge;
  String useSkillPoint;
  String haveSkillPoint;
  Fief fief;
  SpecialEquip? special;

  Info(
      {required this.nickName,
      required this.job,
      required this.server,
      required this.expeditionLevel,
      required this.battleLevel,
      required this.achieveItemLevel,
      required this.guild,
      required this.pvp,
      required this.badge,
      required this.fief,
      required this.haveSkillPoint,
      required this.useSkillPoint});

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
        nickName: json['nickName'],
        job: json['job'],
        server: json['server'],
        expeditionLevel: json['expeditionLevel'],
        battleLevel: json['battleLevel'],
        achieveItemLevel: json['achieveItemLevel'],
        guild: json['guild'],
        pvp: json['pvp'],
        badge: json['badge'],
        useSkillPoint: json['use_skill_point'],
        haveSkillPoint: json['have_skill_point'],
        fief: Fief.fromJson(json['fief']));
  }
}
