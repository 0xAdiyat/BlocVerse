import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

import '../../exceptions/api_exceptions.dart';
import '../models/post_model.dart';

part 'post_event.dart';
part 'post_state.dart';

const _postLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

// EventTransformer for throttling and dropping events
EventTransformer<E> throttleDroppable<E>(Duration duration) =>
    (events, mapper) => droppable<E>().call(events.throttle(duration), mapper);

// PostBloc will be receiving PostEvents and converting them to PostStates
class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;

  PostBloc({required this.httpClient}) : super(const PostState()) {
    on<PostFetchedEvent>(_onPostFetchedEvent,
        transformer: throttleDroppable(throttleDuration));
  }

  // Handling PostFetchedEvent
  Future<void> _onPostFetchedEvent(
      PostFetchedEvent event, Emitter<PostState> emit) async {
    if (state.hasReachedMax) return;

    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts();
        return emit(state.copyWith(
            status: PostStatus.success, posts: posts, hasReachedMax: false));
      }

      final posts = await _fetchPosts(state.posts.length);
      emit(state.posts.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: PostStatus.success,
              posts: List.of(state.posts)..addAll(posts),
              hasReachedMax: false,
            ));
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  // Fetch posts from the API
  Future<List<Post>> _fetchPosts([int startIndex = 0]) async {
    final response = await httpClient.get(Uri.https(
        'jsonplaceholder.typicode.com',
        '/posts',
        <String, String>{'_start': '$startIndex', '_limit': '$_postLimit'}));

    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) => Post.fromJson(json)).toList();
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      throw ClientException('Client error');
    } else if (response.statusCode >= 500) {
      throw ServerException('Server error');
    } else {
      throw Exception('Unknown error');
    }
  }
}

/*
  Cascade notation (..) is known as cascade notation.
  It allows you to not repeat the same target if you want
  to call several methods on the same object.

  Example without cascade:

  List list = [];
  list.add(color1);
  list.add(color2);
  list.add(color3);
  list.add(color4);

  Example with cascade:

  List list = [];
  list
    ..add(color1)
    ..add(color2)
    ..add(color3)
    ..add(color4);
*/
