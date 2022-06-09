class AccEffect {
  String? basicEffect;
  String? plusEffect;

  AccEffect({this.basicEffect, this.plusEffect});

  factory AccEffect.fromJson(Map<String, dynamic> json) {
    return AccEffect(
      basicEffect: json['basic_effect'],
      plusEffect: json['plus_effect'],
    );
  }
}