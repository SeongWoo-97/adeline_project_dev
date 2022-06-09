import 'package:adeline_app/model/profile/info/fief/fief.dart';
import 'package:adeline_app/model/profile/info/special_equip/special_equip.dart';

class Info {
  String nickName;
  String server;
  String expeditionLevel;
  String battleLevel;
  String achieveItemLevel;
  String guild;
  String pvp;
  String badge;
  Fief fief;
  SpecialEquip? special;

  Info({
    required this.nickName,
    required this.server,
    required this.expeditionLevel,
    required this.battleLevel,
    required this.achieveItemLevel,
    required this.guild,
    required this.pvp,
    required this.badge,
    required this.fief
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      nickName: json['nickName'],
      server: json['server'],
      expeditionLevel: json['expeditionLevel'],
      battleLevel: json['battleLevel'],
      achieveItemLevel: json['achieveItemLevel'],
      guild: json['guild'],
      pvp: json['pvp'],
      badge: json['badge'],
      fief: Fief.fromJson(json['fief'])
    );
  }
}