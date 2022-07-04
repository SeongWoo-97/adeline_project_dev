import 'package:adeline_app/model/notice/adventure_island.dart';
import 'package:adeline_app/screen/mobile/home_screen/widget/notice_controller/notice_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RwdAdventureIslandWidget extends StatefulWidget {
  const RwdAdventureIslandWidget({Key? key}) : super(key: key);

  @override
  State<RwdAdventureIslandWidget> createState() => _RwdAdventureIslandWidgetState();
}

class _RwdAdventureIslandWidgetState extends State<RwdAdventureIslandWidget> {
  Future<AdventureIsland?>? adventureIsland;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    NoticeProvider noticeProvider = Provider.of<NoticeProvider>(context, listen: false);
    adventureIsland = noticeProvider.fetchAdventureIsland();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Card(
        child: FutureBuilder(
          future: adventureIsland,
          builder: (BuildContext context, AsyncSnapshot<AdventureIsland?> snapshot) {
            if (snapshot.hasData == true) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      '모험 섬',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(height: 5),
                    Text('${snapshot.data?.islandDate}', style: Theme.of(context).textTheme.bodyText2),
                    SizedBox(height: 5),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/adventure_island/${snapshot.data?.islandList[0].name}.jpg',
                                  height: 150,
                                  cacheHeight: 150,
                                  cacheWidth: 200,
                                ),
                                Positioned(
                                  top: 5,
                                  right: 10,
                                  child: Image.asset(
                                    'assets/adventure_reward/${snapshot.data?.islandList[0].reward}.png',
                                    width: 40,
                                    height: 40,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Flexible(
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/adventure_island/${snapshot.data?.islandList[1].name}.jpg',
                                  height: 150,
                                  cacheHeight: 150,
                                  cacheWidth: 200,
                                ),
                                Positioned(
                                  top: 5,
                                  right: 10,
                                  child: Image.asset(
                                    'assets/adventure_reward/${snapshot.data?.islandList[1].reward}.png',
                                    width: 40,
                                    height: 40,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Flexible(
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/adventure_island/${snapshot.data?.islandList[2].name}.jpg',
                                  height: 150,
                                  cacheHeight: 150,
                                  cacheWidth: 200,
                                ),
                                Positioned(
                                  top: 5,
                                  right: 10,
                                  child: Image.asset(
                                    'assets/adventure_reward/${snapshot.data?.islandList[2].reward}.png',
                                    width: 40,
                                    height: 40,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
