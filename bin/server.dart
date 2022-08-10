import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

import 'get_movies/get_movies.dart';

final _router = Router()..get('/api/movies/count', _echoHandler);

void main(List<String> args) async {
  final _handle = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  final server = await io.serve(_handle, '0.0.0.0', 4466);

  print('Online: ${server.address.address}:${server.port}');
}

Future<Response> _echoHandler(Request request) async {
  final getMovies = GetMovies();
  final String? query = request.requestedUri.queryParameters["title"];
  final result = await getMovies.getAllResults(title: query ?? '');

  return Response.ok(result.toJson());
}
