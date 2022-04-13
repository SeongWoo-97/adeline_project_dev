class RestGaugeContent {
  String name;
  String iconName;
  bool isChecked = true;
  bool clearCheck = false; // 클리어 체크여부
  int clearNum = 0;
  int maxClearNum;
  int restGauge = 0;
  DateTime lateRevision = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day, 6); // 최근 수정일
  int saveRestGauge = 0;
  DateTime? saveLateRevision;

  RestGaugeContent(this.name, this.iconName, this.maxClearNum, this.isChecked);
}
