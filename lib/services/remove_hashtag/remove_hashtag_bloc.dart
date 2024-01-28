import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hash_tags_flutter/models/hashtag.dart';
import 'package:hash_tags_flutter/repositories/hashtag.dart';

part 'remove_hashtag_event.dart';
part 'remove_hashtag_state.dart';

class RemoveHashtagBloc extends Bloc<RemoveHashtagEvent, RemoveHashtagState> {
  final HashtagRepository hashtagRepository;

  RemoveHashtagBloc(
    this.hashtagRepository
  ) : super(RemoveHashtagInitial()) {
    on<OnRemoveHashTagEvent>((event, emit) async{
      
      await hashtagRepository.removeHashtag(event.hashtagModel);

      emit(RemoveHashtagSuccessState(
        timestamp: DateTime.now().millisecondsSinceEpoch
      ));
    });
  }
}
