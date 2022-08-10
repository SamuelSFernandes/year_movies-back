import 'dart:convert';

class ResultMoviesModel {
  int page;
  int perPage;
  int total;
  int totalPages;
  List<MoviesItemModel> data;
  ResultMoviesModel({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'page': page});
    result.addAll({'per_page': perPage});
    result.addAll({'total': total});
    result.addAll({'total_pages': totalPages});
    result.addAll({'data': data.map((x) => x.toMap()).toList()});

    return result;
  }

  factory ResultMoviesModel.fromMap(Map<String, dynamic> map) {
    return ResultMoviesModel(
      page: map['page']?.toInt() ?? 0,
      perPage: map['per_page']?.toInt() ?? 0,
      total: map['total']?.toInt() ?? 0,
      totalPages: map['total_pages']?.toInt() ?? 0,
      data: List<MoviesItemModel>.from(
          map['data']?.map((x) => MoviesItemModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultMoviesModel.fromJson(String source) =>
      ResultMoviesModel.fromMap(json.decode(source));
}

class MoviesItemModel {
  String title;
  int year;
  String imdbID;
  MoviesItemModel({
    required this.title,
    required this.year,
    required this.imdbID,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'Title': title});
    result.addAll({'Year': year});
    result.addAll({'imdbID': imdbID});

    return result;
  }

  factory MoviesItemModel.fromMap(Map<String, dynamic> map) {
    return MoviesItemModel(
      title: map['Title'] ?? '',
      year: map['Year']?.toInt() ?? 0,
      imdbID: map['imdbID'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MoviesItemModel.fromJson(String source) =>
      MoviesItemModel.fromMap(json.decode(source));
}
