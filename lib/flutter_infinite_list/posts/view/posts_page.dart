import 'package:bloc_verse/flutter_infinite_list/posts/bloc/post_bloc.dart';
import 'package:bloc_verse/flutter_infinite_list/posts/view/posts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../utils/utils.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DeviceMode.isLight() ? Colors.white : Colors.black87,
      body: SafeArea(
        bottom: false,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              elevation: 0,
              centerTitle: true,
              floating: true,
              snap: false,
              title: Text(
                "Posts",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: DeviceMode.isLight() ? Colors.black : Colors.white),
              ),
              backgroundColor:
                  DeviceMode.isLight() ? Colors.white : Colors.black87,
            ),
          ],
          body: BlocProvider(
            create: (_) =>
                PostBloc(httpClient: http.Client())..add(PostFetchedEvent()),
            child: const PostsList(),
          ),
        ),
      ),
    );
  }
}
