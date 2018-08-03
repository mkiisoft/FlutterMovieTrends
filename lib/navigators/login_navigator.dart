part of app_movie;

class LoginNavigator {
  LoginNavigator({Key key, BuildContext context}) {
    _navigate(context);
  }

  void _navigate(BuildContext context) {
    Navigator
        .of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomePage(
                  title: "Movie Trends",
                )));
  }
}
