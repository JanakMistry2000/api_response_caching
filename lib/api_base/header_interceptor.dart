import 'package:api_response_caching/api_base/api_logger.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class HeaderInterceptor extends Interceptor {
  final APILogger _logger = APILogger();
  final CacheStore? store;

  HeaderInterceptor({this.store});

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['X-api-key'] = '';
    options.headers['ngrok-skip-browser-warning'] = '';
    _logger.printSuccessLog(
      apiMethod: options.method,
      responseBody: options.data,
      parameters: options.queryParameters,
      url: '${options.baseUrl}${options.path}',
      token: options.headers['X-api-key'].toString(),
      header: options.headers,
    );
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final headers = response.requestOptions.headers;
    _logger.printSuccessLog(
      apiMethod: response.requestOptions.method,
      responseBody: response.data,
      parameters: response.requestOptions.data as dynamic,
      url: '${response.realUri.scheme}://${response.realUri.authority}'
          '${response.realUri.path}',
      token: headers['X-api-key'].toString(),
      isRequest: false,
      header: headers,
    );
    handler.next(response);
  }
}
