import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {
  static const String pref_user_display_name = 'USER_DISPLAY_NAME';

  void setCurrentUserDisplayName(
      SharedPreferences sharedPreferences, String displayName) async {
    await sharedPreferences.setString(pref_user_display_name, displayName);
  }

  String getCurrentUserDisplayName(SharedPreferences sharedPreferences){
    return sharedPreferences.getString(pref_user_display_name) ?? null;
  }
}
