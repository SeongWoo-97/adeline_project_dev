class CrystalPrice {
  String buy = "0";
  String sell = "0";

  CrystalPrice({required this.buy, required this.sell});

  factory CrystalPrice.fromJson(Map<String, dynamic> json) {
    return CrystalPrice(
      buy: json['Buy'],
      sell: json['Sell'],
    );
  }
}
