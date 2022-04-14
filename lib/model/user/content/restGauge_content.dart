import 'package:hive/hive.dart';

part 'restGauge_content.g.dart';
@HiveType(typeId: 6)
class RestGaugeContent {
  @HiveField(0)
  String name;
  @HiveField(1)
  String iconName;
  @HiveField(2)
  bool isChecked = true;
  @HiveField(3)
  bool clearCheck = false; // 클리어 체크여부
  @HiveField(4)
  int clearNum = 0;
  @HiveField(5)
  int maxClearNum;
  @HiveField(6)
  int restGauge = 0;
  @HiveField(7)
  DateTime lateRevision = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day, 6); // 최근 수정일
  @HiveField(8)
  int saveRestGauge = 0;
  @HiveField(9)
  DateTime? saveLateRevision;

  RestGaugeContent(this.name, this.iconName, this.maxClearNum, this.isChecked);
}
