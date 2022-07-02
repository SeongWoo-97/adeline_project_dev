import 'package:adeline_app/model/profile/collection/collectivePoint.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CollectionMococoScreen extends StatelessWidget {
  final CollectionMococoForm? form;
  final int collectionImageIndex;
  final String collectionName;

  const CollectionMococoScreen({Key? key, required this.form, required this.collectionImageIndex, required this.collectionName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionMococoForm? mococo = form;
    double? max = mococo?.max?.toDouble() ?? 0.0;
    double? count = mococo?.count?.toDouble() ?? 0.0;
    List<Mococo> clear = [];
    List<Mococo> notClear = [];
    mococo?.list?.forEach((element) {
      if (element.max == element.count) {
        clear.add(element);
      } else {
        notClear.add(element);
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
                        children: [Text('획득 목록'), Text('${mococo?.count} / ${mococo?.max}')],
                      ),
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: clear.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('${clear[index].name}'),
                            trailing: Text(
                              '${clear[index].count} / ${clear[index].max}',
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
                        children: [Text('미획득 목록'), Text('${(max - count).toInt()} / ${mococo?.max}')],
                      ),
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: notClear.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('${notClear[index].name}'),
                            trailing: Text(
                              '${notClear[index].count} / ${notClear[index].max}',
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
