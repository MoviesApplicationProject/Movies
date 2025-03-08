class FavoriteMovie {
  final String movieId;
  final String name;
  final double rating;
  final String imageURL;
  final String year;

  FavoriteMovie({
    required this.movieId,
    required this.name,
    required this.rating,
    required this.imageURL,
    required this.year,
  });

  factory FavoriteMovie.fromJson(Map<String, dynamic> json) {
    return FavoriteMovie(
      movieId: json['movieId'] as String,
      name: json['name'] as String,
      rating: (json['rating'] is int)
          ? (json['rating'] as int).toDouble() // تحويل int إلى double
          : json['rating'] as double, // أو إذا كانت double بالفعل
      imageURL: json['imageURL'] as String,
      year: json['year'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'movieId': movieId,
      'name': name,
      'rating': rating,
      'imageURL': imageURL,
      'year': year,
    };
  }
}
