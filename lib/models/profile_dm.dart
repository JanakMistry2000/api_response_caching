import 'package:api_response_caching/models/insta_post_dm.dart';

class ProfileDm {
  factory ProfileDm.fromJson(Map<String, dynamic> json) {
    return ProfileDm(
      username: json['username'] as String?,
      fullName: json['full_name'] as String?,
      bio: json['bio'] as String?,
      followersCount: json['followers_count'] as int?,
      followingCount: json['following_count'] as int?,
      postsCount: json['posts_count'] as int?,
      posts: (json['posts'] as List<dynamic>?)
              ?.map((e) => InstaPostDm.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  ProfileDm({
    this.username,
    this.bio,
    this.followersCount,
    this.followingCount,
    this.fullName,
    this.postsCount,
    this.posts = const [],
  });

  final String? username;
  final String? fullName;
  final String? bio;
  final int? followersCount;
  final int? followingCount;
  final int? postsCount;
  final List<InstaPostDm> posts;
}
