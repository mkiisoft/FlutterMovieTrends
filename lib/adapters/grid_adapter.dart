part of app_movie;

class GridAdapter {
  BuildContext _context;
  State<HomePage> _homeState;
  MovieNetwork _movieNetwork;

  List<Movie> _movieList;

  GridAdapter(
      {Key key,
      BuildContext context,
      State<HomePage> state,
      MovieNetwork network}) {
    _context = context;
    _homeState = state;
    _movieNetwork = network;
  }

  List<Widget> movieItems() {
    // ignore: invalid_use_of_protected_member
    _homeState.setState(() {
      _movieList = _movieNetwork.movies;
    });

    List<Widget> containers = new List<Widget>.generate(
        _movieList != null ? _movieList.length : 0, (int index) {
      return Container(
        child: GestureDetector(
          onTap: () {
            GridNavigator(
              context: _context,
              movie: _movieList[index],
            );
          },
          child: ItemCell(_movieList[index]),
        ),
      );
    });
    return containers;
  }
}
