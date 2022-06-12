class ArmorEffect {
  List<String> basicEffect;
  List<String> plusEffect;

  ArmorEffect({required this.basicEffect, required this.plusEffect});

  factory ArmorEffect.fromJson(Map<String, dynamic> json) {
    List<String> basic = [];
    List<String> plus = [];
    if (json['basic_effect'] != null) {
      json['basic_effect'].forEach((v) {
        basic.add(v);
      });
    }
    if (json['plus_effect'] != null) {
      json['plus_effect'].forEach((v) {
        plus.add(v);
      });
    }
    return ArmorEffect(
      basicEffect: basic,
      plusEffect: plus,
    );
  }
}

class WeaponEffect {
  String? basicEffect;
  var plusEffect;

  WeaponEffect({this.basicEffect, this.plusEffect});

  factory WeaponEffect.fromJson(Map<String, dynamic> json) {
    return WeaponEffect(
      basicEffect: json['basic_effect'],
      plusEffect: json['plus_effect'] as List,
    );
  }
}
