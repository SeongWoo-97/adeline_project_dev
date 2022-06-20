class CardModel {
  List<String>? cardName;
  List<String>? cardImgUrl;
  List<String>? cardCount;
  List<String>? cardMax;
  List<String>? cardEffectTitle;
  List<String>? cardEffectDes;
  List<String>? cardGrade;

  CardModel({
    this.cardName,
    this.cardImgUrl,
    this.cardCount,
    this.cardMax,
    this.cardEffectTitle,
    this.cardEffectDes,
    this.cardGrade,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    List<String>? cardGrade = [];
    List<String>? cardCount = [];
    List<String>? cardMax = [];

    if (json['card_count'] != null) {
      json['card_count'].forEach((v) {
        if (v != null) {
          cardCount.add(v);
        } else {
          cardCount.add('0');
        }
      });
    }
    if (json['card_max'] != null) {
      json['card_max'].forEach((v) {
        if (v != null) {
          cardMax.add(v);
        } else {
          cardMax.add('0');
        }
      });
    }
    if (json['card_grade'] != null) {
      json['card_grade'].forEach((v) {
        if (v != null) {
          cardGrade.add(v);
        } else {
          cardGrade.add('0');
        }
      });
    }
    print('cardCount : ${cardCount}');
    print('cardMax : ${cardMax}');
    print('cardGrade : ${cardGrade}');
    return CardModel(
      cardName: json['card_name'].cast<String>(),
      cardImgUrl: json['card_img_url'].cast<String>(),
      cardCount: cardCount,
      cardMax: cardMax,
      cardEffectTitle: json['card_effect_title'].cast<String>(),
      cardEffectDes: json['card_effect_des'].cast<String>(),
      cardGrade: cardGrade,
    );
  }
}
