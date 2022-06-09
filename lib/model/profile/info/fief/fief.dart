class Fief {
  String fiefName;
  String fiefLevel;

  Fief({
    required this.fiefName,
    required this.fiefLevel,
  });

  factory Fief.fromJson(Map<String, dynamic> json) {
    return Fief(
      fiefName: json['fief_name'],
      fiefLevel: json['fief_level'],
    );
  }
}
