// class Autogenerated {
//   String? result;
//   Info? info;
//   AttackBasic? attackBasic;
//   AbilityBattle? abilityBattle;
//   AbilityEngraveList? abilityEngraveList;
//   AbilityTendecy? abilityTendecy;
//   Card? card;
//   EquipList? equipList;
//   AccessoryList? accessoryList;
//   List<Gem>? gem;
//   AbilityStone? abilityStone;
//   List<EquipEngrave>? equipEngrave;
//
//   Autogenerated(
//       {this.result,
//       this.info,
//       this.attackBasic,
//       this.abilityBattle,
//       this.abilityEngraveList,
//       this.abilityTendecy,
//       this.card,
//       this.equipList,
//       this.accessoryList,
//       this.gem,
//       this.abilityStone,
//       this.equipEngrave});
//
//   Autogenerated.fromJson(Map<String, dynamic> json) {
//     result = json['result'];
//     info = json['info'] != null ? Info.fromJson(json['info']) : null;
//     attackBasic = json['attack_basic'] != null ? AttackBasic.fromJson(json['attack_basic']) : null;
//     abilityBattle = json['ability_battle'] != null ? AbilityBattle.fromJson(json['ability_battle']) : null;
//     abilityEngraveList = json['ability_engrave_list'] != null ? AbilityEngraveList.fromJson(json['ability_engrave_list']) : null;
//     abilityTendecy = json['ability_tendecy'] != null ? AbilityTendecy.fromJson(json['ability_tendecy']) : null;
//     card = json['card'] != null ? Card.fromJson(json['card']) : null;
//     equipList = json['equip_list'] != null ? EquipList.fromJson(json['equip_list']) : null;
//     accessoryList = json['accessory_list'] != null ? AccessoryList.fromJson(json['accessory_list']) : null;
//     if (json['gem'] != null) {
//       gem = <Gem>[];
//       json['gem'].forEach((v) {
//         gem!.add(Gem.fromJson(v));
//       });
//     }
//     abilityStone = json['ability_stone'] != null ? AbilityStone.fromJson(json['ability_stone']) : null;
//
//     if (json['equip_engrave'] != null) {
//       equipEngrave = <EquipEngrave>[];
//       json['equip_engrave'].forEach((v) {
//         equipEngrave!.add(EquipEngrave.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['result'] = this.result;
//     if (this.info != null) {
//       data['info'] = this.info!.toJson();
//     }
//     if (this.attackBasic != null) {
//       data['attack_basic'] = this.attackBasic!.toJson();
//     }
//     if (this.abilityBattle != null) {
//       data['ability_battle'] = this.abilityBattle!.toJson();
//     }
//     if (this.abilityEngraveList != null) {
//       data['ability_engrave_list'] = this.abilityEngraveList!.toJson();
//     }
//     if (this.abilityTendecy != null) {
//       data['ability_tendecy'] = this.abilityTendecy!.toJson();
//     }
//     if (this.card != null) {
//       data['card'] = this.card!.toJson();
//     }
//     if (this.equipList != null) {
//       data['equip_list'] = this.equipList!.toJson();
//     }
//     if (this.accessoryList != null) {
//       data['accessory_list'] = this.accessoryList!.toJson();
//     }
//     if (this.gem != null) {
//       data['gem'] = this.gem!.map((v) => v.toJson()).toList();
//     }
//     if (this.abilityStone != null) {
//       data['ability_stone'] = this.abilityStone!.toJson();
//     }
//     if (this.equipEngrave != null) {
//       data['equip_engrave'] = this.equipEngrave!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Info {
//   String? nickName;
//   String? server;
//   String? expeditionLevel;
//   String? battleLevel;
//   String? achieveItemLevel;
//   String? guild;
//   String? pvp;
//   Fief? fief;
//   String? badge;
//   Special? special;
//
//   Info({
//     this.nickName,
//     this.server,
//     this.expeditionLevel,
//     this.battleLevel,
//     this.achieveItemLevel,
//     this.guild,
//     this.pvp,
//     this.fief,
//     this.badge,
//     this.special,
//   });
//
//   Info.fromJson(Map<String, dynamic> json) {
//     nickName = json['nickName'];
//     server = json['server'];
//     expeditionLevel = json['expeditionLevel'];
//     battleLevel = json['battleLevel'];
//     achieveItemLevel = json['achieveItemLevel'];
//     guild = json['guild'];
//     pvp = json['pvp'];
//     fief = json['fief'] != null ? Fief.fromJson(json['fief']) : null;
//     badge = json['badge'];
//     special = json['special'] != null ? Special.fromJson(json['special']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['nickName'] = this.nickName;
//     data['server'] = this.server;
//     data['expeditionLevel'] = this.expeditionLevel;
//     data['battleLevel'] = this.battleLevel;
//     data['achieveItemLevel'] = this.achieveItemLevel;
//     data['guild'] = this.guild;
//     data['pvp'] = this.pvp;
//     if (this.fief != null) {
//       data['fief'] = this.fief!.toJson();
//     }
//     data['badge'] = this.badge;
//     if (this.special != null) {
//       data['special'] = this.special!.toJson();
//     }
//     return data;
//   }
// }
//
// class Fief {
//   String? fiefName;
//   String? fiefLevel;
//
//   Fief({this.fiefName, this.fiefLevel});
//
//   Fief.fromJson(Map<String, dynamic> json) {
//     fiefName = json['fief_name'];
//     fiefLevel = json['fief_level'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['fief_name'] = this.fiefName;
//     data['fief_level'] = this.fiefLevel;
//     return data;
//   }
// }
//
// class Special {
//   List<String>? specialName;
//   List<String>? specialImgUrl;
//
//   Special({this.specialName, this.specialImgUrl});
//
//   Special.fromJson(Map<String, dynamic> json) {
//     specialName = json['special_name'].cast<String>();
//     specialImgUrl = json['special_img_url'].cast<String>();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['special_name'] = this.specialName;
//     data['special_img_url'] = this.specialImgUrl;
//     return data;
//   }
// }
//
// class AttackBasic {
//   String? attackNumber;
//   String? maxLifeNumber;
//
//   AttackBasic({this.attackNumber, this.maxLifeNumber});
//
//   AttackBasic.fromJson(Map<String, dynamic> json) {
//     attackNumber = json['attack_number'];
//     maxLifeNumber = json['max_life_number'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['attack_number'] = this.attackNumber;
//     data['max_life_number'] = this.maxLifeNumber;
//     return data;
//   }
// }
//
// class AbilityBattle {
//   String? critical;
//   String? specialty;
//   String? subdue;
//   String? agility;
//   String? endurance;
//   String? proficiency;
//
//   AbilityBattle({this.critical, this.specialty, this.subdue, this.agility, this.endurance, this.proficiency});
//
//   AbilityBattle.fromJson(Map<String, dynamic> json) {
//     critical = json['critical'];
//     specialty = json['specialty'];
//     subdue = json['subdue'];
//     agility = json['agility'];
//     endurance = json['endurance'];
//     proficiency = json['proficiency'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['critical'] = this.critical;
//     data['specialty'] = this.specialty;
//     data['subdue'] = this.subdue;
//     data['agility'] = this.agility;
//     data['endurance'] = this.endurance;
//     data['proficiency'] = this.proficiency;
//     return data;
//   }
// }
//
// class AbilityEngraveList {
//   List<String>? engraveName;
//   List<String>? engraveDes;
//
//   AbilityEngraveList({this.engraveName, this.engraveDes});
//
//   AbilityEngraveList.fromJson(Map<String, dynamic> json) {
//     engraveName = json['engrave_name'].cast<String>();
//     engraveDes = json['engrave_des'].cast<String>();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['engrave_name'] = this.engraveName;
//     data['engrave_des'] = this.engraveDes;
//     return data;
//   }
// }
//
// class AbilityTendecy {
//   String? intellect;
//   String? bravery;
//   String? charm;
//   String? kindness;
//
//   AbilityTendecy({this.intellect, this.bravery, this.charm, this.kindness});
//
//   AbilityTendecy.fromJson(Map<String, dynamic> json) {
//     intellect = json['intellect'];
//     bravery = json['bravery'];
//     charm = json['charm'];
//     kindness = json['kindness'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['intellect'] = this.intellect;
//     data['bravery'] = this.bravery;
//     data['charm'] = this.charm;
//     data['kindness'] = this.kindness;
//     return data;
//   }
// }
//
// class Card {
//   List<String>? cardName;
//   List<String>? cardImgUrl;
//   List<String>? cardCount;
//   List<String>? cardMax;
//   List<String>? cardEffectTitle;
//   List<String>? cardEffectDes;
//
//   Card({this.cardName, this.cardImgUrl, this.cardCount, this.cardMax, this.cardEffectTitle, this.cardEffectDes});
//
//   Card.fromJson(Map<String, dynamic> json) {
//     cardName = json['card_name'].cast<String>();
//     cardImgUrl = json['card_img_url'].cast<String>();
//     cardCount = json['card_count'].cast<String>();
//     cardMax = json['card_max'].cast<String>();
//     cardEffectTitle = json['card_effect_title'].cast<String>();
//     cardEffectDes = json['card_effect_des'].cast<String>();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['card_name'] = this.cardName;
//     data['card_img_url'] = this.cardImgUrl;
//     data['card_count'] = this.cardCount;
//     data['card_max'] = this.cardMax;
//     data['card_effect_title'] = this.cardEffectTitle;
//     data['card_effect_des'] = this.cardEffectDes;
//     return data;
//   }
// }
//
// class EquipList {
//   Weapon? weapon;
//   Head? head;
//   Head? top;
//   Head? bottom;
//   Head? gloves;
//   Head? shoulder;
//
//   EquipList({this.weapon, this.head, this.top, this.bottom, this.gloves, this.shoulder});
//
//   EquipList.fromJson(Map<String, dynamic> json) {
//     weapon = json['weapon'] != null ? Weapon.fromJson(json['weapon']) : null;
//     head = json['head'] != null ? Head.fromJson(json['head']) : null;
//     top = json['top'] != null ? Head.fromJson(json['top']) : null;
//     bottom = json['bottom'] != null ? Head.fromJson(json['bottom']) : null;
//     gloves = json['gloves'] != null ? Head.fromJson(json['gloves']) : null;
//     shoulder = json['shoulder'] != null ? Head.fromJson(json['shoulder']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     if (this.weapon != null) {
//       data['weapon'] = this.weapon!.toJson();
//     }
//     if (this.head != null) {
//       data['head'] = this.head!.toJson();
//     }
//     if (this.top != null) {
//       data['top'] = this.top!.toJson();
//     }
//     if (this.bottom != null) {
//       data['bottom'] = this.bottom!.toJson();
//     }
//     if (this.gloves != null) {
//       data['gloves'] = this.gloves!.toJson();
//     }
//     if (this.shoulder != null) {
//       data['shoulder'] = this.shoulder!.toJson();
//     }
//     return data;
//   }
// }
//
// class Weapon {
//   String? itemName;
//   String? upgrade;
//   int? grade;
//   ItemTitle? itemTitle;
//   Effect? effect;
//   Tripod? tripod;
//   String? setLevel;
//   String? setEffect;
//
//   Weapon({this.itemName, this.upgrade, this.grade, this.itemTitle, this.effect, this.tripod, this.setLevel, this.setEffect});
//
//   Weapon.fromJson(Map<String, dynamic> json) {
//     itemName = json['item_name'];
//     upgrade = json['upgrade'];
//     grade = json['grade'];
//     itemTitle = json['item_title'] != null ? ItemTitle.fromJson(json['item_title']) : null;
//     effect = json['effect'] != null ? Effect.fromJson(json['effect']) : null;
//     tripod = json['tripod'] != null ? Tripod.fromJson(json['tripod']) : null;
//     setLevel = json['set_level'];
//     setEffect = json['set_effect'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['item_name'] = this.itemName;
//     data['upgrade'] = this.upgrade;
//     data['grade'] = this.grade;
//     if (this.itemTitle != null) {
//       data['item_title'] = this.itemTitle!.toJson();
//     }
//     if (this.effect != null) {
//       data['effect'] = this.effect!.toJson();
//     }
//     if (this.tripod != null) {
//       data['tripod'] = this.tripod!.toJson();
//     }
//     data['set_level'] = this.setLevel;
//     data['set_effect'] = this.setEffect;
//     return data;
//   }
// }
//
// class ItemTitle {
//   String? imgUrl;
//   String? parts;
//   String? itemLevel;
//   int? quality;
//
//   ItemTitle({this.imgUrl, this.parts, this.itemLevel, this.quality});
//
//   ItemTitle.fromJson(Map<String, dynamic> json) {
//     imgUrl = json['img_url'];
//     parts = json['parts'];
//     itemLevel = json['item_level'];
//     quality = json['quality'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['img_url'] = this.imgUrl;
//     data['parts'] = this.parts;
//     data['item_level'] = this.itemLevel;
//     data['quality'] = this.quality;
//     return data;
//   }
// }
//
//
//
// class Tripod {
//   String? tripod1;
//   String? tripod2;
//   String? tripod3;
//
//   Tripod({this.tripod1, this.tripod2, this.tripod3});
//
//   Tripod.fromJson(Map<String, dynamic> json) {
//     tripod1 = json['tripod1'];
//     tripod2 = json['tripod2'];
//     tripod3 = json['tripod3'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['tripod1'] = this.tripod1;
//     data['tripod2'] = this.tripod2;
//     data['tripod3'] = this.tripod3;
//     return data;
//   }
// }
//
// class Head {
//   String? itemName;
//   String? upgrade;
//   int? grade;
//   ItemTitle? itemTitle;
//   Effect? effect;
//   Tripod? tripod;
//   String? setLevel;
//
//   Head({this.itemName, this.upgrade, this.grade, this.itemTitle, this.effect, this.tripod, this.setLevel});
//
//   Head.fromJson(Map<String, dynamic> json) {
//     itemName = json['item_name'];
//     upgrade = json['upgrade'];
//     grade = json['grade'];
//     itemTitle = json['item_title'] != null ? ItemTitle.fromJson(json['item_title']) : null;
//     effect = json['effect'] != null ? Effect.fromJson(json['effect']) : null;
//     tripod = json['tripod'] != null ? Tripod.fromJson(json['tripod']) : null;
//     setLevel = json['set_level'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['item_name'] = this.itemName;
//     data['upgrade'] = this.upgrade;
//     data['grade'] = this.grade;
//     if (this.itemTitle != null) {
//       data['item_title'] = this.itemTitle!.toJson();
//     }
//     if (this.effect != null) {
//       data['effect'] = this.effect!.toJson();
//     }
//     if (this.tripod != null) {
//       data['tripod'] = this.tripod!.toJson();
//     }
//     data['set_level'] = this.setLevel;
//     return data;
//   }
// }
//
// class Effect {
//   List<String>? basicEffect;
//   List<String>? plusEffect;
//
//   Effect({this.basicEffect, this.plusEffect});
//
//   Effect.fromJson(Map<String, dynamic> json) {
//     basicEffect = json['basic_effect'].cast<String>();
//     plusEffect = json['plus_effect'].cast<String>();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['basic_effect'] = this.basicEffect;
//     data['plus_effect'] = this.plusEffect;
//     return data;
//   }
// }
//
// class AccessoryList {
//   Necklace? necklace;
//   Earring1? earring1;
//   Earring1? earring2;
//   Earring1? ring1;
//   Earring1? ring2;
//   Bracelet? bracelet;
//
//   AccessoryList({this.necklace, this.earring1, this.earring2, this.ring1, this.ring2, this.bracelet});
//
//   AccessoryList.fromJson(Map<String, dynamic> json) {
//     necklace = json['necklace'] != null ? Necklace.fromJson(json['necklace']) : null;
//     earring1 = json['earring1'] != null ? Earring1.fromJson(json['earring1']) : null;
//     earring2 = json['earring2'] != null ? Earring1.fromJson(json['earring2']) : null;
//     ring1 = json['ring1'] != null ? Earring1.fromJson(json['ring1']) : null;
//     ring2 = json['ring2'] != null ? Earring1.fromJson(json['ring2']) : null;
//     bracelet = json['bracelet'] != null ? Bracelet.fromJson(json['bracelet']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     if (this.necklace != null) {
//       data['necklace'] = this.necklace!.toJson();
//     }
//     if (this.earring1 != null) {
//       data['earring1'] = this.earring1!.toJson();
//     }
//     if (this.earring2 != null) {
//       data['earring2'] = this.earring2!.toJson();
//     }
//     if (this.ring1 != null) {
//       data['ring1'] = this.ring1!.toJson();
//     }
//     if (this.ring2 != null) {
//       data['ring2'] = this.ring2!.toJson();
//     }
//     if (this.bracelet != null) {
//       data['bracelet'] = this.bracelet!.toJson();
//     }
//     return data;
//   }
// }
//
// class Necklace {
//   String? itemName;
//   int? grade;
//   ItemTitle? itemTitle;
//   List<Engrave>? engrave;
//
//   Necklace({this.itemName, this.grade, this.itemTitle, this.engrave});
//
//   Necklace.fromJson(Map<String, dynamic> json) {
//     itemName = json['item_name'];
//     grade = json['grade'];
//     itemTitle = json['item_title'] != null ? ItemTitle.fromJson(json['item_title']) : null;
//     if (json['engrave'] != null) {
//       engrave = <Engrave>[];
//       json['engrave'].forEach((v) {
//         engrave!.add(Engrave.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['item_name'] = this.itemName;
//     data['grade'] = this.grade;
//     if (this.itemTitle != null) {
//       data['item_title'] = this.itemTitle!.toJson();
//     }
//     if (this.engrave != null) {
//       data['engrave'] = this.engrave!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class ItemTitle {
//   String? parts;
//   String? imgUrl;
//   String? tier;
//   int? quality;
//
//   ItemTitle({this.parts, this.imgUrl, this.tier, this.quality});
//
//   ItemTitle.fromJson(Map<String, dynamic> json) {
//     parts = json['parts'];
//     imgUrl = json['img_url'];
//     tier = json['tier'];
//     quality = json['quality'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['parts'] = this.parts;
//     data['img_url'] = this.imgUrl;
//     data['tier'] = this.tier;
//     data['quality'] = this.quality;
//     return data;
//   }
// }
//
// class Engrave {
//   String? name;
//   String? point;
//
//   Engrave({this.name, this.point});
//
//   Engrave.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     point = json['point'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['name'] = this.name;
//     data['point'] = this.point;
//     return data;
//   }
// }
//
// class Earring1 {
//   String? itemName;
//   int? grade;
//   ItemTitle? itemTitle;
//   Effect? effect;
//   List<Engrave>? engrave;
//
//   Earring1({this.itemName, this.grade, this.itemTitle, this.effect, this.engrave});
//
//   Earring1.fromJson(Map<String, dynamic> json) {
//     itemName = json['item_name'];
//     grade = json['grade'];
//     itemTitle = json['item_title'] != null ? ItemTitle.fromJson(json['item_title']) : null;
//     effect = json['effect'] != null ? Effect.fromJson(json['effect']) : null;
//     if (json['engrave'] != null) {
//       engrave = <Engrave>[];
//       json['engrave'].forEach((v) {
//         engrave!.add(Engrave.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['item_name'] = this.itemName;
//     data['grade'] = this.grade;
//     if (this.itemTitle != null) {
//       data['item_title'] = this.itemTitle!.toJson();
//     }
//     if (this.effect != null) {
//       data['effect'] = this.effect!.toJson();
//     }
//     if (this.engrave != null) {
//       data['engrave'] = this.engrave!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Effect {
//   String? basicEffect;
//   String? plusEffect;
//
//   Effect({this.basicEffect, this.plusEffect});
//
//   Effect.fromJson(Map<String, dynamic> json) {
//     basicEffect = json['basic_effect'];
//     plusEffect = json['plus_effect'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['basic_effect'] = this.basicEffect;
//     data['plus_effect'] = this.plusEffect;
//     return data;
//   }
// }
//
// class Bracelet {
//   String? name;
//   int? grade;
//   ItemTitle? itemTitle;
//   List<String>? effect;
//
//   Bracelet({this.name, this.grade, this.itemTitle, this.effect});
//
//   Bracelet.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     grade = json['grade'];
//     itemTitle = json['item_title'] != null ? ItemTitle.fromJson(json['item_title']) : null;
//     effect = json['effect'].cast<String>();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['name'] = this.name;
//     data['grade'] = this.grade;
//     if (this.itemTitle != null) {
//       data['item_title'] = this.itemTitle!.toJson();
//     }
//     data['effect'] = this.effect;
//     return data;
//   }
// }
//
// class ItemTitle {
//   String? parts;
//   String? tier;
//   String? imgUrl;
//
//   ItemTitle({this.parts, this.tier, this.imgUrl});
//
//   ItemTitle.fromJson(Map<String, dynamic> json) {
//     parts = json['parts'];
//     tier = json['tier'];
//     imgUrl = json['img_url'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['parts'] = this.parts;
//     data['tier'] = this.tier;
//     data['img_url'] = this.imgUrl;
//     return data;
//   }
// }
//
// class Gem {
//   String? title;
//   String? grade;
//   String? imgUrl;
//   String? des;
//   String? skill;
//
//   Gem({this.title, this.grade, this.imgUrl, this.des, this.skill});
//
//   Gem.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     grade = json['grade'];
//     imgUrl = json['img_url'];
//     des = json['des'];
//     skill = json['skill'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['title'] = this.title;
//     data['grade'] = this.grade;
//     data['img_url'] = this.imgUrl;
//     data['des'] = this.des;
//     data['skill'] = this.skill;
//     return data;
//   }
// }
//
// class AbilityStone {
//   String? name;
//   int? grade;
//   ItemTitle? itemTitle;
//   Effect? effect;
//
//   AbilityStone({this.name, this.grade, this.itemTitle, this.effect});
//
//   AbilityStone.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     grade = json['grade'];
//     itemTitle = json['item_title'] != null ? ItemTitle.fromJson(json['item_title']) : null;
//     effect = json['effect'] != null ? Effect.fromJson(json['effect']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['name'] = this.name;
//     data['grade'] = this.grade;
//     if (this.itemTitle != null) {
//       data['item_title'] = this.itemTitle!.toJson();
//     }
//     if (this.effect != null) {
//       data['effect'] = this.effect!.toJson();
//     }
//     return data;
//   }
// }
//
// class Effect {
//   String? basicEffect;
//   String? plusEffect;
//   List<EngraveEffect>? engraveEffect;
//
//   Effect({this.basicEffect, this.plusEffect, this.engraveEffect});
//
//   Effect.fromJson(Map<String, dynamic> json) {
//     basicEffect = json['basic_effect'];
//     plusEffect = json['plus_effect'];
//     if (json['engrave_effect'] != null) {
//       engraveEffect = <EngraveEffect>[];
//       json['engrave_effect'].forEach((v) {
//         engraveEffect!.add(EngraveEffect.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['basic_effect'] = this.basicEffect;
//     data['plus_effect'] = this.plusEffect;
//     if (this.engraveEffect != null) {
//       data['engrave_effect'] = this.engraveEffect!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class EquipEngrave {
//   String? name;
//   String? point;
//   String? imgUrl;
//   String? des;
//   String? levelDes;
//
//   EquipEngrave({this.name, this.point, this.imgUrl, this.des, this.levelDes});
//
//   EquipEngrave.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     point = json['point'];
//     imgUrl = json['img_url'];
//     des = json['des'];
//     levelDes = json['level_des'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['name'] = this.name;
//     data['point'] = this.point;
//     data['img_url'] = this.imgUrl;
//     data['des'] = this.des;
//     data['level_des'] = this.levelDes;
//     return data;
//   }
// }