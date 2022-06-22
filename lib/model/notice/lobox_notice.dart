class LoboxNotice {
  String title = "0";
  String des = "0";

  LoboxNotice({required this.title, required this.des});

  factory LoboxNotice.fromJson(Map<String, dynamic> json) {
    return LoboxNotice(
      title: json['title'],
      des: json['des'],
    );
  }
}
