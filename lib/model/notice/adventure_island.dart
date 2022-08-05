class AdventureIsland {
  List<Island> islandList;
  String islandDate;
  String result;

  AdventureIsland({
    required this.islandList,
    required this.result,
    required this.islandDate,
  });

  factory AdventureIsland.fromJson(Map<String, dynamic> json) {
    List<Island> tempList = [];
    if (json['Island'].length != 0) {
      json['Island'].forEach((element) {
        tempList.add(Island.fromJson(element));
      });
    }

    return AdventureIsland(
      islandList: tempList,
      result: json['Result'],
      islandDate: json['IslandDate'],
    );
  }
}

class Island {
  String? name;
  String? reward;

  Island({
    required this.name,
    required this.reward,
  });

  factory Island.fromJson(Map<String, dynamic> json) {
    return Island(
      name: json['Name'].length != 0 ? json['Name'] : '메데이아',
      reward: json['Reward'].length != 0 ? json['Reward'] : '실링',
    );
  }
}
