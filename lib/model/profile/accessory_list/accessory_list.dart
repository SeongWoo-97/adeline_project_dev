import 'package:adeline_app/model/profile/accessory_list/bracelet/bracelet.dart';
import 'accessory/accessory.dart';

class AccessoryList {
  Accessory? necklace;
  Accessory? earring1;
  Accessory? earring2;
  Accessory? ring1;
  Accessory? ring2;
  Bracelet? bracelet;

  AccessoryList({
    this.necklace,
    this.earring1,
    this.earring2,
    this.ring1,
    this.ring2,
    this.bracelet,
  });

  factory AccessoryList.fromJson(Map<String, dynamic> json) {
    return AccessoryList(
      necklace: json['necklace'] != null ? Accessory.fromJson(json['necklace']) : null,
      earring1: json['earring1'] != null ? Accessory.fromJson(json['earring1']) : null,
      earring2: json['earring2'] != null ? Accessory.fromJson(json['earring2']) : null,
      ring1: json['ring1'] != null ? Accessory.fromJson(json['ring1']) : null,
      ring2: json['ring2'] != null ? Accessory.fromJson(json['ring2']) : null,
      bracelet: json['bracelet'] != null ? Bracelet.fromJson(json['bracelet']) : null,
    );
  }
}
