import 'dart:async';
import 'dart:convert';

import 'package:adeline_app/main.dart';
import 'package:adeline_app/model/character_list/character_list.dart';
import 'package:adeline_app/model/toast/toast.dart';
import 'package:adeline_app/screen/home_work/characters_slot/character_slot_layout.dart';
import 'package:adeline_app/screen/main/mobile/mobile_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../../../model/user/character/character_model.dart';
import '../../../../../model/user/expedition/expedition_model.dart';
import '../../../../../model/user/expedition/expedition_provider.dart';
import '../../../../../model/user/user.dart';
import '../../../../../model/user/user_provider.dart';

class InitSettingsController extends ChangeNotifier {
  TextEditingController textEditingController = TextEditingController(text: 'duggy2');
  var nickName;
  var level;
  var job;
  List<Character> characters = [];

  void configCompleted(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    ExpeditionProvider expeditionProvider = Provider.of<ExpeditionProvider>(context, listen: false);
    userProvider.charactersProvider.characters = characters;
    expeditionProvider.expedition = Expedition();

    final characterBox = Hive.box<User>(hiveUserName);
    final expeditionBox = Hive.box<Expedition>(hiveExpeditionName);

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
    characterBox.put('user', User(characters: userProvider.charactersProvider.characters));
    expeditionBox.put('expeditionList', expeditionProvider.expedition);
    if (MediaQuery.of(context).size.width >= 800) {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterSlotLayout()));
    } else {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MobileMainScreen(index: 1)), (route) => false);
    }
  }

  // 입력한 캐릭터 목록 가져오는 showDialog 위젯
  Future characterInfo(BuildContext context, String name) async {
    nickName = name;
    characters.clear();
    showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        material: (_, __) => MaterialAlertDialogData(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Text('${nickName.toString().toUpperCase()}가 맞습니까?', style: Theme.of(context).textTheme.bodyText1)],
          ),
          contentPadding: const EdgeInsets.fromLTRB(12.0, 24.0, 12.0, 0.0),
        ),
        cupertino: (_, __) => CupertinoAlertDialogData(), // 기존소스 보고 수정하기
        actions: [
          PlatformDialogAction(
            child: PlatformText('아닙니다'),
            onPressed: () {
              print('아닙니다');
              Navigator.pop(context);
            },
          ),
          PlatformDialogAction(
            child: PlatformText('맞습니다'),
            onPressed: () async {
              getCharacterList(context, name);
            },
          ),
        ],
      ),
    );
  }

  // 입력한 캐릭터 목록 가져오는 메서드
  Future getCharacterList(BuildContext context, String name) async {
    try {
      getCharacterLoadingDialog(context); // 로딩 창
      http.Response response = await http.get(Uri.parse('http://132.226.22.9:3381/lobox/characters/$name')).timeout(Duration(seconds: 7));
      Map<String, dynamic> json = jsonDecode(response.body);
      CharacterList characterList = CharacterList.fromJson(json);
      if (characterList.result != "fail" && characterList.list?.length != 0) {
        characterList.list?.forEach((element) {
          print('${element.name} ${element.level} ${element.job}');
          Character character = Character(
            nickName: element.name,
            job: element.job,
            level: element.level,
            jobCode: getJobCode(element.job),
          );
          characters.add(character);
        });
        Navigator.pop(context);
        configCompleted(context);
      } else {
        ToastMessage.toast('캐릭터 닉네임이 잘못되거나 로스트아크 서버가 점검 중입니다.');
        Navigator.pop(context);
      }
    } on TimeoutException {
      Navigator.pop(context);
      ToastMessage.toast('접속 시간이 초과 되었습니다.');
    } catch (e) {
      customMsgShowDialog(context, '오류', '로스트아크 서버 점검 또는 인터넷이 연결되어 있지 않습니다.');
      print('오류(characterInfo) : $e');
    }
  }

  // 커스텀 오류 showDialog
  Future customMsgShowDialog(BuildContext context, String title, String content) {
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
  Future<void> getCharacterLoadingDialog(BuildContext context) async {
    Navigator.pop(context);
    showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        material: (_, __) => MaterialAlertDialogData(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 24),
              Text('캐릭터 목록 불러오는 중'),
            ],
          ),
          contentPadding: const EdgeInsets.fromLTRB(12.0, 24.0, 12.0, 24.0),
        ),
        cupertino: (_, __) => CupertinoAlertDialogData(),
      ),
    );
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
      case "기상술사":
        return "603";
    }
    return "0";
  }
}
