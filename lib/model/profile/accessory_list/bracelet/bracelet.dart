import 'package:adeline_app/model/profile/accessory_list/bracelet/bra_item_title.dart';

class Bracelet {
  String? name;
  int? grade;
  BraItemTitle? itemTitle;
  List<String>? effect;

  Bracelet({
    this.name,
    this.grade,
    this.itemTitle,
    this.effect,
  });

  factory Bracelet.fromJson(Map<String, dynamic> json) {
    List<String> effects = [];
    if (json['effect'] != null) {
      json['effect'].forEach((v) {
        effects.add(v);
      });
    }
    return Bracelet(
      name: json['name'] != null ? json['name'] : null,
      grade: json['grade'] != null ? json['grade'] : null,
      itemTitle: json['item_title'] != null ? BraItemTitle.fromJson(json['item_title']) : null,
      effect: effects,
    );
  }
}
