class EquipTripod {
  String? tripod1;
  String? tripod2;
  String? tripod3;

  EquipTripod({this.tripod1, this.tripod2, this.tripod3});

  factory EquipTripod.fromJson(Map<String, dynamic> json) {
    return EquipTripod(
      tripod1: json['tripod1'],
      tripod2: json['tripod2'],
      tripod3: json['tripod3'],
    );
  }
}