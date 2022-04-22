import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

import '../../../../constant/constant.dart';
import '../../../../model/dark_mode/dark_theme_provider.dart';
import '../controller/add_character_provider.dart';

class ManualAddIconWidget extends StatefulWidget {
  final String contentListType;

  ManualAddIconWidget(this.contentListType);

  @override
  State<ManualAddIconWidget> createState() => _ManualAddIconWidgetState();
}

class _ManualAddIconWidgetState extends State<ManualAddIconWidget> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    AddCharacterProvider addCharacterProvider = Provider.of<AddCharacterProvider>(context);
    return IconButton(
      icon: Icon(Icons.add, size: 25),
      onPressed: () async {
        addCharacterProvider.addController.clear();
        await showPlatformDialog(
            context: context,
            builder: (_) {
              return StatefulBuilder(builder: (context, setState) {
                return PlatformAlertDialog(
                  title: Form(
                    key: addCharacterProvider.key,
                    child: TextFormField(
                      controller: addCharacterProvider.addController,
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
                        ),
                      ),
                    ),
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
                                      color: addCharacterProvider.selected == index
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
                                  addCharacterProvider.selected = index;
                                  addCharacterProvider.iconName = iconList[index].iconName!;
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
                        FocusScope.of(context).unfocus();
                      },
                      child: Text('취소'),
                    ),
                    PlatformDialogAction(
                      onPressed: () {
                        addCharacterProvider.addContent(context, widget.contentListType, addCharacterProvider.addController.text);
                        Navigator.pop(context);
                        FocusScope.of(context).unfocus();
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
