import 'package:adeline_app/main.dart';
import 'package:adeline_app/model/user/character/character_model.dart';
import 'package:adeline_app/model/user/expedition/expedition_model.dart';
import 'package:adeline_app/model/user/expedition/expedition_provider.dart';
import 'package:adeline_app/model/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class CharacterGoldLimitListScreen extends StatefulWidget {
  const CharacterGoldLimitListScreen({Key? key}) : super(key: key);

  @override
  State<CharacterGoldLimitListScreen> createState() => _CharacterGoldLimitListScreenState();
}

class _CharacterGoldLimitListScreenState extends State<CharacterGoldLimitListScreen> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    ExpeditionProvider expeditionProvider = Provider.of<ExpeditionProvider>(context, listen: false);
    List<String> possibleGetGoldNameList = Hive.box<Expedition>(hiveExpeditionName).get('expeditionList')!.possibleGoldCharacters;
    List<Character> characters = userProvider.charactersProvider.characters;
    return Scaffold(
      appBar: AppBar(
        title: Text('골드 획득 캐릭터 지정'),
        actions: [
          TextButton(
            child: Text(
              '저장',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            onPressed: () {
              expeditionProvider.savePossibleGetGoldCharacters(possibleGetGoldNameList);
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: characters.length,
        itemBuilder: (context, index) {
          bool getGoldCheck = possibleGetGoldNameList.contains(characters[index].nickName);
          return Card(
            margin: const EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey, width: 0.8),
            ),
            child: CheckboxListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${characters[index].nickName}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  getGoldCheck
                      ? Image.asset(
                          'assets/etc/Gold.png',
                          width: 30,
                          height: 30,
                        )
                      : Container(),
                ],
              ),
              value: getGoldCheck,
              onChanged: (bool? value) {
                setState(() {
                  if (getGoldCheck) {
                    possibleGetGoldNameList.remove(characters[index].nickName);
                  } else {
                    possibleGetGoldNameList.add(characters[index].nickName);
                  }
                });
              },
            ),
          );
        },
      ),
    );
  }
}
