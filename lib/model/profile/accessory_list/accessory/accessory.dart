import 'package:adeline_app/model/profile/accessory_list/acc_effect.dart';
import 'package:adeline_app/model/profile/accessory_list/acc_engrave.dart';
import 'package:adeline_app/model/profile/accessory_list/acc_item_title.dart';

class Accessory {
  String? itemName;
  int? grade;
  AccItemTitle? itemTitle;
  AccEffect? effect;
  List<AccEngrave>? engrave;

  Accessory({this.itemName, this.grade, this.itemTitle, this.effect, this.engrave});

  factory Accessory.fromJson(Map<String, dynamic> json) {
    List<AccEngrave> engrave = [];

    if (json['engrave'] != null) {
      json['engrave'].forEach((v) {
        engrave.add(AccEngrave.fromJson(v));
      });
    }
    return Accessory(
      itemName: json['item_name'] != null ? json['item_name'] : null,
      grade: json['grade'] != null ? json['grade'] : null ,
      itemTitle: json['item_title'] != null ? AccItemTitle.fromJson(json['item_title']) : null,
      effect: json['effect'] != null ? AccEffect.fromJson(json['effect']) : null,
      engrave: engrave,
    );
  }
}