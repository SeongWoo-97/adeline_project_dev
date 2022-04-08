import 'package:adeline_project_dev/model/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpeditionContentWidget extends StatefulWidget {
  const ExpeditionContentWidget({Key? key}) : super(key: key);

  @override
  State<ExpeditionContentWidget> createState() => _ExpeditionContentWidgetState();
}

class _ExpeditionContentWidgetState extends State<ExpeditionContentWidget> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
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
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: Colors.black87, fontWeight: FontWeight.w300),
                  ),
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, right: 5),
                    child: Icon(
                      Icons.add,
                      color: Colors.lightBlue,
                      size: 22,
                    ),
                  ),
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
                  itemCount: userProvider.expeditionProvider.expedition.list.length,
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
                                  child: Image.asset(
                                      '${userProvider.expeditionProvider.expedition.list[index].iconName}',
                                      width: 25,
                                      height: 25),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${userProvider.expeditionProvider.expedition.list[index].name}',
                                  style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    value: userProvider.expeditionProvider.expedition.list[index].isChecked,
                                    checkColor: Color.fromRGBO(119, 210, 112, 1),
                                    activeColor: Colors.transparent,
                                    side: BorderSide(color: Colors.grey, width: 1.5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        userProvider.expeditionProvider.expedition.list[index].isChecked = value!;
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
