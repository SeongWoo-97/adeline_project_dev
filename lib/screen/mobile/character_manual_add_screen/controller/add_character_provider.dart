import 'package:drag_and_drop_lists/drag_and_drop_list.dart';
import 'package:flutter/cupertino.dart';

import '../../../../constant/constant.dart';
import '../../../../model/user/character/character_model.dart';
import '../../../../model/user/content/daily_content.dart';
import '../../../../model/user/content/gold_content.dart';
import '../../../../model/user/content/restGauge_content.dart';
import '../../../../model/user/content/weekly_content.dart';

class AddCharacterProvider extends ChangeNotifier {
  Character character = Character(nickName: '', server: '', jobCode: '');
  int tag = 0;
  String iconName = iconList[0].iconName!;
  List<String> options = ['일일 콘텐츠', '주간 콘텐츠', '골드 콘텐츠'];
  int selected = 0;

  final key = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

  bool nickNameError = false;
  bool levelError = false;
  bool chaosError = false;
  bool guardianError = false;
  bool eponaError = false;

  TextEditingController addController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  TextEditingController chaosGaugeController = TextEditingController(text: '0');
  TextEditingController guardianGaugeController = TextEditingController(text: '0');
  TextEditingController eponaGaugeController = TextEditingController(text: '0');

  DragAndDropList dailyDragAndDrop = DragAndDropList(children: []);
  DragAndDropList weeklyDragAndDrop = DragAndDropList(children: []);

  List<dynamic> dailyContents = [
    RestGaugeContent('카오스 던전', 'assets/daily/Chaos.png', 2, true),
    RestGaugeContent('가디언 토벌', 'assets/daily/Guardian.png', 2, true),
    RestGaugeContent('에포나 의뢰', 'assets/daily/Epona.png', 3, true),
  ];

  List<WeeklyContent> weeklyContents = [
    WeeklyContent('주간 에포나', 'assets/week/WeeklyEpona.png', true),
    WeeklyContent('실마엘 혈석 교환', 'assets/etc/GuildCoin.png', true),
  ];

  List<GoldContent> goldContents =
      List.generate(constGoldContents.length, (index) => GoldContent.clone(constGoldContents[index]));

  void addContent(BuildContext context, String contentType, String name) {
    switch (contentType) {
      case "일일":
        dailyContents.add(DailyContent(name, iconName, true));
        break;
      case "주간":
        weeklyContents.add(WeeklyContent(name, iconName, true));
        break;
    }
    notifyListeners();
  }

  void updateDailyContent(int index, DailyContent dailyContent) {
    dailyContents[index] = dailyContent;
    notifyListeners();
  }

  void updateWeeklyContent(int index, WeeklyContent weeklyContent) {
    weeklyContents[index] = weeklyContent;
    notifyListeners();
  }
}
