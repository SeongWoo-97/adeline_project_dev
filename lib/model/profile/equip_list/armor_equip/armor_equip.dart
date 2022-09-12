import '../equip_effect.dart';
import '../equip_item_title.dart';

class ArmorEquip {
  String? itemName;
  String? upgrade;
  int? grade;
  EquipItemTitle? itemTitle;
  ArmorEffect? effect;
  String? setLevel;
  String? setEffect;

  ArmorEquip({this.itemName, this.upgrade, this.grade, this.itemTitle, this.effect, this.setLevel, this.setEffect});

  factory ArmorEquip.fromJson(Map<String, dynamic> json) {
    return ArmorEquip(
      itemName: json['item_name'],
      upgrade: json['upgrade'],
      grade: json['grade'],
      itemTitle: EquipItemTitle.fromJson(json['item_title']),
      effect: ArmorEffect.fromJson(json['effect']),
      setLevel: json['set_level'] != null ? json['set_level'] : "",
      setEffect: json['set_effect'] != null ? json['set_effect'] : "적용되는 세트효과가 없습니다.",
    );
  }
}
