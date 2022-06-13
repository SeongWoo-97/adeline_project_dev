import 'package:adeline_app/model/profile/ability_stone/stone_effect.dart';
import 'package:adeline_app/model/profile/ability_stone/stone_item_title.dart';

class AbilityStone {
  String? name;
  int? grade;
  StoneItemTitle? itemTitle;
  StoneEffect? effect;

  AbilityStone({this.name, this.grade, this.itemTitle, this.effect});

  factory AbilityStone.fromJson(Map<String, dynamic> json) {
    return AbilityStone(
      name: json['name'] != null ? json['name'] : null,
      grade: json['grade'] != null ? json['grade'] : null,
      itemTitle: StoneItemTitle.fromJson(json['item_title']),
      effect: StoneEffect.fromJson(json['effect']),
    );
  }
}