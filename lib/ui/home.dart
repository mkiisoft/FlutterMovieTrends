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
  // Scroll listener
  ScrollController _controller;
  // Network Request
  MovieNetwork _network;
  // Pagination
  int _currentPage = 1;
  // Async check
  bool _inAsync = true;

  @override
  void initState() {
    _controller = new ScrollController()..addListener(_scrollListener);
    
    _network = MovieNetwork(this);
    _network.fetchMovies(_currentPage, () {
      setState(() {
        _inAsync = false;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (_controller.position.extentAfter <= 0.0 && !_inAsync) {
      setState(() {
        _inAsync = true;
        _currentPage++;
      });
      _network.fetchMovies(_currentPage, () {
        setState(() {
          _inAsync = false;
        });
      });
    }
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
        child: ProgressDialog(
          inAsync: _inAsync,
          child: Container(
            color: Colors.black,
            child: GridView.count(
              controller: _controller,
              crossAxisCount: portrait ? 2 : 4,
              childAspectRatio: (width / height),
              scrollDirection: Axis.vertical,
              children: GridAdapter(
                      context: context,
                      state: this,
                      network: _network)
                  .movieItems(),
            ),
          ),
        ),
      ),
    );
  }
}
