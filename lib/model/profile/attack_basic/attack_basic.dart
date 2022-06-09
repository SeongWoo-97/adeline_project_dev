class AttackBasic {
  String? attackNumber;
  String? maxLifeNumber;

  AttackBasic({this.attackNumber, this.maxLifeNumber});

  factory AttackBasic.fromJson(Map<String, dynamic> json) {
    return AttackBasic(
      attackNumber: json['attack_number'],
      maxLifeNumber: json['max_life_number'],
    );
  }
}