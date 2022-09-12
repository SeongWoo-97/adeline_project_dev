import 'package:adeline_app/screen/character_search/controller/menu_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionMenuBarWidget extends StatefulWidget {
  const CollectionMenuBarWidget({Key? key}) : super(key: key);

  @override
  State<CollectionMenuBarWidget> createState() => _CollectionMenuBarWidgetState();
}

class _CollectionMenuBarWidgetState extends State<CollectionMenuBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Container(
            height: 25,
            child: Consumer<CollectionMenuBarController>(
              builder: (context, instance, child) {
                List<ElevatedButton> buttons = [];
                CollectionMenuBarController controller = Provider.of<CollectionMenuBarController>(context, listen: false);
                List<CollectionButton> options = [
                  CollectionButton(0, '거인의 심장'),
                  CollectionButton(1, '섬의 마음'),
                  CollectionButton(2, '모코코 씨앗'),
                  CollectionButton(3, '위대한 미술품'),
                  CollectionButton(4, '항해 모험물'),
                  CollectionButton(5, '세계수의 잎'),
                  CollectionButton(6, '이그네아의 징표'),
                  CollectionButton(7, '오르페우스의 별'),
                  CollectionButton(8, '기억의 오르골'),
                ];
                options.forEach((element) {
                  buttons.add(
                    ElevatedButton(
                      child: Text('${element.name}'),
                      style: ElevatedButton.styleFrom(
                          side: BorderSide(color: Colors.transparent),
                          onPrimary: element.index == controller.tag ? Theme.of(context).focusColor : Colors.grey,
                          textStyle: element.index == controller.tag
                              ? Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.bold)
                              : Theme.of(context).textTheme.bodyText2?.copyWith(),
                          splashFactory: NoSplash.splashFactory),
                      onPressed: () {
                        controller.pageController.jumpToPage(element.index);
                        controller.menuOnChanged(element.index);
                      },
                    ),
                  );
                });
                return ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: buttons,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class CollectionButton {
  int index;
  String name;

  CollectionButton(this.index, this.name);
}
