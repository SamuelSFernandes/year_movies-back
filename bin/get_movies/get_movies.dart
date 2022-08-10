import 'package:http/http.dart' as http;

import '../core/models/response_movies_model.dart';
import '../core/models/result_movies_by_year_model.dart';
import '../core/models/result_movies_model.dart';

class GetMovies {
  Future<ResponseMoviesModel> getAllResults(
      {required String title, int page = 1}) async {
    final result = await getMovies(title: title);

    final _getAllPages = await getAllPageResults(item: result, title: title);
    return _getAllPages;
  }

  Future<ResultMoviesModel> getMovies(
      {required String title, int page = 1}) async {
    var url = Uri.parse(
        'https://jsonmock.hackerrank.com/api/movies/search/?Title=$title&page=$page');
    var response = await http.get(
      url,
    );
    return ResultMoviesModel.fromJson(response.body);
  }

  Future<ResponseMoviesModel> getAllPageResults({
    required ResultMoviesModel item,
    required String title,
  }) async {
    List<ResultMoviesModel> listMovies = [];
    listMovies.add(item);

    if (item.totalPages > 1) {
      for (var page = 2; page < item.totalPages + 1; page++) {
        final result = await getMovies(title: title, page: page);
        listMovies.add(result);
      }
    }
    final _organizerResultByYear = organizeResultsByYear(listMovies);
    return _organizerResultByYear;
  }

  Future<ResponseMoviesModel> organizeResultsByYear(
      List<ResultMoviesModel> allMoviesPages) async {
    List<MoviesByYear> _listOrganizedMovies = [];

    for (var moviesPage in allMoviesPages) {
      for (var movies in moviesPage.data) {
        int _getIndexMovieInList = _listOrganizedMovies.indexWhere(
          (element) => movies.year == element.year,
        );

        if (_getIndexMovieInList == -1) {
          final _movie = MoviesByYear(movies: 1, year: movies.year);
          _listOrganizedMovies.add(_movie);
        } else {
          _listOrganizedMovies[_getIndexMovieInList].movies++;
        }
      }
    }
    _listOrganizedMovies.sort((a, b) => a.year.compareTo(b.year));

    return ResponseMoviesModel(
      moviesByYear: _listOrganizedMovies,
      total: allMoviesPages.first.total,
    );
  }
}
