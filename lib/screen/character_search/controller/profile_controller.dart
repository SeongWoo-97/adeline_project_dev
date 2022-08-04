import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:adeline_app/model/profile/character_profile.dart';
import 'package:adeline_app/model/profile/character_profile_provider.dart';
import 'package:adeline_app/model/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProfileController extends ChangeNotifier {
  Future? futureFetch;

  fetchCharacterProfile(BuildContext context, String nickName) async {
    try {
      http.Response response = await http.get(
        Uri.parse('https://lobox.site/lobox/${nickName}'),
        headers: {"Accept": "application/json"},
      ).timeout(Duration(seconds: 7));
      print('response code : ${response.statusCode}');
      if(response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        if (json['result'] == 'Success') {
          CharacterProfileProvider characterProfileProvider = Provider.of<CharacterProfileProvider>(context, listen: false);
          characterProfileProvider.profile = CharacterProfile.fromJson(json);
          return characterProfileProvider;
        } else {
          await errorAlertDialog(context, '${json['error']}', '');
          Navigator.pop(context);
        }
      }
    } on SocketException {
      // http.Response response = await http.get(Uri.parse('http://132.226.22.9/notice/inspection'));
      // 다른포트로 접근해서 서버점검 이 몇시인지 내용알리기
      await errorAlertDialog(context, '서버 점검', '서버점검으로 인해 캐릭터 정보검색을 사용하실수 없습니다.');
      Navigator.pop(context);
    } on TimeoutException {
      ToastMessage.toast('접속 시간이 초과되었습니다.');
      Navigator.pop(context);
    } catch (e) {
      print('에러 : $e');
      await errorAlertDialog(context, '오류', '인터넷 또는 서버가 불안정하여 접속을 할 수가 없습니다. 반복되는 접속 오류는 개발자에게 문의해 주시길 바랍니다.');
      Navigator.pop(context);
    }
  }
}

Future<void> errorAlertDialog(BuildContext context, String title, String msg) async {
  await showPlatformDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Center(
          child: Text(
            '${title}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$msg',
              style: Theme.of(context).textTheme.bodyText2,
            )
          ],
        ),
      );
    },
  );
}
