import 'package:api_response_caching/models/all_news_res_dm.dart';
import 'package:api_response_caching/models/post_dm.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'api_service.g.dart';

@RestApi()
abstract class APIService {
  factory APIService({
    required Dio dio,
    required String baseUrl,
    required ParseErrorLogger parseErrorLogger,
  }) {
    return _APIService(dio, baseUrl: baseUrl, errorLogger: parseErrorLogger);
  }

  @GET('/posts')
  Future<List<Post>> getAllPost();

  @GET('/everything')
  Future<AllNewsResDM> getAllPostByQuery({
    @Query('from') String? from,
    @Query('to') String? to,
    @Query('sortBy') String sortBy = 'relevancy',
    @Query('q') String query = 'World news',
  });
}
