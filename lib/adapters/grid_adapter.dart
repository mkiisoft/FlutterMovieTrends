part of app_movie;

typedef void GridClickListener(GridNavigator navigator);

class GridAdapter {
  BuildContext _context;
  State<HomePage> _homeState;
  MovieNetwork _movieNetwork;

  List<Movie> _movieList;
  GridClickListener _gridListener;

  GridAdapter(
      {Key key,
      BuildContext context,
      State<HomePage> state,
      MovieNetwork network,
      GridClickListener gridListener}) {
    _context = context;
    _homeState = state;
    _movieNetwork = network;
    _gridListener = gridListener;
  }

  List<Widget> movieItems() {
    // ignore: invalid_use_of_protected_member
    _homeState.setState(() {
      _movieList = _movieNetwork.movies;
    });

    List<Container> containers = new List<Container>.generate(
        _movieList != null ? _movieList.length : 0, (int index) {
      return Container(
        child: GestureDetector(
          onTap: () {
            _gridListener(GridNavigator(
              context: _context,
              movie: _movieList[index],
            ));
          },
          child: ItemCell(_movieList[index]),
        ),
      );
    });
    return containers;
  }
}
