import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hash_tags_flutter/models/hashtag.dart';
import 'package:hash_tags_flutter/repositories/hashtag.dart';

part 'generate_hashtag_event.dart';
part 'generate_hashtag_state.dart';

class GenerateHashtagBloc extends Bloc<GenerateHashtagEvent, GenerateHashtagState> {
  final HashtagRepository hashtagRepository;
  int _count = 0;

  GenerateHashtagBloc(this.hashtagRepository) : super(const GenerateHashtagInitialState(0)) {
    on<OnChangeNumberHashtagEvent>((event, emit) {
      hashtagRepository.number = event.number;
      emit(GenerateHashtagInitialState(event.number));
    });

    on<OnGenerateHashtagEvent>((event, emit) async {
      List<HashtagModel> hashTagsModel = await hashtagRepository.generate();

      emit(GenerateHashtagSuccessState(hashTags: hashTagsModel));
    });
  }
}
