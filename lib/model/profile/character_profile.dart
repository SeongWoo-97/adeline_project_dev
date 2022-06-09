import 'package:adeline_app/model/profile/ability_battle/ability_battle.dart';
import 'package:adeline_app/model/profile/ability_engrave_list/ability_engrave_list.dart';
import 'package:adeline_app/model/profile/ability_stone/ability_stone.dart';
import 'package:adeline_app/model/profile/ability_tendecy/ability_tendecy.dart';
import 'package:adeline_app/model/profile/accessory_list/accessory_list.dart';
import 'package:adeline_app/model/profile/attack_basic/attack_basic.dart';
import 'package:adeline_app/model/profile/card/card.dart';
import 'package:adeline_app/model/profile/equip_engrave/equip_engrave.dart';
import 'package:adeline_app/model/profile/equip_list/equip_list.dart';
import 'package:adeline_app/model/profile/gem/gem.dart';
import 'package:adeline_app/model/profile/info/info.dart';
import 'package:flutter/cupertino.dart';

class CharacterProfile extends ChangeNotifier{
  String? result;
  Info info;
  AttackBasic? attackBasic;
  AbilityBattle? abilityBattle;
  AbilityEngraveList? abilityEngraveList;
  AbilityTendecy? abilityTendecy;
  Card? card;
  EquipList? equipList;
  AccessoryList? accessoryList;
  List<Gem>? gem;
  AbilityStone? abilityStone;
  List<EquipEngrave>? equipEngrave;

  CharacterProfile({
    this.result,
    required this.info,
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
  });

  factory CharacterProfile.fromJson(Map<String, dynamic> json) {
    List<Gem> gem = [];
    List<EquipEngrave> equipEngrave = [];
    if (json['gem'] != null) {
      json['gem'].forEach((v) {
        gem.add(Gem.fromJson(v));
      });
    }
    if (json['equip_engrave'] != null) {
      equipEngrave = <EquipEngrave>[];
      json['equip_engrave'].forEach((v) {
        equipEngrave.add(EquipEngrave.fromJson(v));
      });
    }
    return CharacterProfile(
      result: json['result'],
      info: Info.fromJson(json['info']),
      attackBasic: AttackBasic.fromJson(json['attack_basic']),
      abilityBattle: AbilityBattle.fromJson(json['ability_battle']),
      abilityTendecy: AbilityTendecy.fromJson(json['ability_tendecy']),
      abilityEngraveList: AbilityEngraveList.fromJson(json['ability_engrave_list']),
      card: Card.fromJson(json['card']),
      equipList: EquipList.fromJson(json['equip_list']),
      accessoryList: AccessoryList.fromJson(json['accessory_list']),
      gem: gem,
      abilityStone: AbilityStone.fromJson(json['ability_stone']),
      equipEngrave: equipEngrave,
    );
  }
}


