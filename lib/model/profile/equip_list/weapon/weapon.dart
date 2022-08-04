import '../equip_effect.dart';
import '../equip_item_title.dart';

class Weapon {
  String? itemName;
  String? upgrade;
  int? grade;
  EquipItemTitle? itemTitle;
  WeaponEffect? effect;
  String? setLevel;
  String? setEffect;

  Weapon({this.itemName, this.upgrade, this.grade, this.itemTitle, this.effect, this.setLevel, this.setEffect});

  factory Weapon.fromJson(Map<String, dynamic> json) {
    return Weapon(
      itemName: json['item_name'],
      upgrade: json['upgrade'],
      grade: json['grade'],
      itemTitle: EquipItemTitle.fromJson(json['item_title']),
      effect: WeaponEffect.fromJson(json['effect']),
      setLevel: json['set_level'] != null ? json['set_level'] : null,
      setEffect: json['set_effect'] != null ? json['set_effect'] : null,
    );
  }
}