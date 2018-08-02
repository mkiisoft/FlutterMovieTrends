part of app_movie;

class ListAdapter {
  State<DetailPage> _detailState;
  MovieNetwork _network;

  List<Video> _videoList;

  ListAdapter({
    Key key,
    State<DetailPage> state,
    MovieNetwork network,
  }) {
    _detailState = state;
    _network = network;
  }

  void _launchVideo(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  List<Widget> videoItem() {
    // ignore: invalid_use_of_protected_member
    _detailState.setState(() {
      _videoList = _network.videos;
    });

    List<Container> containers = new List<Container>.generate(
        _videoList != null ? _videoList.length : 0, (int index) {
      return Container(
        child: GestureDetector(
          onTap: () {
            _launchVideo("https://www.youtube.com/watch?v=${_videoList[index].key}");
          },
          child: VideoCell(_videoList[index]),
        ),
      );
    });
    return containers;
  }
}
