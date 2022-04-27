import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../constant/constant.dart';
import '../../../../model/add_content_provider/add_content_provider.dart';
import '../../../../model/dark_mode/dark_theme_provider.dart';
import '../../../../model/user/content/daily_content.dart';
import '../../../../model/user/content/restGauge_content.dart';
import '../../../../model/user/user_provider.dart';
import 'add_content_widget.dart';

class DailyContentSettingWidget extends StatefulWidget {
  final int characterIndex;

  DailyContentSettingWidget(this.characterIndex);

  @override
  State<DailyContentSettingWidget> createState() => _DailyContentSettingWidgetState();
}

class _DailyContentSettingWidgetState extends State<DailyContentSettingWidget> {
  final key = GlobalKey<FormState>();
  int _selected = 0;
  String iconName = iconList[0].iconName!;
  DragAndDropList dailyDragAndDrop = DragAndDropList(children: []);
  TextEditingController addController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: AddContentIconWidget(widget.characterIndex, "일일"),
            )
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.53,
          child: Consumer<AddContentProvider>(
            builder: (context, instance, child) {
              return DragAndDropLists(
                children: [dailyDragAndDropList()],
                onItemReorder: _onDailyItemReorder,
                onListReorder: _onDailyListReorder,
                listPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                itemDecorationWhileDragging: BoxDecoration(
                  color: Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                listInnerDecoration: BoxDecoration(
                  color: Colors.transparent, // background 색
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                lastItemTargetHeight: 8,
                addLastItemTargetHeightToTop: true,
                lastListTargetSize: 40,
                listDragHandle: DragHandle(
                  verticalAlignment: DragHandleVerticalAlignment.top,
                  child: Container(),
                ),
                itemDragHandle: DragHandle(
                  child: Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Icon(
                      Icons.menu,
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  DragAndDropList dailyDragAndDropList() {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    dailyDragAndDrop = DragAndDropList(
      children: List.generate(
        userProvider.charactersProvider.characters[widget.characterIndex].dailyContents.length,
        (i) => DragAndDropItem(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey, width: 0.8),
            ),
            child: CheckboxListTile(
              title: Row(
                children: [
                  Row(
                    children: [
                      userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[i] is DailyContent
                          ? InkWell(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Image.asset(
                                  'assets/etc/Minus.png',
                                  width: 25,
                                  height: 25,
                                  color: Colors.red,
                                ),
                              ),
                              onTap: () {
                                userProvider.charactersProvider.characters[widget.characterIndex].dailyContents.removeAt(i);
                                setState(() {});
                                toast('삭제가 완료되었습니다.');
                              },
                            )
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: InkWell(
                                child: Image.asset(
                                  'assets/etc/Minus.png',
                                  width: 25,
                                  height: 25,
                                  color: Colors.red,
                                ),
                                onTap: () {
                                  toast('해당 콘텐츠는 삭제할 수 없습니다.');
                                },
                              ),
                            ),
                    ],
                  ),
                  Flexible(
                    child: InkWell(
                      child: PlatformWidget(
                        cupertino: (_, __) => Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                              child: Image.asset(
                                userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[i].iconName,
                                width: 25,
                                height: 25,
                              ),
                            ),
                            Text(
                              userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[i].name,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                        material: (_, __) => Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                              child: Image.asset(
                                userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[i].iconName,
                                width: 25,
                                height: 25,
                              ),
                            ),
                            Text(
                              userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[i].name,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ),
                      onTap: () async {
                        addController.text =
                            '${userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[i].name}';
                        userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[i] is RestGaugeContent
                            ? toast('고정 콘텐츠는 수정할 수 없습니다.')
                            : await showDialog(
                                context: context,
                                builder: (_) {
                                  return StatefulBuilder(builder: (context, setState) {
                                    return PlatformAlertDialog(
                                      title: Form(
                                        key: key,
                                        child: TextFormField(
                                          controller: addController,
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
                                                          color: _selected == index ? themeProvider.darkTheme
                                                              ? Colors.grey
                                                              : Colors.grey
                                                              : themeProvider.darkTheme
                                                              ? Colors.grey[800]!
                                                              : Colors.white, width: 1.5),
                                                    ),
                                                    child: Image.asset(
                                                      '${iconList[index].iconName}',
                                                      width: 100,
                                                      height: 100,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      _selected = index;
                                                      iconName = iconList[index].iconName!;
                                                    });
                                                  },
                                                ),
                                              );
                                            }),
                                      ),
                                      actions: [
                                        PlatformDialogAction(
                                          child: Text('취소'),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        PlatformDialogAction(
                                          child: Text('확인'),
                                          onPressed: () {
                                            userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[i] =
                                                DailyContent(addController.text.toString(), iconName.toString(), true);
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  });
                                });
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              value: userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[i].isChecked,
              onChanged: (value) {
                setState(() {
                  userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[i].isChecked = value!;
                });
              },
              contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
            ),
          ),
          canDrag:
              userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[i] is DailyContent ? true : false,
        ),
      ),
    );
    return dailyDragAndDrop;
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      // var movedList = charactersOrder.removeAt(oldListIndex);
      // _contents.insert(newListIndex, movedList);
    });
  }

  _onDailyItemReorder(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    print('$oldItemIndex, $newItemIndex');
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);

    if (newItemIndex <= 2) {
      toast('고정 콘텐츠는 수정할 수 없습니다.');
    } else {
      setState(() {
        var movedItem = dailyDragAndDrop.children.removeAt(oldItemIndex);

        dailyDragAndDrop.children.insert(newItemIndex, movedItem);

        var movedItem2 = userProvider.charactersProvider.characters[widget.characterIndex].dailyContents.removeAt(oldItemIndex);
        userProvider.charactersProvider.characters[widget.characterIndex].dailyContents.insert(newItemIndex, movedItem2);
      });
    }
  }

  _onDailyListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      // var movedList = charactersOrder.removeAt(oldListIndex);
      // _contents.insert(newListIndex, movedList);
    });
  }

  void toast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16,
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.white,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
    );
  }
}
