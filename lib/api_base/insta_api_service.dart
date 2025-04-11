import 'package:api_response_caching/models/insta_post_dm.dart';
import 'package:api_response_caching/models/profile_dm.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'insta_api_service.g.dart';

@RestApi()
abstract class InstaApiService {
  factory InstaApiService({
    required Dio dio,
    required String baseUrl,
    required ParseErrorLogger parseErrorLogger,
  }) {
    return _InstaApiService(dio,
        baseUrl: baseUrl, errorLogger: parseErrorLogger);
  }

  @GET('/feed')
  Future<List<InstaPostDm>> getAllPost({
    @Extras() Map<String, dynamic>? extras,
  });

  @GET('/profile/{username}')
  Future<ProfileDm> getProfile({
    @Path('username') required String username,
    @Extras() Map<String, dynamic>? extras,
  });

  @PUT('/profile/{username}/update')
  Future<String> updateProfile(@Path('username') String username);

  @PUT('/post/{postId}/update')
  Future<String> updatePost(@Path('postId') String postId);
}
