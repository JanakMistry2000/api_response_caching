import 'package:api_response_caching/api_base/api_repository.dart';
import 'package:api_response_caching/api_base/insta_api_repository.dart';
import 'package:api_response_caching/helpers/network_utils.dart';
import 'package:api_response_caching/models/post_dm.dart';
import 'package:api_response_caching/modules/feed_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> posts = [];

  @override
  void initState() {
    APIRepository.instance.initialise();
    InstaAPIRepository.instance.initialise();
    NetworkUtils.getInstance().initialize();
    super.initState();
  }

  Future<void> _incrementCounter() async {
    final news = await APIRepository.instance.getNewsArticles();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const FeedList(),
            ),
          ),
          child: const Text('Open feed listing'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
