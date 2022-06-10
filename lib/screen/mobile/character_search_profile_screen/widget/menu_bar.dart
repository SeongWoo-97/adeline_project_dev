import 'package:adeline_app/screen/mobile/character_search_profile_screen/controller/menu_bar_controller.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/dark_mode/dark_theme_provider.dart';

class MenuBarWidget extends StatelessWidget {
  const MenuBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuBarController>(
      builder: (context, instance, child) {
        return ChipsChoice<int>.single(
          padding: EdgeInsets.only(left: 5),
          value: instance.tag,
          onChanged: (val) => instance.menuOnChanged(val),
          choiceItems: C2Choice.listFrom<int, String>(
            source: instance.options,
            value: (i, v) => i,
            label: (i, v) => v,
          ),
          choiceStyle: C2ChoiceStyle(
            padding: const EdgeInsets.only(left: 10, right: 10),
            labelPadding: const EdgeInsets.all(0),
            margin: const EdgeInsets.all(0),
            showCheckmark: false,
            color: DarkMode.isDarkMode.value ? Colors.white70 : Colors.black,
            backgroundColor: DarkMode.isDarkMode.value ? Color(0xFF212121) : Colors.white,
            borderColor: DarkMode.isDarkMode.value ? Color(0xFF212121) : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          choiceActiveStyle: C2ChoiceStyle(
              padding: const EdgeInsets.only(left: 10, right: 10),
              labelPadding: const EdgeInsets.all(0),
              margin: const EdgeInsets.all(0),
              color: DarkMode.isDarkMode.value ? Colors.white : Colors.black,
              backgroundColor: DarkMode.isDarkMode.value ? Color(0xFF212121) : Colors.white,
              borderColor: DarkMode.isDarkMode.value ? Color(0xFF212121) : Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              showCheckmark: false,
              labelStyle: TextStyle(fontWeight: FontWeight.bold)),
        );
      },
    );
  }
}
