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
    DateTime time = Utils.parse(_movie.release_date);
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    double marginTop = isPortrait ? 70.0 : 110.0;
    double ratingTop = isPortrait ? 220.0 : 260.0;

    return Material(
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
                    getMovieDetailsSection(marginTop, time),
                    getMoviePosterAndRatingSection(marginTop, ratingTop)
                  ], // BACK DETAILS > THUMBNAIL POSTER
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getMovieDetailsSection(double marginTop, DateTime time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        getMoviePosterBackground(),
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              getMovieTitle(marginTop),
              getMovieReleaseDate(time),
              getMovieOverviewTile(),
              getMovieOverview(),
              getVideoContainer()
            ], // (TITLE > RELEASE DATE > OVERVIEW) = DETAILS
          ),
        ),
      ], // BACK POSTER > DETAILS > LIST VIEW
    );
  }

  Widget getMoviePosterAndRatingSection(double marginTop, double ratingTop) {
    return SafeArea(
      child: Row(
        children: <Widget>[
          getMoviePoster(marginTop),
          getRating(ratingTop),
        ],
      ),
    );
  }

  Widget getMoviePosterBackground() {
    return Container(
      child: Opacity(
        opacity: 0.6,
        child: ArcBannerImage(
          "http://image.tmdb.org/t/p/w500${_movie
              .backdrop_path}",
          230.0,
        ),
      ),
    );
  }

  Widget getMoviePoster(double marginTop) {
    return Container(
      margin: EdgeInsets.only(
        top: marginTop,
        left: 15.0,
      ),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black87,
              blurRadius: 25.0,
              offset: Offset(0.0, 4.0),
              spreadRadius: 5.0,
            ),
          ],
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
    );
  }

  Widget getRating(double marginTop) {
    return Container(
      margin: EdgeInsets.only(
        top: marginTop,
        left: 15.0,
      ),
      height: 30.0,
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
    );
  }

  Widget getMovieTitle(double marginTop) {
    return Container(
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
    );
  }

  Widget getMovieReleaseDate(DateTime time) {
    return Container(
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
    );
  }

  Widget getMovieOverviewTile() {
    return Container(
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
    );
  }

  Widget getMovieOverview() {
    return Container(
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
    );
  }

  Widget getVideoContainer() {
    if (_network.videos.length < 1) {
      return Container(
        color: Colors.black,
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[getVideoTitle(), getVideoList()],
      );
    }
  }

  Widget getVideoTitle() {
    return Container(
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
    );
  }

  Widget getVideoList() {
    return Container(
      height: 200.0,
      margin: EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        bottom: 20.0,
        top: 20.0,
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: ListAdapter(
          state: this,
          network: _network,
        ).videoItem(),
      ),
    );
  }
}
