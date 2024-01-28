part of 'remove_hashtag_bloc.dart';

sealed class RemoveHashtagState extends Equatable {
  const RemoveHashtagState();
  
  @override
  List<Object> get props => [];
}

final class RemoveHashtagInitial extends RemoveHashtagState {}

class RemoveHashtagSuccessState extends RemoveHashtagState {
  final int timestamp;

  const RemoveHashtagSuccessState({required this.timestamp});

  @override
  List<Object> get props => [timestamp];
}
