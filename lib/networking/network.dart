part of app_movie;

typedef void NetworkListener();

class MovieNetwork {
  NetworkListener _listener;

  State<StatefulWidget> _screenState;

  List<Movie> movies = List<Movie>();
  List<Video> videos = List<Video>();

  String movieApiKey = Keys.apiKey;

  MovieNetwork(State<StatefulWidget> state) {
    _screenState = state;
  }

  Future<List<Movie>> fetchMovies(int page, NetworkListener listener) async {
    _listener = listener;
    final apiUrl =
        'https://api.themoviedb.org/3/movie/popular?api_key=$movieApiKey&page=$page';
    final response = await http.get(apiUrl); {
      // ignore: invalid_use_of_protected_member
      _screenState.setState(() {
        if (response.statusCode == 200) {
          Map result = json.decode(response.body);
          movies.addAll(_getListOfMovies(result['results']));
          _listener();
        } else {
          movies = List<Movie>();
        }
      });
    }
    return movies;
  }

  Future<List<Video>> movieVideos(int id) async {
    final apiUrl =
        'https://api.themoviedb.org/3/movie/$id/videos?api_key=$movieApiKey';
    final response = await http.get(apiUrl); {
      // ignore: invalid_use_of_protected_member
      _screenState.setState(() {
        if (response.statusCode == 200) {
          Map result = json.decode(response.body);
          videos = _getListOfVideos(result['results']);
        } else {
          videos = List<Video>();
        }
      });
    }

    return videos;
  }

  List<Video> _getListOfVideos(List results) {
    return results.map<Video>((video) {
      return Video(
        video['id'],
        video['key'],
        video['name'],
      );
    }).toList();
  }

  List<Movie> _getListOfMovies(List results) {
    return results.map<Movie>((movie) {
      return Movie(
          movie['vote_count'],
          movie['id'],
          movie['video'],
          movie['vote_average'].toDouble(),
          movie['title'],
          movie['popularity'].toDouble(),
          movie['poster_path'],
          movie['original_language'],
          movie['original_title'],
          movie['genre_ids'],
          movie['backdrop_path'],
          movie['adult'],
          movie['overview'],
          movie['release_date']);
    }).toList();
  }
}
