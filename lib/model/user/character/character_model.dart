import 'package:adeline_project_dev/model/user/content/weekly_content.dart';
import 'package:hive/hive.dart';

import '../content/gold_content.dart';
import '../content/restGauge_content.dart';
part 'character_model.g.dart';
@HiveType(typeId: 2)
class Character {
  @HiveField(0)
  String nickName;
  @HiveField(1)
  String server;
  @HiveField(2)
  String groupName = "";
  @HiveField(3)
  String jobCode = "";
  @HiveField(4)
  var level;
  @HiveField(5)
  var job;
  @HiveField(6)
  List<dynamic> dailyContents = [
    RestGaugeContent('카오스 던전', 'assets/daily/Chaos.png', 2, false),
    RestGaugeContent('가디언 토벌', 'assets/daily/Guardian.png', 2, false),
    RestGaugeContent('에포나 의뢰', 'assets/daily/Epona.png', 3, false),
  ];
  @HiveField(7)
  List<WeeklyContent> weeklyContents = [
    WeeklyContent('주간 에포나', 'assets/week/WeeklyEpona.png', true),
    WeeklyContent('실마엘 혈석 교환', 'assets/etc/GuildCoin.png', true),
    WeeklyContent('카양겔', 'assets/week/AbyssDungeon.png', false),
  ];
  @HiveField(8)
  List<GoldContent> goldContents = [];

  List<String> options = [];

  bool expanded = false;

  Character({required this.server, required this.nickName, this.level, this.job, required this.jobCode});

}
