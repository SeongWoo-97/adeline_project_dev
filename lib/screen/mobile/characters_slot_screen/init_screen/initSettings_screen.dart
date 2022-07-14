import 'package:adeline_app/screen/mobile/characters_slot_screen/init_screen/step_one_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

import 'controller/initSettings_controller.dart';

class InitSettingsScreen extends StatefulWidget {
  const InitSettingsScreen({Key? key}) : super(key: key);

  @override
  State<InitSettingsScreen> createState() => _InitSettingsScreenState();
}

class _InitSettingsScreenState extends State<InitSettingsScreen> {
  InitSettingsController initController = InitSettingsController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => initController,
      child: Consumer<InitSettingsController>(
        builder: (context, instance, child) {
          return PlatformScaffold(
            appBar: PlatformAppBar(
              title: Text('캐릭터 불러오기'),
            ),
            body: SafeArea(
              child: StepOne(),
            ),
          );
        },
      ),
    );
  }
}
