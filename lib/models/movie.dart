part of app_movie;

class Movie {
  final int vote_count;
  final int id;
  final bool video;
  final double vote_average;
  final String title;
  final double popularity;
  final String poster_path;
  final String original_language;
  final String original_title;
  final List genre_ids;
  final String backdrop_path;
  final bool adult;
  final String overview;
  final String release_date;

  const Movie(
      this.vote_count,
      this.id,
      this.video,
      this.vote_average,
      this.title,
      this.popularity,
      this.poster_path,
      this.original_language,
      this.original_title,
      this.genre_ids,
      this.backdrop_path,
      this.adult,
      this.overview,
      this.release_date
      );
}