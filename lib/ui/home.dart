part of app_movie;

class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomePage> {
  MovieNetwork _network;

  @override
  void initState() {
    super.initState();
    _network = MovieNetwork(this);
    _network.fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var portrait = MediaQuery.of(context).orientation == Orientation.portrait;

    final double width = portrait ? size.width / 2 : size.width / 4;
    final double height = width * 1.5;

    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Trends'),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: GridView.count(
            crossAxisCount: portrait ? 2 : 4,
            childAspectRatio: (width / height),
            scrollDirection: Axis.vertical,
            children: GridAdapter(
              context: context,
              state: this,
              network: _network,
              gridListener: (GridNavigator navigator) {

              }
            ).movieItems(),
          ),
        ),
      ),
    );
  }
}
