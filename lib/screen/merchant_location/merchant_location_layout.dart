import 'package:adeline_app/screen/merchant_location/mobile_merchant_location_screen.dart';
import 'package:adeline_app/screen/merchant_location/not_mobile_merchant_location.dart';
import 'package:flutter/material.dart';

class MerchantLocationLayout extends StatefulWidget {
  const MerchantLocationLayout({Key? key}) : super(key: key);

  @override
  State<MerchantLocationLayout> createState() => _MerchantLocationLayoutState();
}

class _MerchantLocationLayoutState extends State<MerchantLocationLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 800) {
        return NotMobileMerchantLocationScreen();
      } else {
        return MobileMerchantLocationScreen();
      }
    });
  }
}
