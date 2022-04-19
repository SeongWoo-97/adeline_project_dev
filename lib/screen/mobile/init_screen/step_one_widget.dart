import 'controller/initSettings_controller.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:web_scraper/web_scraper.dart';

class StepOne extends StatelessWidget {
  final webScraper = WebScraper('https://lostark.game.onstove.com');

  @override
  Widget build(BuildContext context) {
    InitSettingsController _controller = Provider.of<InitSettingsController>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        PlatformWidgetBuilder(
          cupertino: (_, child, __) => Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: CupertinoTextField(
              textAlign: TextAlign.center,
              controller: _controller.textEditingController,
            ),
          ),
          material: (_, child, __) => ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 35,
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 25, left: 25),
              child: TextField(
                textAlign: TextAlign.center,
                controller: _controller.textEditingController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    hintText: '닉네임',
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
          child: PlatformIconButton(
            icon: Icon(
              Icons.arrow_forward,
              size: 30,
            ),
            onPressed: () {
              FocusScope.of(context).unfocus();
              _controller.characterInfo(context, _controller.textEditingController.text);
            },
          ),
        ),
      ],
    );
  }
}
