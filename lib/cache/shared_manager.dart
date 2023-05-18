import 'package:shared_preferences/shared_preferences.dart';

class SharedManager {
  SharedPreferences? preferences;

  SharedManager() {
    init();
  }

  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  saveOnboarding(int isViewed) async {
    await preferences?.setInt('onboarding', isViewed);
  }
}
