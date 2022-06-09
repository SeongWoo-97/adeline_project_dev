class AbilityTendecy {
  String? intellect;
  String? bravery;
  String? charm;
  String? kindness;

  AbilityTendecy({this.intellect, this.bravery, this.charm, this.kindness});

  factory AbilityTendecy.fromJson(Map<String, dynamic> json) {
    return AbilityTendecy(
      intellect: json['intellect'],
      bravery: json['bravery'],
      charm: json['charm'],
      kindness: json['kindness'],
    );
  }
}