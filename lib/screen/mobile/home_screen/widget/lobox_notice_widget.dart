import 'package:adeline_app/model/dark_mode/dark_theme_provider.dart';
import 'package:adeline_app/screen/mobile/home_screen/widget/notice_controller/notice_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoboxNoticeWidget extends StatelessWidget {
  const LoboxNoticeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NoticeProvider noticeProvider = Provider.of<NoticeProvider>(context,listen: false);
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ListTileTheme(
          horizontalTitleGap: 5,
          dense: true,
          child: FutureBuilder(
            future: noticeProvider.fetchLoboxNotice(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData == true) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ExpansionTile(
                    tilePadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    expandedAlignment: Alignment.topLeft,
                    textColor: DarkMode.isDarkMode.value ? Colors.white : Colors.black,
                    backgroundColor: DarkMode.isDarkMode.value ? Color(0xFF212121) : Colors.white,
                    collapsedIconColor: DarkMode.isDarkMode.value ? Colors.white : Colors.grey,
                    iconColor: DarkMode.isDarkMode.value ? Colors.white : Colors.grey,
                    title: Text('${snapshot.data?.title}', style: Theme.of(context).textTheme.bodyText2?.copyWith(color: DarkMode.isDarkMode.value ? Colors.white : Colors.black)),
                    children: [Text('${snapshot.data?.des}')],
                    childrenPadding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                    initiallyExpanded: true,
                  );
                }
              }
              return ExpansionTile(
                tilePadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                expandedAlignment: Alignment.topLeft,
                textColor: DarkMode.isDarkMode.value ? Colors.white : Colors.black,
                backgroundColor: DarkMode.isDarkMode.value ? Color(0xFF212121) : Colors.white,
                collapsedIconColor: DarkMode.isDarkMode.value ? Colors.white : Colors.grey,
                iconColor: DarkMode.isDarkMode.value ? Colors.white : Colors.grey,
                title: Text('인터넷이 연결되어 있지 않습니다.', style: Theme.of(context).textTheme.bodyText2),
                subtitle: Text('', style: Theme.of(context).textTheme.caption),
                childrenPadding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
              );
            },
          ),
        ),
      ),
    );
  }
}
