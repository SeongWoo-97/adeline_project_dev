import 'package:adeline_app/model/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class NotMobileContentBoardWidget extends StatefulWidget {
  const NotMobileContentBoardWidget({Key? key}) : super(key: key);

  @override
  State<NotMobileContentBoardWidget> createState() => _NotMobileContentBoardWidgetState();
}

class _NotMobileContentBoardWidgetState extends State<NotMobileContentBoardWidget> {
  List<Widget> contentTileList = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context,instance,child) {
        contentTileList = [];
        contentTileList = contentTileWidget(context);
        if (contentTileList.length != 0) {
          return Container(
            height: 45,
            margin: const EdgeInsets.only(left: 10, top: 10,bottom: 5),
            alignment: Alignment.centerLeft,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: contentTileWidget(context),
            ),
          );
        }
        return Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            '주간 레이드를 모두 완료하였습니다!',
            style: Theme.of(context).textTheme.headline1,
          ),
        );
      },
    );
  }

  List<Widget> contentTileWidget(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Widget> list = [];
    Map<String, Map<String, dynamic>> board = {
      '오레하': {
        'count': 0,
        'color': Colors.brown,
      },
      '아르고스': {
        'count': 0,
        'color': Colors.blueAccent,
      },
      '카양겔': {
        'count': 0,
        'color': Colors.amber.shade700,
      },
      '발탄': {
        'count': 0,
        'color': Colors.teal.shade300,
      },
      '비아키스': {
        'count': 0,
        'color': Colors.deepOrange.shade600,
      },
      '쿠크세이튼': {
        'count': 0,
        'color': Colors.pinkAccent,
      },
      '아브렐슈드': {
        'count': 0,
        'color': Colors.deepPurpleAccent,
      },
    };

    userProvider.charactersProvider.characters.forEach((character) {
      character.raidContents.forEach((raidContents) {
        if (raidContents.isChecked) {
          for (int i = 0; i < raidContents.clearCheckStandardPhase; i++) {
            if (!raidContents.clearList[i].check && (raidContents.type == '군단장' || raidContents.type == '아르고스')) {
              board[raidContents.name]!['count'] += 1;
              break;
            } else if (!raidContents.clearList[i].check && (raidContents.type == '오레하' || raidContents.type == '카양겔')) {
              board[raidContents.type]!['count'] += 1;
              break;
            }
          }
        }
      });
    });

    board.forEach((key, value) {
      Color color = value['color'];
      if (board[key]!['count'] != 0 && !(key == '오레하' || key == '카양겔')) {
        list.add(Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: color, width: 1),
          ),
          margin: const EdgeInsets.only(right: 10),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${key}',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 14, color: color, fontWeight: FontWeight.bold),
                ),
                Text('${board[key]!['count']}수')
              ],
            ),
          ),
        ));
      }
      if (board[key]!['count'] != 0 && (key == '오레하' || key == '카양겔')) {
        num count = (board[key]!['count'] / 2);
        if(count % 2 == 0 || count == 1) {
          count = count.toInt();
        }
        list.add(Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: color, width: 1),
          ),
          margin: const EdgeInsets.only(right: 10),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 3, 5, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${key}',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 14, color: color, fontWeight: FontWeight.bold),
                ),
                Text('$count수')
              ],
            ),
          ),
        ));
      }
    });

    return list;
  }
}
