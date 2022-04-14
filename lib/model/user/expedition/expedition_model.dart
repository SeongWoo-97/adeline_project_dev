import 'package:adeline_project_dev/model/user/content/expedition_content.dart';
import 'package:hive/hive.dart';

part 'expedition_model.g.dart';

@HiveType(typeId: 8)
class Expedition {
  @HiveField(0)
  List<ExpeditionContent> list = [
    ExpeditionContent('주간','도전 어비스', 'assets/expedition/ChallengeAbyss.png'),
    ExpeditionContent('주간','도전 가디언', 'assets/daily/Guardian.png'),
    ExpeditionContent('주간','유령선', 'assets/expedition/GhostShip.png'),
    ExpeditionContent('주간','비탄의 섬', 'assets/expedition/Dungeon.png'),
    ExpeditionContent('주간','혼돈의 사선', 'assets/expedition/Dungeon.png'),
    ExpeditionContent('주간','에포나의 증표', 'assets/expedition/EponaCoin.png'),
    ExpeditionContent('주간','해적주화 교환', 'assets/etc/PirateCoin.png'),
    ExpeditionContent('일일','호감도', 'assets/expedition/LikeAbility.png'),
  ];
}
