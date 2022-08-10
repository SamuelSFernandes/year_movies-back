import 'dart:convert';

import 'result_movies_by_year_model.dart';

class ResponseMoviesModel {
  List<MoviesByYear> moviesByYear;
  int total;
  ResponseMoviesModel({
    required this.moviesByYear,
    required this.total,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result
        .addAll({'moviesByYear': moviesByYear.map((x) => x.toMap()).toList()});
    result.addAll({'total': total});

    return result;
  }

  factory ResponseMoviesModel.fromMap(Map<String, dynamic> map) {
    return ResponseMoviesModel(
      moviesByYear: List<MoviesByYear>.from(
          map['moviesByYear']?.map((x) => MoviesByYear.fromMap(x))),
      total: map['total']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseMoviesModel.fromJson(String source) =>
      ResponseMoviesModel.fromMap(json.decode(source));
}
