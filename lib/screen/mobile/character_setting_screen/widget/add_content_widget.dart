import 'package:adeline_project_dev/model/add_content_provider/add_content_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

import '../../../../constant/constant.dart';

class AddContentIconWidget extends StatefulWidget {
  final String contentListType;
  final int characterIndex;

  AddContentIconWidget(this.characterIndex, this.contentListType);

  @override
  State<AddContentIconWidget> createState() => _AddContentWidgetState();
}

class _AddContentWidgetState extends State<AddContentIconWidget> {
  @override
  Widget build(BuildContext context) {
    AddContentProvider addContentProvider = Provider.of<AddContentProvider>(context);
    return IconButton(
      icon: Icon(
        Icons.add,
        size: 25,
        color: Colors.blue,
      ),
      onPressed: () async {
        addContentProvider.addController.clear();
        await showDialog(
            context: context,
            builder: (_) {
              return StatefulBuilder(builder: (context, setState) {
                return AlertDialog(
                  title: Form(
                    key: addContentProvider.key,
                    child: TextFormField(
                      controller: addContentProvider.addController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 5),
                          hintText: '콘텐츠 이름',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26, width: 0.5),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26, width: 0.5),
                            borderRadius: BorderRadius.circular(5),
                          )),
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
                                      color: addContentProvider.selected == index ? Colors.grey : Colors.white, width: 1.5),
                                ),
                                child: Image.asset(
                                  '${iconList[index].iconName}',
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  addContentProvider.selected = index;
                                  addContentProvider.iconName = iconList[index].iconName!;
                                });
                              },
                            ),
                          );
                        }),
                  ),
                  actions: [
                    PlatformDialogAction(
                      onPressed: () => Navigator.pop(context),
                      child: Text('취소'),
                    ),
                    PlatformDialogAction(
                      onPressed: () {
                        addContentProvider.addContent(context, widget.characterIndex, widget.contentListType, addContentProvider.addController.text);
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