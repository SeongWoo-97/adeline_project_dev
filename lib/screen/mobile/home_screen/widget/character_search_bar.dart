import 'package:adeline_app/model/toast/toast.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/character_search_result_screen.dart';
import 'package:flutter/material.dart';

import '../../../../model/dark_mode/dark_theme_provider.dart';

class CharacterSearchBar extends StatefulWidget {
  const CharacterSearchBar({Key? key}) : super(key: key);

  @override
  State<CharacterSearchBar> createState() => _CharacterSearchBarState();
}

class _CharacterSearchBarState extends State<CharacterSearchBar> {
  TextEditingController charSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
      child: Container(
        height: 40,
        child: TextFormField(
          controller: charSearchController,
          showCursor: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              size: 27,
              color: Colors.grey,
            ),
            prefixIconColor: Colors.red,
            hintText: '캐릭터 검색',
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: DarkMode.isDarkMode.value ? Colors.grey : Colors.black, width: .5),
                borderRadius: BorderRadius.circular(7)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: DarkMode.isDarkMode.value ? Colors.grey : Colors.black, width: .5),
                borderRadius: BorderRadius.circular(7)),
          ),
          cursorColor: Colors.grey,
          onFieldSubmitted: (value) {
            if(value.characters.length <= 12 && value.characters.length >= 2) {
              charSearchController.clear();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CharacterSearchResultScreen(
                    nickName: value,
                  ),
                ),
              );
            } else if(value.characters.length > 12){
              ToastMessage.toast('닉네임이 12글자를 넘을 수 없습니다.');
            } else if (value.characters.length < 2) {
              ToastMessage.toast('닉네임이 최소 2글자입니다.');
            }
          },
        ),
      ),
    );
  }
}
