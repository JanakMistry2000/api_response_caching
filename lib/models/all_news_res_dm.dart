import 'package:api_response_caching/models/article.dart';

class AllNewsResDM {
  AllNewsResDM({
    this.totalResult = 0,
    this.articles = const [],
  });

  factory AllNewsResDM.fromJson(Map<String, dynamic> json) => AllNewsResDM(
        articles: (json['articles'] as List)
            .map(
              (e) => Article.fromJson((e as Map).cast<String, dynamic>()),
            )
            .toList(),
        totalResult: json['totalResult'] as int? ?? 0,
      );

  final int totalResult;
  final List<Article> articles;

  Map<String,  dynamic> toJson() => {
        'totalResult': totalResult,
        'articles': articles.map((e) => e.toJson()).toList()
      };
}
