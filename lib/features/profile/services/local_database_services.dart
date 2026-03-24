import 'package:clothing_ecommerce/core/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDatabaseServices {
  void setCurrentTheme(String theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.currentTheme, theme);
  }

  Future<String?> getCurrentTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.currentTheme);
  }
}
