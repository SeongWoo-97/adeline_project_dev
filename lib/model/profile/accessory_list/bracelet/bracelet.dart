import 'package:adeline_app/model/profile/accessory_list/bracelet/bra_item_title.dart';

class Bracelet {
  String? name;
  int? grade;
  BraItemTitle? itemTitle;
  List<String>? effect;

  Bracelet({this.name, this.grade, this.itemTitle, this.effect});

  factory Bracelet.fromJson(Map<String, dynamic> json) {
    return Bracelet(
      name: json['name'],
      grade: json['grade'],
      itemTitle: BraItemTitle.fromJson(json['item_title']),
      effect: json['effect'].cast<String>(),
    );
  }
}