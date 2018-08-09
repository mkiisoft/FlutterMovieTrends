part of app_movie;

class Utils {

  static Color textTheme() {
    return whiteTheme ? Colors.white : Colors.black87;
  }

  static DateTime parse(String formattedDate) {
    DateTime dateTime = DateTime.parse(formattedDate);
    return dateTime;
  }

  static void checkLoginState(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance(); {
      if (prefs.getString("uid") != null) {
        LoginNavigator(context: context);
      }
    }
  }

  static ErrorCode getError(String exception) {
    if (exception.contains("17009") || exception.contains("password")) {
      return ErrorCode.PASSWORD;
    } else if (exception.contains("17011") || exception.contains("record")) {
      return ErrorCode.EMAIL;
    } else {
      return ErrorCode.FORMAT;
    }
  }
}

enum ErrorCode {
  PASSWORD,
  EMAIL,
  FORMAT
}
