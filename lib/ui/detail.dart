part of app_movie;

class Detail extends StatelessWidget {
  final Movie _movie;

  Detail(this._movie);

  @override
  Widget build(BuildContext context) {
    return DetailPage(_movie);
  }
}

class DetailPage extends StatefulWidget {
  final Movie _movie;

  DetailPage(this._movie);

  @override
  State<StatefulWidget> createState() {
    return DetailState(_movie);
  }
}

class DetailState extends State<DetailPage> {
  final Movie _movie;

  ScrollController _scrollController;
  MovieNetwork _network;

  DetailState(this._movie);

  DateTime parseDate(Movie movie) {
    return Utils.parse(movie.release_date);
  }

  Widget videoContainer() {
    if (_network.videos.length < 1) {
      return Container(
        color: Colors.black,
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: 20.0,
              left: 15.0,
            ),
            child: Text(
              'Videos:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            height: 200.0,
            margin: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20.0),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: ListAdapter(
                state: this,
                network: _network,
              ).videoItem(),
            ),
          )
        ],
      );
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();

    _network = MovieNetwork(this);
    _network.movieVideos(_movie.id);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime time = parseDate(_movie);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    double marginTop = isPortrait ? 70.0 : 110.0;

    return Scaffold(
      body: Material(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  title: Text(_movie.title),
                  pinned: true,
                )
              ];
            },
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            child: Opacity(
                              opacity: 0.6,
                              child: ArcBannerImage(
                                "http://image.tmdb.org/t/p/w500${_movie
                                    .backdrop_path}",
                                230.0,
                              ),
                            ),
                          ),
                          SafeArea(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                    top: marginTop,
                                    left: 15.0,
                                    right: 15.0,
                                  ),
                                  child: Text(
                                    _movie.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 20.0,
                                    left: 15.0,
                                    right: 15.0,
                                  ),
                                  child: Text(
                                    'Release date: ${time.month}/${time
                                        .day}/${time
                                        .year}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5.0,
                                    horizontal: 15.0,
                                  ),
                                  child: Text(
                                    'Overview:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal: 15.0,
                                  ),
                                  child: Text(
                                    _movie.overview,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                videoContainer()
                              ], // (TITLE > RELEASE DATE > OVERVIEW) = DETAILS
                            ),
                          ),
                        ], // BACK POSTER > DETAILS > LIST VIEW
                      ),
                      SafeArea(
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                top: marginTop,
                                left: 15.0,
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color: Colors.white,
                                width: 4.0,
                              )),
                              width: 120.0,
                              height: 180.0,
                              child: Image.network(
                                "http://image.tmdb.org/t/p/w500${_movie
                                    .poster_path}",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: marginTop,
                                left: 15.0,
                              ),
                              height: 180.0,
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurpleAccent,
                                    borderRadius: BorderRadius.circular(
                                      15.0,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                    vertical: 8.0,
                                  ),
                                  child: Text(
                                    "RATING: ${_movie.vote_average} / 10",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ], // BACK DETAILS > THUMBNAIL POSTER
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
