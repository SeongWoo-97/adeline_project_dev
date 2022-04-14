import 'package:adeline_project_dev/model/add_content_provider/add_expedition_content_provider.dart';
import 'package:adeline_project_dev/model/user/expedition/expedition_provider.dart';
import 'package:adeline_project_dev/screen/mobile/character_setting_screen/widget/add_expedition_content_widget.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../constant/constant.dart';
import '../../../model/user/content/expedition_content.dart';
import '../../../model/user/expedition/expedition_model.dart';

class ExpeditionSettingScreen extends StatefulWidget {
  const ExpeditionSettingScreen({Key? key}) : super(key: key);

  @override
  State<ExpeditionSettingScreen> createState() => _ExpeditionSettingScreenState();
}

class _ExpeditionSettingScreenState extends State<ExpeditionSettingScreen> {
  DragAndDropList expeditionDragAndDrop = DragAndDropList(children: []);
  final expeditionBox = Hive.box<Expedition>('expedition');

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(
          '원정대 콘텐츠 설정',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        material: (_, __) => MaterialAppBarData(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: .5,
          title: Text('원정대 콘텐츠 설정', style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold)),
        ),
        trailingActions: [
          AddExpeditionContentWidget()
        ],
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.blue,),onPressed: () => Navigator.pop(context),),
      ),
      cupertino: (_, __) => CupertinoPageScaffoldData(),
      material: (_, __) => MaterialScaffoldData(
        body: DragAndDropLists(
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
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }

  DragAndDropList dailyDragAndDropList() {
    ExpeditionProvider expeditionProvider = Provider.of<ExpeditionProvider>(context, listen: false);
    AddExpeditionContentProvider addExpeditionContentProvider = Provider.of<AddExpeditionContentProvider>(context, listen: false);
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
                          toast('삭제가 완료되었습니다.');
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
                        await showDialog(
                            context: context,
                            builder: (_) {
                              return StatefulBuilder(builder: (context, setState) {
                                return PlatformAlertDialog(
                                  title: Form(
                                    key: addExpeditionContentProvider.key,
                                    child: TextFormField(
                                      controller: addExpeditionContentProvider.addController,
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
                                                      color: addExpeditionContentProvider.selected == index
                                                          ? Colors.grey
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
                                        expeditionProvider.updateExpeditionContent(
                                            i,
                                            ExpeditionContent(
                                              expeditionProvider.expedition.list[i].type,
                                              addExpeditionContentProvider.addController.text.toString(),
                                              addExpeditionContentProvider.iconName.toString(),
                                            ));
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
                  expeditionProvider.updateIsChecked(context,i, value!);
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

  void toast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.CENTER,
      fontSize: 16,
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.white,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
    );
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
