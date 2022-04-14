import 'package:hive/hive.dart';

part 'weekly_content.g.dart';
@HiveType(typeId: 4)
class WeeklyContent {
  @HiveField(0)
  String name;
  @HiveField(1)
  String iconName;
  @HiveField(2)
  bool isChecked = true;
  @HiveField(3)
  bool clearChecked = false;

  WeeklyContent(this.name, this.iconName, this.isChecked);
}
