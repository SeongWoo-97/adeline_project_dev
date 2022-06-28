class CharacterList {
  String? result;
  List<CharacterInfoModel>? list;

  CharacterList({this.result,this.list});

  factory CharacterList.fromJson(Map<String,dynamic> json) {
    List<CharacterInfoModel> temp = [];
    if (json['characters'] != null) {
      json['characters'].forEach((element) {
        temp.add(CharacterInfoModel.fromJson(element));
      });
    }
    return CharacterList(
      result: json['result'],
      list: temp,
    );
  }
}

class CharacterInfoModel {
  String name;
  String level;
  String job;

  CharacterInfoModel({required this.name, required this.level, required this.job});

  factory CharacterInfoModel.fromJson(Map<String, dynamic> json) {
    return CharacterInfoModel(
      name: json['nickName'] != null ? json['nickName'] : "오류",
      level: json['level'] != null ? json['level'] : "오류",
      job: json['job'] != null ? json['job'] : "오류",
    );
  }
}
