import 'controller/initSettings_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class StepOne extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    InitSettingsController controller = Provider.of<InitSettingsController>(context);
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PlatformWidgetBuilder(
            cupertino: (_, child, __) => Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: CupertinoTextField(
                textAlign: TextAlign.center,
                controller: controller.textEditingController,
              ),
            ),
            material: (_, child, __) => ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 35,
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 100, left: 100),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: controller.textEditingController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      hintText: '본인 닉네임',
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
                controller.characterInfo(context, controller.textEditingController.text);
              },
            ),
          ),
        ],
      ),
    );
  }
}
