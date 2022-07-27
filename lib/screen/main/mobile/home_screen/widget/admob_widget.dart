import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobWidget extends StatelessWidget {
  final BannerAd bannerAd = BannerAd(
    adUnitId: 'ca-app-pub-2659418845004468/1781199037',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: bannerAd.load(),
      builder: (context, snapshot) {
        return Container(
          child: AdWidget(ad: bannerAd),
          width: bannerAd.size.width.toDouble(),
          height: 60.0,
          alignment: Alignment.center,
        );
      },
    );
  }
}
