import 'package:hive/hive.dart';

part 'expedition_content.g.dart';
@HiveType(typeId: 7)
class ExpeditionContent {
  @HiveField(0)
  String type;
  @HiveField(1)
  String name;
  @HiveField(2)
  String iconName;
  @HiveField(3)
  bool clearCheck = false;
  @HiveField(4)
  bool isChecked = true;

  ExpeditionContent(this.type, this.name, this.iconName);
}
