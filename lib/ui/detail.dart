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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.black,
            padding: EdgeInsets.only(
              top: 15.0,
              bottom: 5.0,
              left: 15.0,
            ),
            child: SafeArea(
              child: Text(
                'Videos:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Container(
            height: 200.0,
            margin: EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                bottom: 20.0
            ),
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

    return Scaffold(
      backgroundColor: Colors.black,
      body: Material(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
                            color: Colors.black,
                            height: 200.0,
                            child: Opacity(
                              opacity: 0.6,
                              child: Image.network(
                                "http://image.tmdb.org/t/p/w500${_movie
                                    .backdrop_path}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SafeArea(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 70.0,
                                    left: 15.0,
                                    right: 15.0,
                                  ),
                                  color: Colors.black,
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
                                  color: Colors.black,
                                  padding: EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 20.0,
                                    left: 15.0,
                                    right: 15.0,
                                  ),
                                  child: Text(
                                    'Release date: ${time.month}/${time.day}/${time
                                        .year}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.black,
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
                                  color: Colors.black,
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
                                )
                              ], // (TITLE > RELEASE DATE > OVERVIEW) = DETAILS
                            ),
                          ),
                          videoContainer()
                        ], // BACK POSTER > DETAILS > LIST VIEW
                      ),
                      SafeArea(
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 70.0,
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
                            "http://image.tmdb.org/t/p/w500${_movie.poster_path}",
                            fit: BoxFit.cover,
                          ),
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
