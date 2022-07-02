import 'package:adeline_app/screen/mobile/character_search_profile_screen/controller/menu_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'collection/collection_menu_bar_widget.dart';

class MenuBarWidget extends StatefulWidget {
  const MenuBarWidget({Key? key}) : super(key: key);

  @override
  State<MenuBarWidget> createState() => _MenuBarWidgetState();
}

class _MenuBarWidgetState extends State<MenuBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Container(
            height: 45,
            child: Consumer<MenuBarController>(
              builder: (context, instance, child) {
                List<ElevatedButton> buttons = [];
                MenuBarController controller = Provider.of<MenuBarController>(context, listen: false);
                Size size = MediaQuery.of(context).size;
                List<CollectionButton> options = size.width >= 800
                    ? [
                        CollectionButton(0, '장비'),
                        CollectionButton(1, '수집'),
                        CollectionButton(2, '아바타'),
                      ]
                    : [
                        CollectionButton(0, '장비'),
                        CollectionButton(1, '스킬'),
                        CollectionButton(2, '수집'),
                        CollectionButton(3, '아바타'),
                      ];
                options.forEach((element) {
                  buttons.add(ElevatedButton(
                    child: Text('${element.name}'),
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(color: Colors.transparent),
                        onPrimary: element.index == controller.tag ? Theme.of(context).focusColor : Colors.grey,
                        textStyle: element.index == controller.tag
                            ? Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold)
                            : Theme.of(context).textTheme.bodyText1?.copyWith(),
                        splashFactory: NoSplash.splashFactory),
                    onPressed: () {
                      controller.pageController.jumpToPage(element.index);
                      controller.menuOnChanged(element.index);
                    },
                  ));
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
