import 'package:api_response_caching/models/insta_post_dm.dart';
import 'package:api_response_caching/modules/profile_screen.dart';
import 'package:flutter/material.dart';

class PostView extends StatefulWidget {
  const PostView({super.key, required this.post});

  final InstaPostDm post;

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            visualDensity: VisualDensity.compact,
            title: Text(
              '${widget.post.username}',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            subtitle: Text(
              widget.post.location ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProfileScreen(
                  username: widget.post.username ?? '',
                ),
              ),
            ),
          ),
          AspectRatio(
            aspectRatio: 1 / 1,
            child: Image.network(
              'https://yavuzceliker.github.io/sample-images/image-${widget.post.id}.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox.expand(
                  child: Icon(
                    Icons.broken_image_outlined,
                    size: 40,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.favorite,
                      color: Colors.redAccent,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.post.likesCount ?? '0'}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.comment_outlined),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.post.commentsCount ?? '0'}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  widget.post.caption ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
