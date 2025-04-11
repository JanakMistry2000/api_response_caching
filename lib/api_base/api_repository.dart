import 'package:api_response_caching/api_base/api_logger.dart';
import 'package:api_response_caching/api_base/api_service.dart';
import 'package:api_response_caching/api_base/header_interceptor.dart';
import 'package:api_response_caching/models/all_news_res_dm.dart';
import 'package:api_response_caching/models/post_dm.dart';
import 'package:api_response_caching/values/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:http_cache_isar_store/http_cache_isar_store.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class APIRepository {
  APIRepository._();

  Logger logger = Logger();

  static final APIRepository instance = APIRepository._();

  late APIService apiService;
  late HeaderInterceptor headerInterceptor;

  final dio = Dio();

  Future<void> initialise() async {
    var dir = await getApplicationDocumentsDirectory();
    headerInterceptor = HeaderInterceptor();
    final option = CacheOptions(
      policy: CachePolicy.request,
      store: IsarCacheStore(dir.path),
      hitCacheOnNetworkFailure: false,
      maxStale: const Duration(days: 7),
      priority: CachePriority.normal,
      keyBuilder: ({headers, required url}) =>
          '${AppConstants.newsORGBaseURL}${url.path}',
    );
    dio.interceptors.add(headerInterceptor);
    dio.interceptors.add(DioCacheInterceptor(options: option));
    apiService = APIService(
      dio: dio,
      baseUrl: AppConstants.newsORGBaseURL,
      parseErrorLogger: APILogger(),
    );
  }

  Future<List<Post>?> getAllPost() async {
    try {
      return apiService.getAllPost();
    } catch (e) {
      if (e is DioException) {
        logger.e(e.message);
      }
      return null;
    }
  }

  Future<AllNewsResDM?> getNewsArticles({DateTime? from, DateTime? to}) async {
    try {
      return apiService.getAllPostByQuery(
        from: from?.toIso8601String(),
        to: from?.toIso8601String(),
      );
    } catch (e) {
      if (e is DioException) {
        logger.e(e.message);
      }
      return null;
    }
  }
}
