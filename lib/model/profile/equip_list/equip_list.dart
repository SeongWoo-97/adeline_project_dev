import 'package:adeline_app/model/profile/equip_list/weapon/weapon.dart';
import 'armor_equip/armor_equip.dart';

class EquipList {
  Weapon? weapon;
  ArmorEquip? head;
  ArmorEquip? top;
  ArmorEquip? bottom;
  ArmorEquip? gloves;
  ArmorEquip? shoulder;

  EquipList({this.weapon, this.head, this.top, this.bottom, this.gloves, this.shoulder});

  factory EquipList.fromJson(Map<String, dynamic> json) {
    return EquipList(
      weapon: Weapon.fromJson(json['weapon']),
      head: ArmorEquip.fromJson(json['head']),
      top: ArmorEquip.fromJson(json['top']),
      bottom: ArmorEquip.fromJson(json['bottom']),
      gloves: ArmorEquip.fromJson(json['gloves']),
      shoulder: ArmorEquip.fromJson(json['shoulder']),
    );
  }
}