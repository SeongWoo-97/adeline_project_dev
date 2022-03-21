import 'package:adeline_project_dev/model/user/content/daily_content.dart';
import 'package:adeline_project_dev/model/user/content/gold_content.dart';
import 'package:adeline_project_dev/model/user/content/weekly_content.dart';

class Character {
  String nickName;
  var level;
  var job;
  bool expanded = false;

  List<DailyContent> dailyContents = [];
  List<WeeklyContent> weeklyContents = [];
  List<GoldContent> goldContents = [];

  Character(this.nickName, this.level, this.job);
}
