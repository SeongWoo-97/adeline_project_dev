class Card {
  List<String>? cardName;
  List<String>? cardImgUrl;
  List<String>? cardCount;
  List<String>? cardMax;
  List<String>? cardEffectTitle;
  List<String>? cardEffectDes;

  Card({this.cardName, this.cardImgUrl, this.cardCount, this.cardMax, this.cardEffectTitle, this.cardEffectDes});

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      cardName: json['card_name'].cast<String>(),
      cardImgUrl: json['card_img_url'].cast<String>(),
      cardCount: json['card_count'].cast<String>(),
      cardMax: json['card_max'].cast<String>(),
      cardEffectTitle: json['card_effect_title'].cast<String>(),
      cardEffectDes: json['card_effect_des'].cast<String>(),
    );
  }
}