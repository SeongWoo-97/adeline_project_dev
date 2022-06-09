import 'package:adeline_app/model/profile/ability_stone/stone_engrave.dart';

class StoneEffect{
  String? basicEffect;
  String? plusEffect;
  List<StoneEngrave>? engraveEffect;

  StoneEffect({this.basicEffect, this.plusEffect, this.engraveEffect});

  factory StoneEffect.fromJson(Map<String, dynamic> json) {
    List<StoneEngrave> engraveEffect = [];
    if (json['engrave_effect'] != null) {
      engraveEffect = [];
      json['engrave_effect'].forEach((v) {
        engraveEffect.add(StoneEngrave.fromJson(v));
      });
    }
    return StoneEffect(
      basicEffect: json['basic_effect'],
      plusEffect: json['plus_effect'],
      engraveEffect: engraveEffect,
    );
  }
}