class EquipEffect {
  var basicEffect;
  var plusEffect;

  EquipEffect({this.basicEffect, this.plusEffect});

  factory EquipEffect.fromJson(Map<String, dynamic> json) {
    return EquipEffect(
      basicEffect: json['basic_effect'] as List,
      plusEffect: json['plus_effect'] as List,
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