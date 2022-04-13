import 'package:adeline_project_dev/model/user/content/expedition_content.dart';

class Expedition {
  List<ExpeditionContent> list = [
    ExpeditionContent('주간','도전 어비스', 'assets/expedition/ChallengeAbyss.png'),
    ExpeditionContent('주간','도전 가디언', 'assets/daily/Guardian.png'),
    ExpeditionContent('주간','유령선', 'assets/expedition/GhostShip.png'),
    ExpeditionContent('주간','비탄의 섬', 'assets/etc/Cube.png'),
    ExpeditionContent('주간','도전 어비스', 'assets/etc/BossRush.png'),
  ];

  Expedition();
}
