import 'package:adeline_app/model/user/user_provider.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class NotMobileCharacterReOrderScreen extends StatefulWidget {
  const NotMobileCharacterReOrderScreen({Key? key}) : super(key: key);

  @override
  State<NotMobileCharacterReOrderScreen> createState() => _NotMobileCharacterReOrderScreenState();
}

class _NotMobileCharacterReOrderScreenState extends State<NotMobileCharacterReOrderScreen> {
  DragAndDropList charactersOrder = DragAndDropList(children: []);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('캐릭터 순서 변경 및 삭제'),),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: DragAndDropLists(
          children: [characterOrder()],
          onItemReorder: _onItemReorder,
          onListReorder: _onListReorder,
          listPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
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
          lastItemTargetHeight: 40,
          addLastItemTargetHeightToTop: true,
          lastListTargetSize: 80,
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
    );
  }
  DragAndDropList characterOrder() {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    charactersOrder = DragAndDropList(
      children: List.generate(userProvider.charactersProvider.characters.length, (index) {
        return DragAndDropItem(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              child: ListTile(
                title: Row(
                  children: [
                    InkWell(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Image.asset(
                          'assets/etc/Minus.png',
                          width: 25,
                          height: 25,
                          color: Colors.red,
                        ),
                      ),
                      onTap: () {
                        showPlatformDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return PlatformAlertDialog(
                              content: Text(
                                '${userProvider.charactersProvider.characters[index].nickName} 캐릭터를 \n삭제하시겠습니까?',
                              ),
                              actions: [
                                PlatformDialogAction(
                                  child: PlatformText('취소'),
                                  // 캐릭터 순서 페이지로 이동
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                PlatformDialogAction(
                                  child: PlatformText('삭제'),
                                  // 캐릭터 순서 페이지로 이동
                                  onPressed: () {
                                    setState(() {
                                      userProvider.removeCharacter(index);
                                      Navigator.pop(context);
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userProvider.charactersProvider.characters[index].nickName.toString()),
                        Text(
                          'Lv.${userProvider.charactersProvider.characters[index].level} ${userProvider.charactersProvider.characters[index].job}',
                        )
                      ],
                    ),
                  ],
                ),
                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              ),
            ),
          ),
        );
      }),
    );
    return charactersOrder;
  }

  _onItemReorder(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    setState(() {
      var movedItem = charactersOrder.children.removeAt(oldItemIndex);

      charactersOrder.children.insert(newItemIndex, movedItem);

      var movedItem2 = userProvider.charactersProvider.characters.removeAt(oldItemIndex);
      userProvider.charactersProvider.characters.insert(newItemIndex, movedItem2);
      userProvider.notifyListeners();
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      // var movedList = charactersOrder.removeAt(oldListIndex);
      // _contents.insert(newListIndex, movedList);
    });
  }
}
