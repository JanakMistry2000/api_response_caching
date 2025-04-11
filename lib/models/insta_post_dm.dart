class InstaPostDm {
  InstaPostDm({
    this.id,
    this.username,
    this.caption,
    this.contentType,
    this.location,
    this.commentsCount,
    this.likesCount,
  });

  final int? id;
  final String? username;
  final String? caption;
  final String? contentType;
  final int? likesCount;
  final int? commentsCount;
  final String? location;

  factory InstaPostDm.fromJson(Map<String, dynamic> json) {
    return InstaPostDm(
      id: json['id'] as int?,
      username: json['username'] as String?,
      caption: json['caption'] as String?,
      contentType: json['content_type'] as String?,
      likesCount: json['likes_count'] as int?,
      commentsCount: json['comments_count'] as int?,
      location: json['location'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'caption': caption,
        'content_type': contentType,
        'likes_count': likesCount,
        'comments_count': commentsCount,
        'location': location,
      };
}
