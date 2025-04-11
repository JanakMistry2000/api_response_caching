import 'package:api_response_caching/api_base/insta_api_repository.dart';
import 'package:api_response_caching/models/insta_post_dm.dart';
import 'package:api_response_caching/modules/view/post_view.dart';
import 'package:flutter/material.dart';

class FeedList extends StatefulWidget {
  const FeedList({super.key});

  @override
  State<FeedList> createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  List<InstaPostDm> post = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData({bool refresh = false}) async {
    print('Fetching data...');
    final data = await InstaAPIRepository.instance.getAllPost(refresh: refresh);
    setState(() {
      post = data ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed List'),
      ),
      body: RefreshIndicator(
        onRefresh: () async => fetchData(refresh: true),
        child: FutureBuilder<List<InstaPostDm>?>(
          future: Future.value(post),
          builder: (context, snapshot) => ListView.builder(
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) => PostView(
              post: snapshot.data?[index] ?? InstaPostDm(),
            ),
          ),
        ),
      ),
    );
  }
}
