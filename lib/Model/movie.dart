import 'package:movies/Model/fav_movies.dart';

class Movie {
  final int id;
  final String url;
  final String imdbCode;
  final String title;
  final String titleEnglish;
  final String titleLong;
  final String slug;
  final int year;
  final double rating;
  final int runtime;
  final List<String> genres;
  final String summary;
  final String descriptionFull;
  final String synopsis;
  final String ytTrailerCode;
  final String language;
  final String mpaRating;
  final String backgroundImage;
  final String backgroundImageOriginal;
  final String smallCoverImage;
  final String mediumCoverImage;
  final String largeCoverImage;
  final String state;
  final String dateUploaded;
  final int dateUploadedUnix;
  int? likeCount;

  Movie({
    required this.id,
    required this.url,
    required this.imdbCode,
    required this.title,
    required this.titleEnglish,
    required this.titleLong,
    required this.slug,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.genres,
    required this.summary,
    required this.descriptionFull,
    required this.synopsis,
    required this.ytTrailerCode,
    required this.language,
    required this.mpaRating,
    required this.backgroundImage,
    required this.backgroundImageOriginal,
    required this.smallCoverImage,
    required this.mediumCoverImage,
    required this.largeCoverImage,
    required this.state,
    required this.dateUploaded,
    required this.dateUploadedUnix,
    this.likeCount,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    var genresFromJson = json['genres'] as List?;
    return Movie(
      id: json['id'] as int? ?? 0,
      url: json['url'] as String? ?? '',
      imdbCode: json['imdb_code'] as String? ?? '',
      title: json['title'] as String? ?? '',
      titleEnglish: json['title_english'] as String? ?? '',
      titleLong: json['title_long'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      year: int.tryParse(json['year'].toString()) ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      runtime: json['runtime'] as int? ?? 0,
      genres: genresFromJson != null
          ? genresFromJson.map((e) => e as String).toList()
          : [],
      summary: json['summary'] as String? ?? '',
      descriptionFull: json['description_full'] as String? ?? '',
      synopsis: json['synopsis'] as String? ?? '',
      ytTrailerCode: json['yt_trailer_code'] as String? ?? '',
      language: json['language'] as String? ?? '',
      mpaRating: json['mpa_rating'] as String? ?? '',
      backgroundImage: json['background_image'] as String? ?? '',
      backgroundImageOriginal:
      json['background_image_original'] as String? ?? '',
      smallCoverImage: json['small_cover_image'] as String? ?? '',
      mediumCoverImage: json['medium_cover_image'] as String? ?? '',
      largeCoverImage: json['large_cover_image'] as String? ?? '',
      state: json['state'] as String? ?? '',
      dateUploaded: json['date_uploaded'] as String? ?? '',
      dateUploadedUnix: json['date_uploaded_unix'] as int? ?? 0,
      likeCount: int.tryParse(json['like_count'].toString()) ?? null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'imdb_code': imdbCode,
      'title': title,
      'title_english': titleEnglish,
      'title_long': titleLong,
      'slug': slug,
      'year': year,
      'rating': rating,
      'runtime': runtime,
      'genres': genres,
      'summary': summary,
      'description_full': descriptionFull,
      'synopsis': synopsis,
      'yt_trailer_code': ytTrailerCode,
      'language': language,
      'mpa_rating': mpaRating,
      'background_image': backgroundImage,
      'background_image_original': backgroundImageOriginal,
      'small_cover_image': smallCoverImage,
      'medium_cover_image': mediumCoverImage,
      'large_cover_image': largeCoverImage,
      'state': state,
      'date_uploaded': dateUploaded,
      'date_uploaded_unix': dateUploadedUnix,
      'like_count': likeCount,
    };
  }

  Movie convertFavoriteMovieToMovie(FavoriteMovie favoriteMovie) {
    return Movie(
      id: int.parse(favoriteMovie.movieId),
      title: favoriteMovie.name,
      rating: favoriteMovie.rating,
      year: int.parse(favoriteMovie.year),
      mediumCoverImage: favoriteMovie.imageURL,
      largeCoverImage: favoriteMovie.imageURL,
      url: '', imdbCode: '', titleEnglish: '', titleLong: '', slug: '', runtime: 0, genres: [], summary: '', descriptionFull: '', synopsis: '', ytTrailerCode: '', language: '', mpaRating: '', backgroundImage: '', backgroundImageOriginal: '', smallCoverImage: '', state: '', dateUploaded: '', dateUploadedUnix: 0,
    );
  }
}
