import 'package:adeline_app/screen/mobile/init_screen/step_one_widget.dart';
import 'package:adeline_app/screen/mobile/init_screen/step_two_widget.dart';
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
  InitSettingsController controller = InitSettingsController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => controller,
      child: Consumer<InitSettingsController>(
        builder: (context, instance, child) {
          return PlatformScaffold(
            appBar: PlatformAppBar(
              title: Text('캐릭터 불러오기'),
              trailingActions: [
                controller.currentStep == 1
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
                currentStep: controller.currentStep,
                onStepTapped: (step) => controller.tapped(step),
                steps: [
                  Step(
                    title: Text('닉네임 입력', style: Theme.of(context).textTheme.bodyText1),
                    content: StepOne(),
                    isActive: controller.currentStep >= 0,
                    state: controller.currentStep >= 0 ? StepState.complete : StepState.disabled,
                  ),
                  Step(
                    title: Text('캐릭터 선택', style: Theme.of(context).textTheme.bodyText1),
                    content: StepTwo(),
                    isActive: controller.currentStep >= 1,
                    state: controller.currentStep >= 1 ? StepState.complete : StepState.disabled,
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
