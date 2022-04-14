import 'package:hive/hive.dart';

part 'daily_content.g.dart';
@HiveType(typeId: 3)
class DailyContent {
  @HiveField(0)
  String name;
  @HiveField(1)
  String iconName;
  @HiveField(2)
  bool isChecked = true;
  @HiveField(3)
  bool clearChecked = false;

  DailyContent(this.name, this.iconName, this.isChecked);
}
