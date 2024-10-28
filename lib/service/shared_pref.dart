import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper{

  static String userIdkey="USERKEY";
  static String userNamekey="USERNAMEKEY";
  static String userEmailkey="USEREMAILKEY";
  static String userWalletkey="USERWALLETKEY";
  static String userProfiletkey="USERPROFILETKEY";

  Future<bool> savedUserId(String getUserId)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.setString(userIdkey, getUserId);
  }

  Future<bool> savedUserName(String getUserNameKey)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.setString(userNamekey, getUserNameKey);
  }

  Future<bool> savedUserEmail(String getUserEmail)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.setString(userEmailkey, getUserEmail);
  }

  Future<bool> savedUserWallet(String getUserWallet)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userWalletkey, getUserWallet);
  }

  Future<bool> savedUserProfile(String getUserProfile)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userProfiletkey, getUserProfile);
  }

  Future<String?> getUserId()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdkey);
  }

  Future<String?> getUserMail()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailkey);
  }

  Future<String?> getUserName()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNamekey);
  }

  Future<String?> getUserWallet()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userWalletkey);
  }

  Future<String?> getUserProfile()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userProfiletkey);
  }


}