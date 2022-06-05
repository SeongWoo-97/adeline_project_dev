import 'package:adeline_app/screen/mobile/home_screen/widget/crystal_market_price_widget/crystal_market_price_widget.dart';
import 'package:adeline_app/screen/mobile/home_screen/widget/lostark_notice_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../drawer_screen/drawer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  TextEditingController charSearchController = TextEditingController();

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('HOME'),
        material: (_, __) => MaterialAppBarData(),
        cupertino: (_, __) => CupertinoNavigationBarData(),
      ),
      material: (_, __) => MaterialScaffoldData(
        drawer: Container(
          width: 230,
          child: DrawerScreen(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
            child: Container(
              height: 40,
              child: TextFormField(
                controller: charSearchController,
                showCursor: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    size: 27,
                    color: Colors.grey,
                  ),
                  prefixIconColor: Colors.red,
                  hintText: '캐릭터 검색',
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                ),
                cursorColor: Colors.grey,
              ),
            ),
          ),
          CrystalMarketPriceWidget(),
          LostArkNoticeWidget(),
        ],
      ),
    );
  }
}
