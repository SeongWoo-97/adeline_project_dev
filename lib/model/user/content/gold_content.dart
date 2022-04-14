import 'package:hive/hive.dart';

part 'gold_content.g.dart';
@HiveType(typeId: 5)
class GoldContent {
  @HiveField(0)
  String type; // 타입(필수) ex) 군단장, 어비스던전, 어비스레이드
  @HiveField(1)
  String name; // 이름(필수)
  @HiveField(2)
  int totalPhase; // 총 페이즈 개수(필수)
  @HiveField(3)
  int enterLevelLimit; // 최소 입장레벨(필수)
  @HiveField(4)
  String difficulty; // 난이도(선택)
  @HiveField(5)
  int getGoldLevelLimit; // 보상제한 레벨(선택)
  @HiveField(6)
  List<int> goldPerPhase = []; // 페이즈 별 골드(선택)
  @HiveField(7)
  List<int> levelLimitPerPhase = []; // 페이즈 별 레벨제한
  @HiveField(8)
  int clearGold; // 총 클리어 골드
  @HiveField(9)
  int addGold = 0;
  @HiveField(10)
  bool clearChecked = false;
  @HiveField(11)
  bool characterAlwaysMaxClear;
  @HiveField(12)
  bool isChecked = false;

  // 클리어 여부 변수 추가
  // 추가 골드 변수 추가
  // "이 캐릭터로는 항상 최대 클리어로 설정하기" 저장 변수 추가
  GoldContent({
    required this.type,
    required this.name,
    required this.totalPhase,
    required this.enterLevelLimit,
    required this.getGoldLevelLimit,
    required this.levelLimitPerPhase,
    required this.difficulty,
    required this.goldPerPhase,
    required this.clearGold,
    required this.characterAlwaysMaxClear,
  });

  GoldContent.clone(GoldContent goldContent)
      : this(
          type: goldContent.type,
          name: goldContent.name,
          totalPhase: goldContent.totalPhase,
          enterLevelLimit: goldContent.enterLevelLimit,
          getGoldLevelLimit: goldContent.getGoldLevelLimit,
          levelLimitPerPhase: goldContent.levelLimitPerPhase,
          difficulty: goldContent.difficulty,
          goldPerPhase: goldContent.goldPerPhase,
          clearGold: goldContent.clearGold,
          characterAlwaysMaxClear: goldContent.characterAlwaysMaxClear,
        );

  set setAddGold(int gold) {
    addGold = gold;
  }
}

int returnGoldContentsClearGold() {
  return 3;
}
