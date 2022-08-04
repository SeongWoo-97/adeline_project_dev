import 'package:adeline_app/constant/constant.dart';
import 'package:adeline_app/model/toast/toast.dart';
import 'package:adeline_app/model/user/content/restGauge_content.dart';
import 'package:adeline_app/model/user/content/weekly_content.dart';
import 'package:adeline_app/screen/home_work/character_manual_add_screen/controller/add_character_provider.dart';
import 'package:adeline_app/screen/home_work/character_manual_add_screen/widget/manual_add_icon_widget.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class NotMobileWeeklyContentListWidget extends StatefulWidget {
  const NotMobileWeeklyContentListWidget({Key? key}) : super(key: key);

  @override
  State<NotMobileWeeklyContentListWidget> createState() => _NotMobileWeeklyContentListWidgetState();
}

class _NotMobileWeeklyContentListWidgetState extends State<NotMobileWeeklyContentListWidget> {
  DragAndDropList weeklyDragAndDrop = DragAndDropList(children: []);
  int _selected = 0;
  String iconName = iconList[0].iconName!;
  TextEditingController addController = TextEditingController();
  var key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(alignment: Alignment.topRight, child: ManualAddIconWidget("주간")),
        Container(
          height: MediaQuery.of(context).size.height * 0.53,
          child: DragAndDropLists(
            children: [weeklyDragAndDropList()],
            onItemReorder: _onWeeklyItemReorder,
            onListReorder: _onWeeklyListReorder,
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
          ),
        )
      ],
    );
  }

  DragAndDropList weeklyDragAndDropList() {
    AddCharacterProvider addCharacterProvider = Provider.of<AddCharacterProvider>(context);
    weeklyDragAndDrop = DragAndDropList(
      children: List.generate(
        addCharacterProvider.weeklyContents.length,
        (i) => DragAndDropItem(
          child: Card(
            margin: const EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey, width: 0.8),
            ),
            child: CheckboxListTile(
              title: Row(
                children: [
                  Row(
                    children: [
                      InkWell(
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
                          addCharacterProvider.weeklyContents.removeAt(i);
                          setState(() {});
                          ToastMessage.toast('삭제가 완료되었습니다.');
                        },
                      )
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
                                addCharacterProvider.dailyContents[i].iconName,
                                width: 25,
                                height: 25,
                              ),
                            ),
                            Text(
                              addCharacterProvider.dailyContents[i].name,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                        material: (_, __) => Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                              child: Image.asset(
                                addCharacterProvider.weeklyContents[i].iconName,
                                width: 25,
                                height: 25,
                              ),
                            ),
                            Text(
                              addCharacterProvider.weeklyContents[i].name,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ),
                      onTap: () async {
                        addController.text = '${addCharacterProvider.weeklyContents[i].name}';
                        addCharacterProvider.weeklyContents[i] is RestGaugeContent
                            ? ToastMessage.toast('고정 콘텐츠는 수정할 수 없습니다.')
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
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.grey, width: 0.5),
                                                borderRadius: BorderRadius.circular(8),
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
                                                          color: _selected == index ? Colors.white : Colors.transparent,
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
                                            addCharacterProvider.updateWeeklyContent(
                                                i, WeeklyContent(addController.text, iconName, true));
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
              value: addCharacterProvider.dailyContents[i].isChecked,
              onChanged: (value) {
                setState(() {
                  addCharacterProvider.dailyContents[i].isChecked = value!;
                });
              },
              contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
            ),
          ),
        ),
      ),
    );
    return weeklyDragAndDrop;
  }

  _onWeeklyItemReorder(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    print('$oldItemIndex, $newItemIndex');
    AddCharacterProvider addCharacterProvider = Provider.of<AddCharacterProvider>(context, listen: false);
    setState(() {
      var movedItem = weeklyDragAndDrop.children.removeAt(oldItemIndex);

      weeklyDragAndDrop.children.insert(newItemIndex, movedItem);

      var movedItem2 = addCharacterProvider.weeklyContents.removeAt(oldItemIndex);
      addCharacterProvider.weeklyContents.insert(newItemIndex, movedItem2);
    });
  }

  _onWeeklyListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      // var movedList = charactersOrder.removeAt(oldListIndex);
      // _contents.insert(newListIndex, movedList);
    });
  }
}
