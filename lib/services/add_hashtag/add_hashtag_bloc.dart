import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hash_tags_flutter/models/hashtag.dart';
import 'package:hash_tags_flutter/repositories/hashtag.dart';

part 'add_hashtag_event.dart';
part 'add_hashtag_state.dart';

class AddHashtagBloc extends Bloc<AddHashtagEvent, AddHashtagState> {

    final HashtagRepository hashtagRepository;

    AddHashtagBloc(this.hashtagRepository) : super(AddHashtagInitial()) {
      on<OnAddHashTagEvent>((event, emit) async{
      // TODO: implement event handler
     
      
      await hashtagRepository.addNewHashtag({
        "name": event.hashtag
      });

      emit(AddHashTagSuccessSate(
        timestamp: DateTime.now().millisecondsSinceEpoch
      ));
    });
  }
}
