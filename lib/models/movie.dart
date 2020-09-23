class Movie {
  int id;
  String name;
  String posterPath;
  String backdropPath;
  String description;
  String releaseDate;
  double rating;

  Movie(
      {this.id,
      this.name,
      this.posterPath,
      this.backdropPath,
      this.description,
      this.releaseDate,
      this.rating});

  factory Movie.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['vote_average']);
    print(parsedJson['vote_average'].runtimeType);
    return Movie(
        id: parsedJson['id'],
        name: parsedJson['title'],
        posterPath: parsedJson['poster_path'],
        backdropPath: parsedJson['backdrop_path'],
        description: parsedJson['overview'],
        releaseDate: parsedJson['release_date'],
        rating: parsedJson['vote_average'].toDouble());
  }
}
