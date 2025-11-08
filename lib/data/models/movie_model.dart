class MovieModel {
  final int id;
  final String title;
  final String? overview;
  final String? posterPath;
  final String? releaseDate;

  MovieModel({
    required this.id,
    required this.title,
    this.overview,
    this.posterPath,
    this.releaseDate,
  });

  factory MovieModel.fromJson(Map<dynamic, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'] ?? '',
      overview: json['overview'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
    );
  }
}
