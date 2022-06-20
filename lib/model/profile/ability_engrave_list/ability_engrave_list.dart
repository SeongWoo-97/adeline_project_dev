class AbilityEngraveList {
  List<String>? engraveName;
  List<String>? engraveDes;

  AbilityEngraveList({this.engraveName, this.engraveDes});

  factory AbilityEngraveList.fromJson(Map<String, dynamic> json) {
    List<String> engraveName = [];
    List<String> engraveDes = [];
    if (json['engrave_name'].length != 0) {
      json['engrave_name'].forEach((v) {
        engraveName.add(v);
      });
    }
    if (json['engrave_des'].length != 0) {
      json['engrave_des'].forEach((v) {
        engraveDes.add(v);
      });
    }
    return AbilityEngraveList(
      engraveName: json['engrave_name'].length != 0 ? engraveName : [],
      engraveDes: json['engrave_des'].length != 0 ? engraveDes : [],
    );
  }
}
