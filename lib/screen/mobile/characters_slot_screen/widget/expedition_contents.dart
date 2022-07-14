import 'package:adeline_app/model/dark_mode/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../../../../model/user/expedition/expedition_model.dart';
import '../../../../model/user/expedition/expedition_provider.dart';
import '../../expedition_setting_screen/expedition_setting_screen.dart';

class ExpeditionContentWidget extends StatefulWidget {
  const ExpeditionContentWidget({Key? key}) : super(key: key);

  @override
  State<ExpeditionContentWidget> createState() => _ExpeditionContentWidgetState();
}

class _ExpeditionContentWidgetState extends State<ExpeditionContentWidget> {
  List<Widget> list = [];
  final expeditionBox = Hive.box<Expedition>('expedition2');
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
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey, width: 0.8),
        ),
        child: ListTileTheme(
          horizontalTitleGap: 10,
          dense: true,
          child: ExpansionTile(
            initiallyExpanded: isExpanded,
            tilePadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            expandedAlignment: Alignment.topLeft,
            textColor: Colors.black,
            backgroundColor: DarkMode.isDarkMode.value ? Color(0xFF212121) : Colors.white,
            collapsedIconColor: DarkMode.isDarkMode.value ? Colors.white : Colors.grey,
            iconColor: DarkMode.isDarkMode.value ? Colors.white : Colors.grey,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Text(
                    '원정대 콘텐츠',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(height: 1.2),
                  ),
                ),
                InkWell(
                  child: Icon(
                    Icons.settings,
                    color: Colors.grey,
                    size: 20,
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ExpeditionSettingScreen()));
                  },
                ),
              ],
            ),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
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
            ],
          ),
        ),
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
                        padding: const EdgeInsets.all(3.0),
                        child: Image.asset('${expeditionProvider.expedition.list[i].iconName}', width: 23, height: 23),
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
