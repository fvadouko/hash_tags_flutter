part of 'add_hashtag_bloc.dart';

sealed class AddHashtagEvent extends Equatable {
  const AddHashtagEvent();

  @override
  List<Object> get props => [];
}

class OnAddHashTagEvent extends AddHashtagEvent {
  final String hashtag;
  const OnAddHashTagEvent({required this.hashtag});

  @override
  List<Object> get props => [hashtag];
}