import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:web_scraper/web_scraper.dart';
import '../../../../../model/user/character/character_model.dart';
import '../../../../../model/user/expedition/expedition_model.dart';
import '../../../../../model/user/expedition/expedition_provider.dart';
import '../../../../../model/user/user.dart';
import '../../../../../model/user/user_provider.dart';
import '../../../bottom_navigation_screen/bottom_navigation_screen.dart';

ValueNotifier<String> getCharacterNickName = ValueNotifier<String>('');
ValueNotifier<int> getCharacterNum = ValueNotifier<int>(0);

class InitSettingsController extends ChangeNotifier {
  final webScraper = WebScraper('https://lostark.game.onstove.com');
  TextEditingController textEditingController = TextEditingController();
  var nickName;
  var level;
  var job;
  int currentStep = 0;
  List<ListTile> charactersListTile = [];
  List<String> nickNameList = [];
  List<Character> characters = [];
  Map<String, List<Character>> servers = {};
  int tag = 0;

  void tagChange(int value) {
    tag = value;
    notifyListeners();
  }

  void configCompleted(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    ExpeditionProvider expeditionProvider = Provider.of<ExpeditionProvider>(context, listen: false);
    List<String> server = servers.keys.toList();
    userProvider.charactersProvider.characters = List.from(servers[server[tag]]!.reversed);
    expeditionProvider.expedition = Expedition();

    final characterBox = Hive.box<User>('characters');
    final expeditionBox = Hive.box<Expedition>('expedition');

    DateTime now = DateTime.now();
    DateTime nowDate = DateTime.utc(now.year, now.month, now.day, 6);

    // nextWednesday 에 다음주 수요일 값을 넣는 코드
    if (nowDate.weekday == 3) {
      expeditionProvider.expedition.nextWednesday = nowDate.add(Duration(days: 7));
    } else {
      while (nowDate.weekday != 3) {
        nowDate = nowDate.add(Duration(days: 1));
        expeditionProvider.expedition.nextWednesday = nowDate;
      }
    }
    print('설정완료 후 : ${expeditionProvider.expedition.nextWednesday}');
    characterBox.put('user', User(characters: userProvider.charactersProvider.characters));
    expeditionBox.put('expeditionList', expeditionProvider.expedition);
    Navigator.pop(context);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomNavigationScreen(index: 1,)), (route) => false);
  }

  // 캐릭터 유무확인 메서드
  bool getCharStateCheck(String nickName) {
    bool state = webScraper.getElementTitle('div.profile-ingame > div.profile-attention').toString().contains('캐릭터 정보가 없습니다.');
    // state 참 - 캐릭터가 존재하지 않음
    // state 거짓 - 캐릭터가 존재함
    return state ? true : false;
  }

  // 입력한 캐릭터 닉네임,직업,레벨 가져오는 메서드
  Future characterInfo(BuildContext context, String name) async {
    nickName = name;
    try {
      getCharacterShowDialog(context); // 정보확인 중 로딩창
      await webScraper.loadWebPage('/Profile/Character/$nickName');
      job = webScraper.getElementAttribute('div > main > div > div.profile-character-info > img', 'alt');
      level = webScraper.getElementTitle('div.profile-ingame > div.profile-info > div.level-info2 > div.level-info2__item');
      if (job.isNotEmpty && level.isNotEmpty && !getCharStateCheck(nickName)) {
        Navigator.pop(context);
        showPlatformDialog(
          context: context,
          builder: (_) => PlatformAlertDialog(
            material: (_, __) => MaterialAlertDialogData(
              title: Text('$nickName'),
              content: Text(
                'Lv.${levelText(level[0].toString())} ${job[0]} ',
              ),
            ),
            cupertino: (_, __) => CupertinoAlertDialogData(
              title: Text('$nickName'),
              content: Column(
                children: [
                  Text('${job[0]} ${level[0].toString().replaceAll('달성 아이템 레벨', '')} '),
                ],
              ),
            ),
            actions: [
              PlatformDialogAction(
                child: PlatformText('아닙니다'),
                onPressed: () => Navigator.pop(context),
              ),
              PlatformDialogAction(
                // 캐릭터 순서 페이지로 이동
                child: PlatformText('맞습니다'),
                onPressed: () async {
                  Navigator.pop(context);
                  await getCharList(context);
                  continued();
                },
              ),
            ],
          ),
        );
      } else {
        customMsgShowDialog(context, '오류', '존재하지 않는 닉네임입니다.');
      }

    } on WebScraperException catch(e){
      customMsgShowDialog(context, '오류', '로스트아크 서버 점검 또는 인터넷이 연결되어 있지 않습니다.');
      print(e.errorMessage());
    }
  }

  getCharList(BuildContext context) async {
    characters.clear();
    servers.clear();
    nickNameList = webScraper.getElementTitle('#expand-character-list > ul > li > span > button > span');
    getCharacterNickName.value = nickNameList[0];
    getCharacterNum.value = 0;
    showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        title: ValueListenableBuilder(
          valueListenable: getCharacterNum,
          builder: (BuildContext context, int num, Widget? child) {
            return Text('${num + 1}/${nickNameList.length}');
          },
        ),
        content: ValueListenableBuilder(
          valueListenable: getCharacterNickName,
          builder: (BuildContext context, String nickName, Widget? child) {
            return Text('$nickName \n캐릭터 불러오는 중');
          },
        ),
      ),
      barrierDismissible: false,
    );
    for (int i = 0; i < nickNameList.length; i++) {
      bool loadWebPage = await webScraper.loadWebPage('/Profile/Character/${nickNameList[i]}');
      if (loadWebPage) {
        getCharacterNickName.value = nickNameList[i];
        getCharacterNum.value = i;
        var _job = webScraper.getElementAttribute('div > main > div > div.profile-character-info > img', 'alt')[0];
        var _level = levelText(
            webScraper.getElementTitle('div.profile-ingame > div.profile-info > div.level-info2 > div.level-info2__item')[0]);
        var _server =
            serverText(webScraper.getElementTitle('div.profile-character-info > span.profile-character-info__server')[0]);
        Character character = Character(
          server: _server,
          nickName: getCharacterNickName.value,
          level: _level,
          job: _job,
          jobCode: getJobCode(_job),
        );
        characters.add(character);
        // 서버 분류
        if (servers.containsKey('$_server')) {
          servers['$_server']?.add(Character(
            server: _server,
            nickName: getCharacterNickName.value,
            level: _level,
            job: _job,
            jobCode: getJobCode(_job),
          ));
        } else {
          servers['$_server'] = [];
          servers['$_server']?.add(Character(
            server: _server,
            nickName: getCharacterNickName.value,
            level: _level,
            job: _job,
            jobCode: getJobCode(_job),
          ));
        }
      }
      // else {
      //   // 점검또는 네트워크 또는 기타오류 출력 추가하기
      // }
    }
    characters = List.from(characters); // 캐릭터 순서 reversed
    Navigator.pop(context);
  }

  // 레벨 Text 정리해주는 메서드
  String levelText(String level) {
    int start = level.indexOf('.') + 1;
    int end = level.lastIndexOf('.');
    return level.substring(start, end).replaceAll(new RegExp(r'[^0-9]'), '');
  }

  String serverText(String server) {
    return server.replaceAll('@', '');
  }

  // 커스텀 오류 showDialog
  Future customMsgShowDialog(BuildContext context, String title, String content) {
    Navigator.pop(context);
    return showPlatformDialog(
        context: context,
        builder: (BuildContext context) {
          return PlatformAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              PlatformDialogAction(
                child: PlatformText('확인'),
                // 캐릭터 순서 페이지로 이동
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  // 캐릭터 불러오는 로딩 showDialog
  Future getCharacterShowDialog(BuildContext context) {
    return showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        material: (_, __) => MaterialAlertDialogData(
          title: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircularProgressIndicator(),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text('$nickName 정보 확인 중', style: Theme.of(context).textTheme.bodyText1),
              )
            ],
          ),
        ),
        cupertino: (_, __) => CupertinoAlertDialogData(), // 기존소스 보고 수정하기
      ),
    );
  }

  // 해당 step 으로 이동
  tapped(int step) {
    currentStep = step;
    notifyListeners();
  }

  // 다음단계
  continued() {
    currentStep < 2 ? currentStep += 1 : null;
    notifyListeners();
  }

  // 이전단계
  cancel() {
    currentStep > 0 ? currentStep -= 1 : null;
    notifyListeners();
  }

  loadingShowDialog(BuildContext context) {
    showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        material: (_, __) => MaterialAlertDialogData(
          title: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircularProgressIndicator(),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text(
                  '$nickName 정보 확인 중',
                ),
              )
            ],
          ),
        ),
        cupertino: (_, __) => CupertinoAlertDialogData(), // 기존소스 보고 수정하기
      ),
    );
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
}
