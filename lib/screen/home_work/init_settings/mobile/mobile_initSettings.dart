import 'package:adeline_app/screen/home_work/init_settings/controller/initSettings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class MobileInitSettingsScreen extends StatefulWidget {
  const MobileInitSettingsScreen({Key? key}) : super(key: key);

  @override
  State<MobileInitSettingsScreen> createState() => _MobileInitSettingsScreenState();
}

class _MobileInitSettingsScreenState extends State<MobileInitSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    InitSettingsController initController = Provider.of<InitSettingsController>(context, listen: false);
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('캐릭터 불러오기'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PlatformWidgetBuilder(
                material: (_, child, __) => ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 35,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 100, left: 100),
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: initController.textEditingController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          hintText: '대표 닉네임',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 0.5),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 0.5),
                            borderRadius: BorderRadius.circular(5),
                          )),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextButton(
                  child: Text('불러오기'),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    initController.characterInfo(context, initController.textEditingController.text);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
