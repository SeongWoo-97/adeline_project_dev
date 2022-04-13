import 'package:adeline_project_dev/model/user/content/expedition_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../user/expedition/expedition_provider.dart';

class AddExpeditionContentProvider extends ChangeNotifier {
  TextEditingController addController = TextEditingController();
  var key = GlobalKey<FormState>();
  int selected = 0;
  String iconName = iconList[0].iconName!;

  void updateSelectedIcon() {}

  void addContent(BuildContext context,String contentType, String name) {
    ExpeditionProvider expeditionProvider = Provider.of<ExpeditionProvider>(context, listen: false);
    expeditionProvider.expedition.list.add(ExpeditionContent(contentType, name, iconName));
    notifyListeners();
  }
}
