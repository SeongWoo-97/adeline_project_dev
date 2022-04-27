import '../user/content/expedition_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../user/expedition/expedition_model.dart';
import '../user/expedition/expedition_provider.dart';

class AddExpeditionContentProvider extends ChangeNotifier {
  final expeditionBox = Hive.box<Expedition>('expedition');
  TextEditingController addController = TextEditingController();
  var key = GlobalKey<FormState>();
  int selected = 0;
  String iconName = iconList[0].iconName!;

  void updateSelectedIcon() {}

  void addExpeditionContent(BuildContext context,String contentType, String name) {
    ExpeditionProvider expeditionProvider = Provider.of<ExpeditionProvider>(context);
    expeditionProvider.expedition.list.add(ExpeditionContent(contentType, name, iconName));

    expeditionBox.put('expeditionList', expeditionProvider.expedition);
    notifyListeners();
  }
}
