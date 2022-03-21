import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class InitSettingsScreen extends StatefulWidget {
  const InitSettingsScreen({Key? key}) : super(key: key);

  @override
  State<InitSettingsScreen> createState() => _InitSettingsScreenState();
}

class _InitSettingsScreenState extends State<InitSettingsScreen> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('캐릭터 불러오기'),
        material: (_, __) => MaterialAppBarData(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1,
          titleTextStyle: Theme.of(context).textTheme.headline1,
        ),
        cupertino: (_, __) => CupertinoNavigationBarData(),
      ),
      body: SafeArea(
        child: Stepper(
          type: StepperType.vertical,
          physics: ScrollPhysics(),
          currentStep: _currentStep,
          onStepTapped: (step) => tapped(step),
          steps: [
            Step(
              title: Text('닉네임 입력', style: Theme.of(context).textTheme.bodyText1),
              content: stepOne(),
              isActive: _currentStep >= 0,
              state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
            ),
            Step(
              title: Text('콘텐츠 설정', style: Theme.of(context).textTheme.bodyText1),
              content: stepOne(),
              isActive: _currentStep >= 0,
              state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
            )
          ],
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            return Container();
          },
        ),
      ),
    );
  }

  // 화면전환
  tapped(int step) {
    setState(() => _currentStep = step);
  }

  // 다음단계
  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  // 이전단계
  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  Widget stepOne() {
    return Container();
  }
}
