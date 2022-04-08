import 'package:adeline_project_dev/constant/constant.dart';
import 'package:adeline_project_dev/model/user/content/weekly_content.dart';

import '../content/gold_content.dart';
import '../content/restGauge_content.dart';

class Character {
  String nickName;
  String server;
  String groupName = "";
  var level;
  var job;
  bool expanded = false;

  List<dynamic> dailyContents = [
    RestGaugeContent('카오스 던전', 'assets/daily/Chaos.png', 2,true),
    RestGaugeContent('가디언 토벌', 'assets/daily/Guardian.png', 2,true),
    RestGaugeContent('에포나 의뢰', 'assets/daily/Epona.png', 3,true),
  ];
  List<WeeklyContent> weeklyContents = [
    WeeklyContent('주간 에포나', 'assets/week/WeeklyEpona.png', true),
    WeeklyContent('실마엘 혈석 교환', 'assets/etc/GuildCoin.png', true),
  ];
  List<GoldContent> goldContents = [];

  Character({required this.server, required this.nickName, this.level, this.job});

}
