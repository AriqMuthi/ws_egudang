import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'lib/Controller.dart';

Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  final Controller ctrl = Controller();
  ctrl.ConnectSql();

  // Configure routes.
  final _router = Router()
    ..get('/', _rootHandler)
    ..get('/getallroleusers', ctrl.getAllRoleUsers)
    ..post('/postRoleUser', ctrl.postRoleUser)
    ..put('/putRoleUsers', ctrl.putRoleUsers)
    ..delete('/deleteRoleUsers', ctrl.deleteRoleUsers)
    ..get('/getallusers', ctrl.getAllUsers)
    ..post('/postusers', ctrl.postUsers)
    ..put('/putUsers', ctrl.putUsers)
    ..delete('/deleteuser', ctrl.deleteUsers)
    ..get('/getalljenisbarang', ctrl.getAllJenis_Barang)
    ..post('/postJenisBarang', ctrl.postJenis_Barang)
    ..put('/putJenisBarang', ctrl.putJenis_Barang)
    ..delete('/deleteJenisBarang', ctrl.deleteJenis_Barang);

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
