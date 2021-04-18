import 'package:dio/dio.dart';
import 'package:tsal_etaleert/src/common/extensions/string_extensions.dart';

class AuthInterceptor extends Interceptor {
  final String _username;
  final String _password;

  AuthInterceptor({
    required final String username,
    required final String password,
  })   : _username = username,
        _password = password;

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final base64 = '$_username:$_password'.toBase64();
    // Add access token to request options
    options.headers['Authorization'] = 'Basic $base64';
    super.onRequest(options, handler);
  }
}
