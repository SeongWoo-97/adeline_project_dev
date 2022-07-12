import 'package:hive/hive.dart';

import '../content/expedition_content.dart';

part 'expedition_model.g.dart';

@HiveType(typeId: 8)
class Expedition {
  @HiveField(0)
  List<ExpeditionContent> list = [
    ExpeditionContent('주간', '도전 어비스', 'assets/expedition/ChallengeAbyss.png'),
    ExpeditionContent('주간', '도전 가디언', 'assets/daily/1.png'),
    ExpeditionContent('주간', '유령선', 'assets/expedition/GhostShip.png'),
    ExpeditionContent('주간', '비탄의 섬', 'assets/expedition/Dungeon.png'),
    ExpeditionContent('주간', '혼돈의 사선', 'assets/expedition/Dungeon.png'),
    ExpeditionContent('주간', '에포나의 증표', 'assets/expedition/EponaCoin.png'),
    ExpeditionContent('주간', '해적주화 교환', 'assets/etc/PirateCoin.png'),
    ExpeditionContent('주간', '지도 교환', 'assets/etc/카게지도.png'),
    ExpeditionContent('일일', '호감도', 'assets/expedition/LikeAbility.png'),
  ];
  @HiveField(1)
  DateTime recentInitDateTime = DateTime.now(); // 최근 초기화 일자 [원정대 일일콘텐츠 초기화할 때 사용되는 값]
  @HiveField(2)
  DateTime nextWednesday = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day, 6); // 다음주 수요일 값 [주간 콘텐츠 초기화 할때 사용되는 값]
}
