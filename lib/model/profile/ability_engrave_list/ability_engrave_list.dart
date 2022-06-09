class AbilityEngraveList {
  List<String>? engraveName;
  List<String>? engraveDes;

  AbilityEngraveList({this.engraveName, this.engraveDes});

  factory AbilityEngraveList.fromJson(Map<String, dynamic> json) {
    return AbilityEngraveList(
      engraveName: json['engrave_name'].cast<String>(),
      engraveDes: json['engrave_des'].cast<String>(),
    );
  }
}