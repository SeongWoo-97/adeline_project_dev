import 'package:adeline_project_dev/model/add_content_provider/add_expedition_content_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

import '../../../../constant/constant.dart';
import '../../../../model/dark_mode/dark_theme_provider.dart';
import '../../../../model/user/content/expedition_content.dart';
import '../../../../model/user/expedition/expedition_provider.dart';

enum ExpeditionType { daily, weekly }

class AddExpeditionContentWidget extends StatefulWidget {

  @override
  State<AddExpeditionContentWidget> createState() => _AddExpeditionContentWidgetState();
}

class _AddExpeditionContentWidgetState extends State<AddExpeditionContentWidget> {
  ExpeditionType _expeditionType = ExpeditionType.daily;

  @override
  Widget build(BuildContext context) {
    AddExpeditionContentProvider addExpeditionContentProvider = Provider.of<AddExpeditionContentProvider>(context);
    ExpeditionProvider expeditionProvider = Provider.of<ExpeditionProvider>(context, listen: false);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(top: 3,right: 10),
        child: Icon(
          Icons.add,
          size: 30,
          color: Colors.blue,
        ),
      ),
      onTap: () async {
        await showDialog(
            context: context,
            builder: (_) {
              return StatefulBuilder(builder: (context, setState) {
                return AlertDialog(
                  title: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: ListTile(
                              title: const Text('일일'),
                              horizontalTitleGap: 0,
                              leading: Radio<ExpeditionType>(
                                value: ExpeditionType.daily,
                                groupValue: _expeditionType,
                                onChanged: (ExpeditionType? value) {
                                  setState(() {
                                    _expeditionType = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          Flexible(
                            child: ListTile(
                              title: const Text('주간'),
                              horizontalTitleGap: 0,
                              leading: Radio<ExpeditionType>(
                                value: ExpeditionType.weekly,
                                groupValue: _expeditionType,
                                onChanged: (ExpeditionType? value) {
                                  setState(() {
                                    _expeditionType = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Form(
                        key: addExpeditionContentProvider.key,
                        child: TextFormField(
                          controller: addExpeditionContentProvider.addController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 5),
                              hintText: '콘텐츠 이름',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey, width: 0.5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey, width: 0.5),
                                borderRadius: BorderRadius.circular(5),
                              )),
                        ),
                      ),
                    ],
                  ),
                  content: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: GridView.builder(
                        itemCount: iconList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 60,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (_, index) {
                          // list[index] = IconModel(list[index].iconName);
                          return Padding(
                            padding: EdgeInsets.all(8),
                            child: InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: addExpeditionContentProvider.selected == index
                                          ? themeProvider.darkTheme
                                          ? Colors.grey
                                          : Colors.grey
                                          : themeProvider.darkTheme
                                          ? Colors.grey[800]!
                                          : Colors.white,
                                      width: 1.5),
                                ),
                                child: Image.asset(
                                  '${iconList[index].iconName}',
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  addExpeditionContentProvider.selected = index;
                                  addExpeditionContentProvider.iconName = iconList[index].iconName!;
                                });
                              },
                            ),
                          );
                        }),
                  ),
                  actions: [
                    PlatformDialogAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('취소'),
                    ),
                    PlatformDialogAction(
                      onPressed: () {
                        setState(() {
                          if (_expeditionType == "일일") {
                            expeditionProvider.expedition.list
                                .add(ExpeditionContent("일일", addExpeditionContentProvider.addController.text.toString(), addExpeditionContentProvider.iconName.toString()));
                          } else {
                            expeditionProvider.expedition.list
                                .add(ExpeditionContent("주간", addExpeditionContentProvider.addController.text.toString(), addExpeditionContentProvider.iconName.toString()));
                          }
                        });
                        Navigator.pop(context);
                      },
                      child: Text('확인'),
                    ),
                  ],
                );
              });
            });
      },
    );
  }
}
