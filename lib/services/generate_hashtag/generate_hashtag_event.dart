part of 'generate_hashtag_bloc.dart';

sealed class GenerateHashtagEvent extends Equatable {
  const GenerateHashtagEvent();

  @override
  List<Object> get props => [];
}

class OnChangeNumberHashtagEvent extends GenerateHashtagEvent {
  final int number;
  const OnChangeNumberHashtagEvent({required this.number});

  @override
  List<Object> get props => [number];

}

class OnGenerateHashtagEvent extends GenerateHashtagEvent {}
