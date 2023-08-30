part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}

final class PostFetchedEvent extends PostEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
