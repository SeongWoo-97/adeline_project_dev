import 'package:adeline_app/model/profile/ability_battle/ability_battle.dart';
import 'package:adeline_app/model/profile/ability_engrave_list/ability_engrave_list.dart';
import 'package:adeline_app/model/profile/ability_stone/ability_stone.dart';
import 'package:adeline_app/model/profile/ability_tendecy/ability_tendecy.dart';
import 'package:adeline_app/model/profile/accessory_list/accessory_list.dart';
import 'package:adeline_app/model/profile/attack_basic/attack_basic.dart';
import 'package:adeline_app/model/profile/avatar_list/avatar_list.dart';
import 'package:adeline_app/model/profile/card/card.dart';
import 'package:adeline_app/model/profile/collection/collectivePoint.dart';
import 'package:adeline_app/model/profile/equip_engrave/equip_engrave.dart';
import 'package:adeline_app/model/profile/equip_list/equip_list.dart';
import 'package:adeline_app/model/profile/gem/gem.dart';
import 'package:adeline_app/model/profile/info/info.dart';
import 'package:adeline_app/model/profile/skill/skill.dart';
import 'package:flutter/cupertino.dart';

class CharacterProfile extends ChangeNotifier {
  String? result;
  Info? info;
  AttackBasic? attackBasic;
  AbilityBattle? abilityBattle;
  AbilityEngraveList? abilityEngraveList;
  AbilityTendecy? abilityTendecy;
  AbilityStone? abilityStone;
  EquipList? equipList;
  AvatarList? avatarList;
  AccessoryList? accessoryList;
  CardModel? card;
  List<Gem>? gem;
  List<EquipEngrave>? equipEngrave;
  List<Skill>? skillList;
  CollectivePoint? collectivePoint;

  CharacterProfile(
      {this.result,
      this.info,
      this.attackBasic,
      this.abilityBattle,
      this.abilityEngraveList,
      this.abilityTendecy,
      this.card,
      this.equipList,
      this.accessoryList,
      this.gem,
      this.abilityStone,
      this.equipEngrave,
      this.skillList,
      this.collectivePoint,
      this.avatarList});

  factory CharacterProfile.fromJson(Map<String, dynamic> json) {
    List<Gem> gem = [];
    List<EquipEngrave> equipEngrave = [];
    List<Skill> skillList = [];
    if (json['gem'] != null) {
      json['gem'].forEach((v) {
        gem.add(Gem.fromJson(v));
      });
    }
    if (json['equip_engrave'].length != 0) {
      json['equip_engrave'].forEach((v) {
        equipEngrave.add(EquipEngrave.fromJson(v));
      });
    }
    if (json['skill_list'].length != 0) {
      json['skill_list'].forEach((v) {
        skillList.add(Skill.fromJson(v));
      });
    }
    return CharacterProfile(
      result: json['result'],
      info: json['info'] != null ? Info.fromJson(json['info']) : null,
      attackBasic: json['attack_basic'] != null ? AttackBasic.fromJson(json['attack_basic']) : null,
      abilityBattle: json['ability_battle'] != null ? AbilityBattle.fromJson(json['ability_battle']) : null,
      abilityTendecy: json['ability_tendecy'] != null ? AbilityTendecy.fromJson(json['ability_tendecy']) : null,
      abilityEngraveList: json['ability_engrave_list'] != null ? AbilityEngraveList.fromJson(json['ability_engrave_list']) : null,
      card: json['card'] != null ? CardModel.fromJson(json['card']) : null,
      equipList: json['equip_list'] != null ? EquipList.fromJson(json['equip_list']) : null,
      accessoryList: json['accessory_list'] != null ? AccessoryList.fromJson(json['accessory_list']) : null,
      gem: gem,
      abilityStone: json['ability_stone'].length != 0 ? AbilityStone.fromJson(json['ability_stone']) : null,
      equipEngrave: equipEngrave,
      skillList: skillList,
      collectivePoint: json['collective_point'] != null ? CollectivePoint.fromJson(json['collective_point']) : null,
      avatarList: json['avatar'] != null ? AvatarList.fromJson(json['avatar']) : null,
    );
  }
}
