part of app_movie;

class GridNavigator {
  GridNavigator({Key key, BuildContext context, Movie movie}) {
    _navigate(context, movie);
  }

  void _navigate(BuildContext context, Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Detail(movie)),
    );
  }
}