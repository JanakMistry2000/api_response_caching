class Article {
  Article({
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        author: json['author']?.toString(),
        title: json['title']?.toString(),
        description: json['description']?.toString(),
        url: json['url']?.toString(),
        urlToImage: json['urlToImage']?.toString(),
        content: json['content']?.toString(),
      );

  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? content;

  Map<String, dynamic> toJson() => {
        'author': author,
        'title': title,
        'description': description,
        'url': url,
        'urlToImage': urlToImage,
        'content': content,
      };
}
