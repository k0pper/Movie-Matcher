class Movie {
  int id;
  String name;
  String posterPath;
  String backdropPath;
  String description;
  Movie(
      {this.id,
      this.name,
      this.posterPath,
      this.backdropPath,
      this.description});

  factory Movie.fromJson(Map<String, dynamic> parsedJson) {
    return Movie(
        id: parsedJson['id'],
        name: parsedJson['original_title'],
        posterPath: parsedJson['poster_path'],
        backdropPath: parsedJson['backdrop_path'],
        description: parsedJson['overview']);
  }
}
