import 'dart:convert';

class MoviesByYear {
  int year;
  int movies;
  MoviesByYear({
    required this.year,
    required this.movies,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'year': year});
    result.addAll({'movies': movies});

    return result;
  }

  factory MoviesByYear.fromMap(Map<String, dynamic> map) {
    return MoviesByYear(
      year: map['year']?.toInt() ?? 0,
      movies: map['movies']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory MoviesByYear.fromJson(String source) =>
      MoviesByYear.fromMap(json.decode(source));
}
