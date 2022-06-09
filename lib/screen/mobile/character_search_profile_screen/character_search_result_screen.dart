import 'dart:convert';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:http/http.dart' as http;

import '../../../model/profile/character_profile.dart';

class CharacterSearchResultScreen extends StatefulWidget {
  final nickName;

  const CharacterSearchResultScreen({Key? key, this.nickName}) : super(key: key);

  @override
  State<CharacterSearchResultScreen> createState() => _CharacterSearchResultScreenState();
}

class _CharacterSearchResultScreenState extends State<CharacterSearchResultScreen> {
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  late CharacterProfile profile;

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(title: Text('캐릭터 정보')),
      body: Center(
        child: FutureBuilder(
          future: fetchCharacterProfile(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text('에러가 발생하였습니다. 개발자에게 문의 바랍니다.');
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData && snapshot.data != null) {
              profile = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                'Lv.60 ${profile.info.nickName}',
                                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 18),
                              ),
                              Text(' (${profile.info.server})',
                                  style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14))
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 40),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('클  래  스  : 소서리스'),
                                      Text('원  정  대  : ${profile.info.expeditionLevel}'),
                                      Text('장착 레벨 : ${profile.info.achieveItemLevel.replaceFirst("Lv.", "")}'),
                                      Text('달성 레벨 : ${profile.info.achieveItemLevel.replaceFirst("Lv.", "")}'),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(child: Text('길드 : ${profile.info.guild}', overflow: TextOverflow.ellipsis)),
                                    Text('PVP : ${profile.info.pvp}'),
                                    Text('칭호 : ${profile.info.badge}'),
                                    Container(child: Text('영지 : ${profile.info.fief.fiefLevel} ${profile.info.fief.fiefName}', overflow: TextOverflow.ellipsis)),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  fetchCharacterProfile() async {
    return this._memoizer.runOnce(() async {
      http.Response response = await http.get(Uri.parse('http://132.226.22.9:3380/lobox/duggy2'));
      Map<String, dynamic> json = jsonDecode(response.body);
      CharacterProfile? characterProfile = CharacterProfile.fromJson(json);
      print(json['info']['nickName']);
      return characterProfile;
    });
  }
}
