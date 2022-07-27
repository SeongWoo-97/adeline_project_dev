import 'package:adeline_app/model/toast/toast.dart';
import 'package:adeline_app/screen/character_search/character_search_layout.dart';
import 'package:flutter/material.dart';

class RwdCharacterSearchBarWidget extends StatefulWidget {
  @override
  State<RwdCharacterSearchBarWidget> createState() => _RwdCharacterSearchBarWidgetState();
}

class _RwdCharacterSearchBarWidgetState extends State<RwdCharacterSearchBarWidget> {
  TextEditingController charSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 5),
      width: 500,
      height: 40,
      child: TextFormField(
        textAlign: TextAlign.center,
        decoration: InputDecoration(hintText: '캐릭터 검색', hintStyle: Theme.of(context).textTheme.bodyText2),
        onFieldSubmitted: (value) {
          if (value.characters.length <= 12 && value.characters.length >= 2) {
            charSearchController.clear();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CharacterSearchLayout(nickName: value),
              ),
            );
          } else if (value.characters.length > 12) {
            ToastMessage.toast('닉네임이 12글자를 넘을 수 없습니다.');
          } else if (value.characters.length < 2) {
            ToastMessage.toast('닉네임이 최소 2글자입니다.');
          }
        },
      ),
    );
  }
}
