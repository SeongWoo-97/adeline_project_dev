class LostArkEventNotice {
  String thumbImage; // 이벤트 썸네일 이미지
  String title; // 이벤트 이름
  String eventDateTime; // 이벤트 기간
  String receiveDate;
  String url; // 이벤트 주소

  LostArkEventNotice({
    required this.title,
    required this.url,
    required this.thumbImage,
    required this.eventDateTime,
    required this.receiveDate,
  });

  factory LostArkEventNotice.fromJson(Map<String, dynamic> json) {
    return LostArkEventNotice(
      title: json['title'],
      thumbImage: json['thumb'],
      eventDateTime: json['eventDate'],
      receiveDate: json['receiveDate'],
      url: json['url'],
    );
  }
}
