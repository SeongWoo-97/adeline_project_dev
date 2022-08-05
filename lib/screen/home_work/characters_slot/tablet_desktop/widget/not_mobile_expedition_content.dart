import 'package:adeline_app/main.dart';
import 'package:adeline_app/model/user/expedition/expedition_model.dart';
import 'package:adeline_app/model/user/expedition/expedition_provider.dart';
import 'package:adeline_app/screen/home_work/expedition_setting/expedition_settings_layout.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';


class NotMobileExpeditionContentWidget extends StatefulWidget {
  const NotMobileExpeditionContentWidget({Key? key}) : super(key: key);

  @override
  State<NotMobileExpeditionContentWidget> createState() => _NotMobileExpeditionContentWidgetState();
}

class _NotMobileExpeditionContentWidgetState extends State<NotMobileExpeditionContentWidget> {
  List<Widget> list = [];
  final expeditionBox = Hive.box<Expedition>(hiveExpeditionName);
  bool isExpanded = false;
  @override
  void initState() {
    super.initState();
    isExpanded = Hive.box('expeditionIsExpand').get('isExpanded',defaultValue: false);
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Text(
                  '원정대 콘텐츠',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              InkWell(
                child: Icon(
                  Icons.settings,
                  color: Colors.grey,
                  size: 23,
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ExpeditionSettingsLayout()));
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 6,
              childAspectRatio: 6,
              crossAxisSpacing: 0,
              mainAxisSpacing: 5,
              children: listWidget(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> listWidget() {
    ExpeditionProvider expeditionProvider = Provider.of<ExpeditionProvider>(context);
    list = [];
    for (int i = 0; i < expeditionProvider.expedition.list.length; i++) {
      if (expeditionProvider.expedition.list[i].isChecked == true) {
        list.add(Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset('${expeditionProvider.expedition.list[i].iconName}', width: 25, height: 25),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Flexible(
                        child: Container(
                          child: Text(
                            '${expeditionProvider.expedition.list[i].name}',
                            style: TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: expeditionProvider.expedition.list[i].clearCheck,
                    checkColor: Color.fromRGBO(119, 210, 112, 1),
                    activeColor: Colors.transparent,
                    side: BorderSide(color: Colors.grey, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onChanged: (bool? value) {
                      setState(() {
                        expeditionProvider.expedition.list[i].clearCheck = value!;
                        expeditionBox.put('expeditionList', expeditionProvider.expedition);
                      });
                    })
              ],
            ),
          ),
        ));
      }
    }
    return list;
  }
}
