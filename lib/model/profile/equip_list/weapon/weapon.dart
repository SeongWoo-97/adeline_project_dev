import '../equip_effect.dart';
import '../equip_item_title.dart';
import '../equip_tripod.dart';

class Weapon {
  String? itemName;
  String? upgrade;
  int? grade;
  EquipItemTitle? itemTitle;
  WeaponEffect? effect;
  EquipTripod? tripod;
  String? setLevel;
  String? setEffect;

  Weapon({this.itemName, this.upgrade, this.grade, this.itemTitle, this.effect, this.tripod, this.setLevel, this.setEffect});

  factory Weapon.fromJson(Map<String, dynamic> json) {
    return Weapon(
      itemName: json['item_name'],
      upgrade: json['upgrade'],
      grade: json['grade'],
      itemTitle: EquipItemTitle.fromJson(json['item_title']),
      effect: WeaponEffect.fromJson(json['effect']),
      tripod: EquipTripod.fromJson(json['tripod']),
      setLevel: json['set_level'],
      setEffect: json['set_effect'],
    );
  }
}