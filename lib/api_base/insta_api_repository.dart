import 'package:api_response_caching/api_base/api_logger.dart';
import 'package:api_response_caching/api_base/header_interceptor.dart';
import 'package:api_response_caching/api_base/insta_api_service.dart';
import 'package:api_response_caching/models/insta_post_dm.dart';
import 'package:api_response_caching/models/profile_dm.dart';
import 'package:api_response_caching/values/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:http_cache_isar_store/http_cache_isar_store.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class InstaAPIRepository {
  InstaAPIRepository._();

  Logger logger = Logger();

  static final InstaAPIRepository instance = InstaAPIRepository._();

  late InstaApiService apiService;
  late HeaderInterceptor headerInterceptor;

  final dio = Dio();
  late final CacheOptions cacheOption;

  IsarCacheStore? cacheStore;

  Future<void> initialise() async {
    var dir = await getApplicationDocumentsDirectory();
    cacheStore = IsarCacheStore(dir.path);
    headerInterceptor = HeaderInterceptor();
    cacheOption = CacheOptions(
      policy: CachePolicy.request,
      store: cacheStore,
      hitCacheOnNetworkFailure: true,
      hitCacheOnErrorCodes: [
        500,
        502,
        503,
        504,
      ],
      maxStale: const Duration(days: 7),
      priority: CachePriority.normal,
      keyBuilder: ({headers, required url}) {
        return '${AppConstants.customAPIURL.split('/api').firstOrNull}${url.path}';
      },
    );
    dio.interceptors.add(headerInterceptor);
    dio.interceptors.add(DioCacheInterceptor(options: cacheOption));
    apiService = InstaApiService(
      dio: dio,
      baseUrl: AppConstants.customAPIURL,
      parseErrorLogger: APILogger(),
    );
  }

  Future<List<InstaPostDm>?> getAllPost({bool refresh = false}) async {
    try {
      var options = {
        '@cache_options@': cacheOption.copyWith(
          policy: refresh ? CachePolicy.refresh : CachePolicy.request,
        )
      };
      return apiService.getAllPost(extras: options);
    } catch (e) {
      if (e is DioException) {
        logger.e(e.message);
      }
      return null;
    }
  }

  Future<ProfileDm?> getProfile(String userName, {bool refresh = false}) async {
    try {
      var options = {
        '@cache_options@':  cacheOption.copyWith(
          policy: refresh ? CachePolicy.refresh : CachePolicy.request,
          priority: CachePriority.low,
        )
      };
      return apiService.getProfile(username: userName, extras: options);
    } catch (e) {
      if (e is DioException) {
        logger.e(e.message);
      }
      return null;
    }
  }
}
