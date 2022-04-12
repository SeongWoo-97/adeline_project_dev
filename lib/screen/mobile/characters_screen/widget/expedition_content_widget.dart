import 'package:adeline_project_dev/model/user/content/expedition_content.dart';
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
  int _selected = 0;
  String? iconName = iconList[0].iconName;
  final key = GlobalKey<FormState>();
  TextEditingController addController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ExpeditionProvider expeditionProvider = Provider.of<ExpeditionProvider>(context, listen: false);
    print('원정대 콘텐츠');
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey, width: 0.8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Text(
                    '원정대 콘텐츠',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.black87, fontWeight: FontWeight.w300),
                  ),
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, right: 7),
                    child: Icon(
                      Icons.add,
                      color: Colors.lightBlue,
                      size: 25,
                    ),
                  ),
                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: (_) {
                          return StatefulBuilder(builder: (context, setState) {
                            return AlertDialog(
                              title: Form(
                                key: key,
                                child: TextFormField(
                                  controller: addController,
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
                                              border:
                                                  Border.all(color: _selected == index ? Colors.grey : Colors.white, width: 1.5),
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
                                              iconName = iconList[index].iconName;
                                            });
                                          },
                                        ),
                                      );
                                    }),
                              ),
                              actions: [
                                PlatformDialogAction(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('취소'),
                                ),
                                PlatformDialogAction(
                                  onPressed: () {
                                    setState(() {
                                      expeditionProvider.expedition.list
                                          .add(ExpeditionContent(addController.text.toString(), iconName.toString()));
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text('확인'),
                                ),
                              ],
                            );
                          });
                        });
                    setState(() {

                    });
                  },
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 2,
                    mainAxisExtent: 40,
                    crossAxisSpacing: 0,
                  ),
                  itemCount: expeditionProvider.expedition.list.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                          side: BorderSide(color: Colors.grey, width: 0.5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child:
                                      Image.asset('${expeditionProvider.expedition.list[index].iconName}', width: 25, height: 25),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${expeditionProvider.expedition.list[index].name}',
                                  style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    value: expeditionProvider.expedition.list[index].isChecked,
                                    checkColor: Color.fromRGBO(119, 210, 112, 1),
                                    activeColor: Colors.transparent,
                                    side: BorderSide(color: Colors.grey, width: 1.5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        expeditionProvider.expedition.list[index].isChecked = value!;
                                      });
                                    })
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
