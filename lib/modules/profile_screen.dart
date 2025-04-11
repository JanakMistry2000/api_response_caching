import 'package:api_response_caching/api_base/insta_api_repository.dart';
import 'package:api_response_caching/models/profile_dm.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.username});

  final String username;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = true;
  ProfileDm? profile;

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  Future<void> fetchProfile({bool refresh = false}) async {
    setState(() {
      isLoading = true;
    });
    profile = await InstaAPIRepository.instance.getProfile(
      widget.username,
      refresh: refresh,
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profile'),
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : profile == null
              ? const Center(child: Text('Error fetching data'))
              : RefreshIndicator(
                  onRefresh: () => fetchProfile(refresh: true),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            child: Icon(Icons.person),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${profile?.username}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Post'),
                                      const SizedBox(height: 8),
                                      Text('${profile?.postsCount ?? 0}'),
                                    ],
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Followers'),
                                      const SizedBox(height: 8),
                                      Text('${profile?.followersCount ?? 0}'),
                                    ],
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Following'),
                                      const SizedBox(height: 8),
                                      Text('${profile?.followingCount ?? 0}'),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(),
                        child: Text(
                          profile?.bio ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 2,
                                  childAspectRatio: 9 / 12),
                          itemCount: profile?.posts.length ?? 0,
                          itemBuilder: (context, index) {
                             return Image.network(
                              'https://yavuzceliker.github.io/sample-images/image-${profile?.posts[index].id}.jpg',
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
    );
  }
}
