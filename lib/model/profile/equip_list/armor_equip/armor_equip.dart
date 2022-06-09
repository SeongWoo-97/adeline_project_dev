import '../equip_effect.dart';
import '../equip_item_title.dart';
import '../equip_tripod.dart';

class ArmorEquip {
  String? itemName;
  String? upgrade;
  int? grade;
  EquipItemTitle? itemTitle;
  EquipEffect? effect;
  EquipTripod? tripod;
  String? setLevel;

  ArmorEquip({this.itemName, this.upgrade, this.grade, this.itemTitle, this.effect, this.tripod, this.setLevel});

  factory ArmorEquip.fromJson(Map<String, dynamic> json) {
    return ArmorEquip(
      itemName: json['item_name'],
      upgrade: json['upgrade'],
      grade: json['grade'],
      itemTitle: EquipItemTitle.fromJson(json['item_title']),
      effect: EquipEffect.fromJson(json['effect']),
      tripod: EquipTripod.fromJson(json['tripod']),
      setLevel: json['set_level'],
    );
  }
}