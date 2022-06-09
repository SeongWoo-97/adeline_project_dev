import 'package:adeline_app/model/profile/accessory_list/bracelet/bracelet.dart';
import 'accessory/accessory.dart';

class AccessoryList {
  Accessory? necklace;
  Accessory? earring1;
  Accessory? earring2;
  Accessory? ring1;
  Accessory? ring2;
  Bracelet? bracelet;

  AccessoryList({this.necklace, this.earring1, this.earring2, this.ring1, this.ring2, this.bracelet});

  factory AccessoryList.fromJson(Map<String, dynamic> json) {
    return AccessoryList(
      necklace: Accessory.fromJson(json['necklace']),
      earring1: Accessory.fromJson(json['earring1']),
      earring2: Accessory.fromJson(json['earring2']),
      ring1: Accessory.fromJson(json['ring1']),
      ring2: Accessory.fromJson(json['ring2']),
      bracelet: Bracelet.fromJson(json['bracelet']),
    );
  }
}