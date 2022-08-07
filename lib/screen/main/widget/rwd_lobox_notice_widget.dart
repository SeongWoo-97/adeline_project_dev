import 'package:adeline_app/screen/main/controller/notice_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RwdLoboxNoticeWidget extends StatelessWidget {
  const RwdLoboxNoticeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:  Provider.of<NoticeProvider>(context,listen: false).loboxNotice,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData == true) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${snapshot.data?.title}', style: Theme.of(context).textTheme.bodyText2),
                    Text('${snapshot.data?.des}', style: Theme.of(context).textTheme.bodyText2),
                    Text('\n모험섬, 크리스탈 API 제공 - 모코코더#3931', style: Theme.of(context).textTheme.bodyText2),
                  ],
                ),
              ),
            );
          }
        }
        return ExpansionTile(
          tilePadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          expandedAlignment: Alignment.topLeft,
          title: Text('인터넷이 연결되어 있지 않습니다.', style: Theme.of(context).textTheme.caption),
          subtitle: Text('', style: Theme.of(context).textTheme.caption),
          childrenPadding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
        );
      },
    );
  }

}

