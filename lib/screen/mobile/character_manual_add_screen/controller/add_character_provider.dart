import 'package:drag_and_drop_lists/drag_and_drop_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../constant/constant.dart';
import '../../../../model/user/character/character_model.dart';
import '../../../../model/user/content/daily_content.dart';
import '../../../../model/user/content/gold_content.dart';
import '../../../../model/user/content/restGauge_content.dart';
import '../../../../model/user/content/weekly_content.dart';
import '../../../../model/user/user_provider.dart';

class AddCharacterProvider extends ChangeNotifier {
  Character character = Character(nickName: '', server: '', jobCode: '');
  int tag = 0;
  String iconName = iconList[0].iconName!;
  List<String> options = ['일일 콘텐츠', '주간 콘텐츠', '골드 콘텐츠'];
  int selected = 0;
  String server = "";
  String job = "";

  final key = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

  bool nickNameError = true;
  bool levelError = true;
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
    RestGaugeContent('카오스 던전', 'assets/daily/Chaos.png', 2, false),
    RestGaugeContent('가디언 토벌', 'assets/daily/Guardian.png', 2, false),
    RestGaugeContent('에포나 의뢰', 'assets/daily/Epona.png', 3, false),
  ];

  List<WeeklyContent> weeklyContents = [
    WeeklyContent('주간 에포나', 'assets/week/WeeklyEpona.png', true),
    WeeklyContent('실마엘 혈석 교환', 'assets/etc/GuildCoin.png', true),
    WeeklyContent('카양겔', 'assets/week/AbyssDungeon.png', false),
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

  void addCharacter(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    if (!nickNameError && !levelError && !chaosError && !guardianError && !eponaError && job.isNotEmpty && server.isNotEmpty) {
      userProvider.addCharacter(
        Character(
          server: server,
          nickName: nickNameController.text,
          level: levelController.text,
          job: job,
          jobCode: getJobCode(job),
        ),
      );
      Navigator.pop(context);
    } else {
      toast('양식이 올바르지 않습니다.');
    }
    print('분류 : $nickNameError, $levelError, $chaosError, $guardianError, $eponaError');
  }

  String getJobCode(String? job) {
    switch (job) {
      case "버서커":
        return "102";
      case "디스트로이어":
        return "103";
      case "워로드":
        return "104";
      case "홀리나이트":
        return "105";
      case "아르카나":
        return "202";
      case "서머너":
        return "203";
      case "바드":
        return "204";
      case "소서리스":
        return "205";
      case "배틀마스터":
        return "302";
      case "인파이터":
        return "303";
      case "기공사":
        return "304";
      case "창술사":
        return "305";
      case "스트라이커":
        return "312";
      case "데모닉":
        return "403";
      case "블레이드":
        return "402";
      case "리퍼":
        return "404";
      case "호크아이":
        return "502"; // 65215124
      case "데빌헌터":
        return "503";
      case "블래스터":
        return "504";
      case "스카우터":
        return "505";
      case "건슬링어":
        return "512";
      case "도화가":
        return "602";
    }
    return "0";
  }

  void toast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16,
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.white,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
    );
  }
}
