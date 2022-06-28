import 'package:adeline_app/screen/responsive/bottom_navigation/widget/drawer_widget.dart';
import 'package:flutter/material.dart';

class RwdBottomNavigationScreen extends StatefulWidget {
  const RwdBottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<RwdBottomNavigationScreen> createState() => _RwdBottomNavigationScreenState();
}

class _RwdBottomNavigationScreenState extends State<RwdBottomNavigationScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Row(
        children: [
          Container(
            child: RwdDrawerWidget(),
          ),
          Expanded(
            flex: 6,
            child: Container(
              child: Text('${MediaQuery.of(context).size.width}'),
            ),
          ),
        ],
      ),
    );
  }
}
