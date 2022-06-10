import 'package:adeline_app/model/profile/equip_list/weapon/weapon.dart';
import 'armor_equip/armor_equip.dart';

class EquipList {
  Weapon? weapon;
  ArmorEquip? head;
  ArmorEquip? top;
  ArmorEquip? bottom;
  ArmorEquip? gloves;
  ArmorEquip? shoulder;

  EquipList({
    this.weapon,
    this.head,
    this.top,
    this.bottom,
    this.gloves,
    this.shoulder,
  });

  factory EquipList.fromJson(Map<String, dynamic> json) {
    return EquipList(
      weapon: json['weapon'] != null ? Weapon.fromJson(json['weapon']) : null,
      head: json['head'] != null ? ArmorEquip.fromJson(json['head']) : null,
      top: json['top'] != null ? ArmorEquip.fromJson(json['top']) : null,
      bottom: json['bottom'] != null ? ArmorEquip.fromJson(json['bottom']) : null,
      gloves: json['gloves'] != null ? ArmorEquip.fromJson(json['gloves']) : null,
      shoulder: json['shoulder'] != null ? ArmorEquip.fromJson(json['shoulder']) : null,
    );
  }
}
