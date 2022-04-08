import 'package:adeline_project_dev/model/user/user_provider.dart';
import 'package:adeline_project_dev/screen/mobile/init_screen/step_two_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:adeline_project_dev/screen/mobile/init_screen/step_one_widget.dart';


import 'controller/initSettings_controller.dart';

class InitSettingsScreen extends StatefulWidget {
  const InitSettingsScreen({Key? key}) : super(key: key);

  @override
  State<InitSettingsScreen> createState() => _InitSettingsScreenState();
}

class _InitSettingsScreenState extends State<InitSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    int _currentStep = Provider.of<InitSettingsController>(context).currentStep;
    InitSettingsController controller = Provider.of<InitSettingsController>(context);
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('캐릭터 불러오기'),
        material: (_, __) => MaterialAppBarData(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: .5,
          titleTextStyle: Theme.of(context).textTheme.headline1,
        ),
        cupertino: (_, __) => CupertinoNavigationBarData(),
        trailingActions: [
          _currentStep == 1
              ? TextButton(
                  onPressed: () => controller.configCompleted(context),
                  child: Text('완료'),
                )
              : Container(),
        ],
      ),
      body: SafeArea(
        child: Stepper(
          type: StepperType.horizontal,
          elevation: 0,
          // physics: ScrollPhysics(),
          physics: ClampingScrollPhysics(),
          currentStep: _currentStep,
          onStepTapped: (step) => controller.tapped(step),
          steps: [
            Step(
              title: Text('닉네임 입력', style: Theme.of(context).textTheme.bodyText1),
              content: StepOne(),
              isActive: _currentStep >= 0,
              state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
            ),
            Step(
              title: Text('캐릭터 선택', style: Theme.of(context).textTheme.bodyText1),
              content: StepTwo(),
              isActive: _currentStep >= 1,
              state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
            ),
          ],
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            return Container();
          },
        ),
      ),
    );
  }
}
