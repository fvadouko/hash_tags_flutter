part of 'generate_hashtag_bloc.dart';

sealed class GenerateHashtagState extends Equatable {
  const GenerateHashtagState();
  
  @override
  List<Object> get props => [];
}

final class GenerateHashtagInitialState extends GenerateHashtagState {
  final int number;

  const GenerateHashtagInitialState(this.number);

  @override
  List<Object> get props => [number];
}

class GenerateHashtagSuccessState extends GenerateHashtagState {
  final List<HashtagModel> hashTags;
  const GenerateHashtagSuccessState({required this.hashTags});

  @override
  List<Object> get props => [hashTags];

}