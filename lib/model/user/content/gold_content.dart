class GoldContent {
  String type; // 타입(필수) ex) 군단장, 어비스던전, 어비스레이드
  String name; // 이름(필수)
  int totalPhase; // 총 페이즈 개수(필수)
  int enterLevelLimit; // 최소 입장레벨(필수)

  String difficulty; // 난이도(선택)
  int getGoldLevelLimit; // 보상제한 레벨(선택)
  List<int> goldPerPhase = []; // 페이즈 별 골드(선택)
  List<int> levelLimitPerPhase = []; // 페이즈 별 레벨제한
  int clearGold; // 총 클리어 골드
  int addGold = 0;
  bool clearChecked = false;
  bool characterAlwaysMaxClear;
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
