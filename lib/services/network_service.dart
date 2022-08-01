import 'package:dio/dio.dart';
import 'package:game_lib_app/credentials.dart';

class NetworkService {
  static Dio? _api;

  NetworkService() {
    _api ??= Dio(
      BaseOptions(
        baseUrl: 'https://api.igdb.com/',
        connectTimeout: 20000,
        receiveTimeout: 20000,
        sendTimeout: 20000,
      ),
    );
  }

  // The same header for all requests:
  _setHeader() {
    _api!.options.headers.clear();
    _api!.options.headers['Client-ID'] = clientID;
    _api!.options.headers['Authorization'] = auth;
  }

  Future<Response> get(String path) async {
    _setHeader();
    return await _api!.get(path);
  }

  Future<Response> post(String path, String data) async {
    _setHeader();
    return await _api!.post(path, data: data);
  }

  Future<Response> put(String path, Map<String, dynamic> data) async {
    _setHeader();
    return await _api!.put(path, data: data);
  }
}
