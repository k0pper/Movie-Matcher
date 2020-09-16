class Movie {
  String id;
  String name;
  String img;
  String description;
  Movie({this.id, this.name, this.img, this.description});

  factory Movie.fromJson(Map<String, dynamic> parsedJson) {
    return Movie(
        id: parsedJson['netflixid'],
        name: parsedJson['title'],
        img: parsedJson['image'],
        description: parsedJson['synopsis']);
  }
}
