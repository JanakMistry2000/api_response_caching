class AllNewsReqDM {
  AllNewsReqDM({
    this.pageSize = 100,
    this.page = 1,
    this.language = 'en',
    this.query = 'World news',
    this.searchIn = 'title,content,description',
  });

  final int pageSize;
  final int page;
  final String language;
  final String query;
  final String searchIn;

  Map<String, dynamic> toJson() => {
        'pageSize': pageSize,
        'page': page,
        'language': 'en',
        'q': query,
        'searchIn': searchIn,
      };
}
