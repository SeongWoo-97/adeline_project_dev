
import 'package:adeline_app/model/user/content/daily_content.dart';
import 'package:hive/hive.dart';

import '../content/raid_content.dart';
import '../content/restGauge_content.dart';
import '../content/weekly_content.dart';
part 'character_model.g.dart';
@HiveType(typeId: 2)
class Character {
  @HiveField(0)
  String nickName;
  @HiveField(1)
  String? server;
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
    RestGaugeContent('카오스 던전', 'assets/daily/0.png', 2, true),
    RestGaugeContent('가디언 토벌', 'assets/daily/1.png', 2, true),
    RestGaugeContent('에포나 의뢰', 'assets/daily/2.png', 3, true),
    DailyContent('길드 출석', 'assets/etc/길드출석.png', true)
  ];
  @HiveField(7)
  List<WeeklyContent> weeklyContents = [
    WeeklyContent('주간 에포나', 'assets/week/WeeklyEpona.png', true),
    WeeklyContent('주간 길드 퀘스트', 'assets/etc/주간길드.png', true),
    WeeklyContent('실마엘 혈석 교환', 'assets/etc/GuildCoin.png', true),
    WeeklyContent('토벌전', 'assets/etc/SubjugationBattle.png', true),

  ];
  @HiveField(8)
  List<RaidContent> raidContents = [];

  int tag = 0;

  List<String> options = ['레이드'];

  bool expanded = false;

  Character({required this.nickName, this.level, this.job, required this.jobCode});

}
