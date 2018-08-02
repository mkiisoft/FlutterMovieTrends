part of app_movie;

class MovieNetwork {
  final apiKey = 'c7de35552aca985509f86e76f594c9f1';

  State<StatefulWidget> _screenState;

  List<Movie> movies = List<Movie>();
  List<Video> videos = List<Video>();

  MovieNetwork(State<StatefulWidget> state) {
    _screenState = state;
  }

  Future<List<Movie>> fetchMovies() async {
    final apiUrl = 'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey';
    final response = await http.get(apiUrl);

    // ignore: invalid_use_of_protected_member
    _screenState.setState(() {
      if (response.statusCode == 200) {
        Map result = json.decode(response.body);
        movies = _getListOfMovies(result['results']);
//        print(movies);
      } else {
        movies = List<Movie>();
      }
    });
    return movies;
  }

  Future<List<Video>> movieVideos(int id) async {
    final apiUrl = 'https://api.themoviedb.org/3/movie/$id/videos?api_key=$apiKey';
    final response = await http.get(apiUrl);

    // ignore: invalid_use_of_protected_member
    _screenState.setState(() {
      if (response.statusCode == 200) {
        Map result = json.decode(response.body);
        videos = _getListOfVideos(result['results']);
//        print(videos);
      } else {
        videos = List<Video>();
      }
    });
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
          movie['popularity'],
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
