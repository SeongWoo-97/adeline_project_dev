class AbilityBattle {
  String? critical;
  String? specialty;
  String? subdue;
  String? agility;
  String? endurance;
  String? proficiency;

  AbilityBattle({this.critical, this.specialty, this.subdue, this.agility, this.endurance, this.proficiency});

  factory AbilityBattle.fromJson(Map<String, dynamic> json) {
    return AbilityBattle(
      critical: json['critical'],
      specialty: json['specialty'],
      subdue: json['subdue'],
      agility: json['agility'],
      endurance: json['endurance'],
      proficiency: json['proficiency'],
    );
  }
}