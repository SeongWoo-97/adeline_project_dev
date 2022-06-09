import 'package:adeline_app/screen/mobile/characters_slot_screen/init_screen/step_one_widget.dart';
import 'package:adeline_app/screen/mobile/characters_slot_screen/init_screen/step_two_widget.dart';
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
              trailingActions: [
                initController.currentStep == 1
                    ? TextButton(
                        onPressed: () => initController.configCompleted(context),
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
                currentStep: initController.currentStep,
                onStepTapped: (step) => initController.tapped(step),
                steps: [
                  Step(
                    title: Text('닉네임 입력', style: Theme.of(context).textTheme.bodyText1),
                    content: StepOne(),
                    isActive: initController.currentStep >= 0,
                    state: initController.currentStep >= 0 ? StepState.complete : StepState.disabled,
                  ),
                  Step(
                    title: Text('캐릭터 선택', style: Theme.of(context).textTheme.bodyText1),
                    content: StepTwo(),
                    isActive: initController.currentStep >= 1,
                    state: initController.currentStep >= 1 ? StepState.complete : StepState.disabled,
                  ),
                ],
                controlsBuilder: (BuildContext context, ControlsDetails details) {
                  return Container();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
