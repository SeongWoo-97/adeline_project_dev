class LostArkNotice {
  String title;
  String category;
  String url;
  String date;

  LostArkNotice({
    required this.title,
    required this.category,
    required this.url,
    required this.date,
  });

  factory LostArkNotice.fromJson(Map<String, dynamic> json) {
    return LostArkNotice(
      title: json['title'],
      category: json['category'],
      url: json['url'],
      date: json['date'],
    );
  }
}
