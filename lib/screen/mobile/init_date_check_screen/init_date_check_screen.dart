
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../model/user/expedition/expedition_provider.dart';
import '../../../model/user/user_provider.dart';

class InitDateCheckScreen extends StatefulWidget {
  const InitDateCheckScreen({Key? key}) : super(key: key);

  @override
  State<InitDateCheckScreen> createState() => _InitDateCheckScreenState();
}

class _InitDateCheckScreenState extends State<InitDateCheckScreen> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    ExpeditionProvider expedition = Provider.of<ExpeditionProvider>(context, listen: false);

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('초기화 날짜 확인'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('현재 디바이스 시간 : ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())}'),
                Text('최근 초기화 날짜 : ${DateFormat('yyyy-MM-dd HH:mm:ss').format(expedition.expedition.recentInitDateTime)}'),
                Text('다음주 초기화 날짜 : ${DateFormat('yyyy-MM-dd HH:mm:ss').format(expedition.expedition.nextWednesday)}'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: userProvider.charactersProvider.characters.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userProvider.charactersProvider.characters[index].nickName),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5, right: 10),
                              child: Image.asset(
                                'assets/daily/Chaos.png',
                                width: 25,
                                height: 25,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(DateFormat('yyyy-MM-dd HH:mm:ss')
                                    .format(userProvider.charactersProvider.characters[index].dailyContents[0].lateRevision)),
                                Text(DateFormat('yyyy-MM-dd HH:mm:ss')
                                    .format(userProvider.charactersProvider.characters[index].dailyContents[0].saveLateRevision)),
                                Row(
                                  children: [
                                    Text(userProvider.charactersProvider.characters[index].dailyContents[0].restGauge.toString()),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(userProvider.charactersProvider.characters[index].dailyContents[0].saveRestGauge
                                        .toString()),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5, right: 10),
                              child: Image.asset(
                                'assets/daily/Guardian.png',
                                width: 25,
                                height: 25,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(DateFormat('yyyy-MM-dd HH:mm:ss')
                                    .format(userProvider.charactersProvider.characters[index].dailyContents[1].lateRevision)),
                                Text(DateFormat('yyyy-MM-dd HH:mm:ss')
                                    .format(userProvider.charactersProvider.characters[index].dailyContents[1].saveLateRevision)),
                                Row(
                                  children: [
                                    Text(userProvider.charactersProvider.characters[index].dailyContents[1].restGauge.toString()),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(userProvider.charactersProvider.characters[index].dailyContents[1].saveRestGauge
                                        .toString()),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5, right: 10),
                              child: Image.asset(
                                'assets/daily/Epona.png',
                                width: 25,
                                height: 25,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(DateFormat('yyyy-MM-dd HH:mm:ss')
                                    .format(userProvider.charactersProvider.characters[index].dailyContents[2].lateRevision)),
                                Text(DateFormat('yyyy-MM-dd HH:mm:ss')
                                    .format(userProvider.charactersProvider.characters[index].dailyContents[2].saveLateRevision)),
                                Row(
                                  children: [
                                    Text(userProvider.charactersProvider.characters[index].dailyContents[2].restGauge.toString()),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(userProvider.charactersProvider.characters[index].dailyContents[2].saveRestGauge
                                        .toString()),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
