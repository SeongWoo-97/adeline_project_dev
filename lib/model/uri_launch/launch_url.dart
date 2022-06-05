import 'package:adeline_app/model/toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchUrl {
  static launchURL(String url) async {
    try {
      launch(url);
    } catch (e) {
      print(e);
    }
  }
}