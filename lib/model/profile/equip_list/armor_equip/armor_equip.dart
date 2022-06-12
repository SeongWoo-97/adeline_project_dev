import '../equip_effect.dart';
import '../equip_item_title.dart';
import '../equip_tripod.dart';

class ArmorEquip {
  String? itemName;
  String? upgrade;
  int? grade;
  EquipItemTitle? itemTitle;
  ArmorEffect? effect;
  EquipTripod? tripod;
  String? setLevel;
  String? setEffect;

  ArmorEquip({this.itemName, this.upgrade, this.grade, this.itemTitle, this.effect, this.tripod, this.setLevel, this.setEffect});

  factory ArmorEquip.fromJson(Map<String, dynamic> json) {
    return ArmorEquip(
      itemName: json['item_name'],
      upgrade: json['upgrade'],
      grade: json['grade'],
      itemTitle: EquipItemTitle.fromJson(json['item_title']),
      effect: ArmorEffect.fromJson(json['effect']),
      tripod: EquipTripod.fromJson(json['tripod']),
      setLevel: json['set_level'] != null ? json['set_level'] : null,
      setEffect: json['set_effect'] != null ? json['set_effect'] : null,
    );
  }
}
