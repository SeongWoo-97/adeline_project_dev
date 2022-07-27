import 'package:adeline_app/screen/home_work/init_settings/controller/initSettings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class NotMobileInitSettingsScreen extends StatefulWidget {
  const NotMobileInitSettingsScreen({Key? key}) : super(key: key);

  @override
  State<NotMobileInitSettingsScreen> createState() => _NotMobileInitSettingsScreenState();
}

class _NotMobileInitSettingsScreenState extends State<NotMobileInitSettingsScreen> {
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  '본인의 대표 캐릭터명을 입력 후\n엔터를 눌러주세요.',
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ),
              PlatformWidgetBuilder(
                material: (_, child, __) => ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 35,
                  ),
                  child: Container(
                    width: 300,
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: initController.textEditingController,
                      onSubmitted: (value) {
                        FocusScope.of(context).unfocus();
                        initController.characterInfo(context, value);
                      },
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
            ],
          ),
        ),
      ),
    );
  }
}
