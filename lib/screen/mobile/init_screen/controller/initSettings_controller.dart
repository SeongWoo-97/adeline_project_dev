import 'package:adeline_project_dev/model/user/expedition/expedition_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:web_scraper/web_scraper.dart';
import '../../../../model/user/character/character_model.dart';
import '../../../../model/user/user_provider.dart';
import '../../bottom_navigation_screen/bottom_navigation_screen.dart';

class InitSettingsController extends ChangeNotifier {
  final webScraper = WebScraper('https://lostark.game.onstove.com');
  TextEditingController textEditingController = TextEditingController(text: "황농노");
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
    UserProvider userProvider = Provider.of<UserProvider>(context,listen: false);
    List<String> server = servers.keys.toList();
    userProvider.charactersProvider.characters = servers[server[tag]]!;
    userProvider.expeditionProvider = ExpeditionProvider();
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => BottomNavigationScreen()), (route) => false);
  }

  // 캐릭터 유무확인 메서드
  bool getCharStateCheck(String nickName) {
    bool state =
        webScraper.getElementTitle('div.profile-ingame > div.profile-attention').toString().contains('캐릭터 정보가 없습니다.');
    // state 참 - 캐릭터가 존재하지 않음
    // state 거짓 - 캐릭터가 존재함
    return state ? true : false;
  }

  // 입력한 캐릭터 닉네임,직업,레벨 가져오는 메서드
  Future characterInfo(BuildContext context, String name) async {
    nickName = name;
    bool loadWebPageBool = await webScraper.loadWebPage('/Profile/Character/$nickName');
    bool getCharStateCheckBool = !getCharStateCheck(nickName);
    bool textControllerEmptyBool = textEditingController.text.isNotEmpty;

    getCharacterShowDialog(context);

    if (loadWebPageBool & getCharStateCheckBool & textControllerEmptyBool) {
      Navigator.pop(context);
      job = webScraper.getElementAttribute('div > main > div > div.profile-character-info > img', 'alt');
      level =
          webScraper.getElementTitle('div.profile-ingame > div.profile-info > div.level-info2 > div.level-info2__item');

      if (job.isNotEmpty && level.isNotEmpty) {
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
      }
    } else if (!textControllerEmptyBool) {
      customMsgShowDialog(context, '오류', '닉네임을 입력해 주시길 바랍니다.');
    } else if (!getCharStateCheckBool) {
      customMsgShowDialog(context, '오류', '로스트아크 서버 점검 또는 존재하지 않는 닉네임입니다.');
    }
  }

  ValueNotifier<String> getCharacterNickName = ValueNotifier<String>('');
  ValueNotifier<int> getCharacterNum = ValueNotifier<int>(0);

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
        var _level = levelText(webScraper
            .getElementTitle('div.profile-ingame > div.profile-info > div.level-info2 > div.level-info2__item')[0]);
        var _server = serverText(
            webScraper.getElementTitle('div.profile-character-info > span.profile-character-info__server')[0]);
        Character character = Character(
          server: _server,
          nickName: getCharacterNickName.value,
          level: _level,
          job: _job,
        );
        characters.add(character);
        if (servers.containsKey('$_server')) {
          servers['$_server']?.add(Character(
            server: _server,
            nickName: getCharacterNickName.value,
            level: _level,
            job: _job,
          ));
        } else {
          servers['$_server'] = [];
          servers['$_server']?.add(Character(
            server: _server,
            nickName: getCharacterNickName.value,
            level: _level,
            job: _job,
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
}