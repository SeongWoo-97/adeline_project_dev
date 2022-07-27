import 'package:adeline_app/main.dart';
import 'package:adeline_app/model/toast/toast.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../../constant/constant.dart';
import '../../../../model/add_content_provider/add_expedition_content_provider.dart';
import '../../../../model/dark_mode/dark_theme_provider.dart';
import '../../../../model/user/content/expedition_content.dart';
import '../../../../model/user/expedition/expedition_model.dart';
import '../../../../model/user/expedition/expedition_provider.dart';
import '../widget/add_expedition_content_widget.dart';

class MobileExpeditionSettingScreen extends StatefulWidget {
  const MobileExpeditionSettingScreen({Key? key}) : super(key: key);

  @override
  State<MobileExpeditionSettingScreen> createState() => _MobileExpeditionSettingScreenState();
}

class _MobileExpeditionSettingScreenState extends State<MobileExpeditionSettingScreen> {
  DragAndDropList expeditionDragAndDrop = DragAndDropList(children: []);
  final expeditionBox = Hive.box<Expedition>(hiveExpeditionName);
  ExpeditionType _expeditionType = ExpeditionType.daily;

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('원정대 콘텐츠 설정'),
        trailingActions: [MobileAddExpeditionContentWidget()],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      cupertino: (_, __) => CupertinoPageScaffoldData(),
      material: (_, __) => MaterialScaffoldData(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Checkbox(
                      value: Hive.box('expeditionIsExpand').get('isExpanded', defaultValue: false),
                      onChanged: (value) {
                        setState(() {
                          Hive.box('expeditionIsExpand').put('isExpanded', value);
                        });
                      }),
                  Text('원정대콘텐츠 항상 펼치기')
                ],
              ),
            ),
            Expanded(
              child: DragAndDropLists(
                children: [dailyDragAndDropList()],
                onItemReorder: _onItemReorder,
                onListReorder: _onListReorder,
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
            ),
          ],
        ),
      ),
    );
  }

  DragAndDropList dailyDragAndDropList() {
    ExpeditionProvider expeditionProvider = Provider.of<ExpeditionProvider>(context);
    AddExpeditionContentProvider addExpeditionContentProvider = Provider.of<AddExpeditionContentProvider>(context);
    expeditionDragAndDrop = DragAndDropList(
      children: List.generate(
        expeditionProvider.expedition.list.length,
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
                          expeditionProvider.removeExpeditionContent(i);
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
                                expeditionProvider.expedition.list[i].iconName,
                                width: 25,
                                height: 25,
                              ),
                            ),
                            Text(
                              expeditionProvider.expedition.list[i].name,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                        material: (_, __) => Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                              child: Image.asset(
                                expeditionProvider.expedition.list[i].iconName,
                                width: 25,
                                height: 25,
                              ),
                            ),
                            Text(
                              expeditionProvider.expedition.list[i].name,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ),
                      onTap: () async {
                        addExpeditionContentProvider.addController.text = expeditionProvider.expedition.list[i].name;
                        expeditionProvider.expedition.list[i].type == "일일"
                            ? _expeditionType = ExpeditionType.daily
                            : _expeditionType = ExpeditionType.weekly;
                        print('내부');
                        await showDialog(
                            context: context,
                            builder: (_) {
                              return StatefulBuilder(builder: (context, setState) {
                                return PlatformAlertDialog(
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
                                                          ? DarkMode.isDarkMode.value
                                                              ? Colors.grey
                                                              : Colors.grey
                                                          : DarkMode.isDarkMode.value
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
                                      child: Text('취소'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    PlatformDialogAction(
                                      child: Text('확인'),
                                      onPressed: () {
                                        print(_expeditionType);
                                        if (_expeditionType == ExpeditionType.daily) {
                                          expeditionProvider.updateExpeditionContent(
                                              i,
                                              ExpeditionContent(
                                                "일일",
                                                addExpeditionContentProvider.addController.text.toString(),
                                                addExpeditionContentProvider.iconName.toString(),
                                              ));
                                        } else {
                                          expeditionProvider.updateExpeditionContent(
                                              i,
                                              ExpeditionContent(
                                                "주간",
                                                addExpeditionContentProvider.addController.text.toString(),
                                                addExpeditionContentProvider.iconName.toString(),
                                              ));
                                        }
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              });
                            });
                      },
                    ),
                  ),
                ],
              ),
              value: expeditionProvider.expedition.list[i].isChecked,
              onChanged: (value) {
                setState(() {
                  expeditionProvider.updateIsChecked(context, i, value!);
                });
              },
              contentPadding: EdgeInsets.fromLTRB(0, 0, 40, 0),
            ),
          ),
        ),
      ),
    );
    return expeditionDragAndDrop;
  }

  _onItemReorder(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    ExpeditionProvider expeditionProvider = Provider.of<ExpeditionProvider>(context, listen: false);
    setState(() {
      var movedItem = expeditionDragAndDrop.children.removeAt(oldItemIndex);

      expeditionDragAndDrop.children.insert(newItemIndex, movedItem);

      var movedItem2 = expeditionProvider.expedition.list.removeAt(oldItemIndex);
      expeditionProvider.insertExpeditionContent(newItemIndex, movedItem2);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {}
}
