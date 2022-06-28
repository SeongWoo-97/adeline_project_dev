import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/initSettings_controller.dart';

class StepTwo extends StatefulWidget {
  @override
  State<StepTwo> createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo> {
  @override
  Widget build(BuildContext context) {
    InitSettingsController controller = Provider.of<InitSettingsController>(context);
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .72,
            child: ListView.builder(
              itemCount: controller.characters.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                    side: BorderSide(color: Colors.grey, width: 0.8),
                  ),
                  child: ListTile(
                    // title: Text(index.toString()),
                    title: Text(controller.characters[index].nickName),
                    subtitle: Text(
                      'Lv.${controller.characters[index].level} ${controller.characters[index].job}',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                );
              },
              shrinkWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
