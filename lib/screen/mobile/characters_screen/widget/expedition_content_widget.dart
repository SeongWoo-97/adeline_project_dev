import 'package:adeline_project_dev/model/user/content/expedition_content.dart';
import 'package:adeline_project_dev/screen/mobile/character_setting_screen/widget/add_expedition_content_widget.dart';
import 'package:adeline_project_dev/screen/mobile/expedition_setting_screen/expedition_setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

import '../../../../constant/constant.dart';
import '../../../../model/user/expedition/expedition_provider.dart';

class ExpeditionContentWidget extends StatefulWidget {
  const ExpeditionContentWidget({Key? key}) : super(key: key);

  @override
  State<ExpeditionContentWidget> createState() => _ExpeditionContentWidgetState();
}

class _ExpeditionContentWidgetState extends State<ExpeditionContentWidget> {
  List<Widget> list = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey, width: 0.8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    '원정대 콘텐츠',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.black87, fontWeight: FontWeight.w300),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, right: 10),
                  child: InkWell(
                    child: Icon(
                      Icons.settings,
                      color: Colors.grey,
                      size: 25,
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ExpeditionSettingScreen()));
                    },
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 5,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                children: listWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> listWidget() {
    ExpeditionProvider expeditionProvider = Provider.of<ExpeditionProvider>(context);
    list = [];
    expeditionProvider.expedition.list.forEach((e) {
      if (e.isChecked == true) {
        list.add(Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey, width: 0.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset('${e.iconName}', width: 25, height: 25),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${e.name}',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14),
                    )
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: e.clearCheck,
                        checkColor: Color.fromRGBO(119, 210, 112, 1),
                        activeColor: Colors.transparent,
                        side: BorderSide(color: Colors.grey, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onChanged: (bool? value) {
                          setState(() {
                            e.clearCheck = value!;
                          });
                        })
                  ],
                )
              ],
            ),
          ),
        ));
      }
    });
    return list;
  }
}
