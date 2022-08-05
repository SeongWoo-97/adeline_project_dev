import 'package:hive/hive.dart';

part 'raid_content.g.dart';

@HiveType(typeId: 5)
class RaidContent {
  @HiveField(0)
  String type; // 타입(필수) ex) 군단장, 어비스던전, 어비스레이드
  @HiveField(1)
  String name; // 이름(필수)
  @HiveField(2)
  int totalPhase; // 총 페이즈 개수(필수)
  @HiveField(3)
  List<String> difficulty; // 난이도(선택)
  @HiveField(4)
  int getGoldLevelLimit; // 보상제한 레벨(선택)
  @HiveField(5)
  int clearGold; // 총 클리어 골드
  @HiveField(6)
  int addGold = 0;
  @HiveField(7)
  bool clearChecked = false;
  @HiveField(8)
  bool isChecked = false;
  @HiveField(9)
  Map<String, Map<String, dynamic>> reward; // 골드 보상
  @HiveField(10)
  List<CheckHistory> clearList;
  @HiveField(11)
  List<CheckHistory> bonusList;
  @HiveField(12)
  int clearCheckStandardPhase;
  @HiveField(13,defaultValue: 0)
  int minusGold = 0;

  RaidContent({
    required this.type,
    required this.name,
    required this.totalPhase,
    required this.getGoldLevelLimit,
    required this.difficulty,
    required this.clearGold,
    required this.reward,
    required this.clearList,
    required this.bonusList,
    required this.clearCheckStandardPhase,
  });

  factory RaidContent.clone(RaidContent raidContent) {
    List<CheckHistory> list1 =
        List.generate(raidContent.totalPhase, (index) => CheckHistory(difficulty: raidContent.difficulty.first, check: false));
    List<CheckHistory> list2 =
        List.generate(raidContent.totalPhase, (index) => CheckHistory(difficulty: raidContent.difficulty.first, check: false));
    return RaidContent(
      type: raidContent.type,
      name: raidContent.name,
      totalPhase: raidContent.totalPhase,
      getGoldLevelLimit: raidContent.getGoldLevelLimit,
      difficulty: raidContent.difficulty,
      clearGold: raidContent.clearGold,
      reward: raidContent.reward,
      clearList: list1,
      bonusList: list2,
      clearCheckStandardPhase: raidContent.clearCheckStandardPhase,
    );
  }
}

@HiveType(typeId: 9)
class CheckHistory {
  @HiveField(0)
  bool check;
  @HiveField(1)
  String difficulty;

  CheckHistory({required this.difficulty, required this.check});
}
