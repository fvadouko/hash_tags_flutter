part of 'remove_hashtag_bloc.dart';

sealed class RemoveHashtagEvent extends Equatable {
  const RemoveHashtagEvent();

  @override
  List<Object> get props => [];
}

class OnRemoveHashTagEvent extends RemoveHashtagEvent {
  final HashtagModel hashtagModel;
  const OnRemoveHashTagEvent({required this.hashtagModel});

  @override
  List<Object> get props => [hashtagModel];

}
