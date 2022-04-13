import 'package:adeline_project_dev/model/user/content/daily_content.dart';
import 'package:adeline_project_dev/model/user/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../user/content/weekly_content.dart';

class AddContentProvider extends ChangeNotifier {
  TextEditingController addController = TextEditingController();
  var key = GlobalKey<FormState>();
  int selected = 0;
  String iconName = iconList[0].iconName!;

  void updateSelectedIcon() {}

  void addContent(BuildContext context, int characterIndex, String contentType, String name) {
    UserProvider userProvider = Provider.of<UserProvider>(context,listen: false);
    switch (contentType) {
      case "일일":
        userProvider.charactersProvider.characters[characterIndex].dailyContents.add(DailyContent(name, iconName, true));
        break;
      case "주간":
        userProvider.charactersProvider.characters[characterIndex].weeklyContents.add(WeeklyContent(name, iconName, true));
        break;
    }
    notifyListeners();
  }
}
