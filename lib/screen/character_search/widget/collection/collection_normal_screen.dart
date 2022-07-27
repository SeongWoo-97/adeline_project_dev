import 'package:adeline_app/model/profile/collection/collectivePoint.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CollectionNormalScreen extends StatelessWidget {
  final CollectionNormalForm? form;
  final int collectionImageIndex;
  final String collectionName;

  const CollectionNormalScreen({Key? key, required this.form, required this.collectionImageIndex, required this.collectionName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionNormalForm? island = form;
    double? max = island?.max?.toDouble() ?? 0.0;
    double? count = island?.count?.toDouble() ?? 0.0;
    List<String> get = [];
    List<String> notGet = [];
    island?.list?.forEach((element) {
      if (element.check == '획득') {
        get.add(element.name!);
      } else {
        notGet.add(element.name!);
      }
    });
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                child: Image.asset('assets/collectionImage/${collectionImageIndex}.png', width: 70, height: 70),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${collectionName} 현황',
                            style: TextStyle(height: 1.2),
                          ),
                          Text('${((count / max) * 100).toInt()}%', style: TextStyle(height: 1.2)),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Flexible(
                        child: LinearPercentIndicator(
                          padding: const EdgeInsets.all(0),
                          animation: true,
                          progressColor: Color(0xFFFFD200),
                          lineHeight: 25.0,
                          animationDuration: 1500,
                          backgroundColor: Colors.grey,
                          percent: (count / max),
                          // progressColor: slotColor.qualityColor(armorEquips[i]!.itemTitle!.quality),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [Text('획득 목록'), Text('${island?.count} / ${island?.max}')],
                      ),
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: get.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('${get[index]}', style: Theme.of(context).textTheme.bodyText2),
                            trailing: Text(
                              '획득',
                              style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.amberAccent),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            height: 1,
                            indent: 10,
                            endIndent: 10,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('미획득 목록'),
                          Text('${(max - count).toInt()} / ${island?.max}'),
                        ],
                      ),
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: notGet.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('${notGet[index]}', style: Theme.of(context).textTheme.bodyText2),
                            trailing: Text(
                              '미획득',
                              style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.deepOrangeAccent),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            height: 1,
                            indent: 10,
                            endIndent: 10,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
