part of 'add_hashtag_bloc.dart';

sealed class AddHashtagState extends Equatable {
  const AddHashtagState();
  
  @override
  List<Object> get props => [];
}

final class AddHashtagInitial extends AddHashtagState {}

final class AddHashTagSuccessSate extends AddHashtagState {
  final int timestamp;

  const AddHashTagSuccessSate({required this.timestamp});

  @override
  List<Object> get props => [timestamp];
}
