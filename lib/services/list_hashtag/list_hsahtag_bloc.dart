import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hash_tags_flutter/models/hashtag.dart';
import 'package:hash_tags_flutter/repositories/hashtag.dart';

part 'list_hsahtag_event.dart';
part 'list_hsahtag_state.dart';

class ListHsahtagBloc extends Bloc<ListHsahtagEvent, ListHsahtagState> {
  final HashtagRepository hashtagRepository;

  ListHsahtagBloc(this.hashtagRepository) : super(ListHsahtagInitialState(
    listHashtags: List<HashtagModel>.from([])
  )) {

    on<OnInitializeListHsahtagEvent>((event, emit) async {
      hashtagRepository.initialize();
      emit(const ListHsahtagInitialState(listHashtags: [])); 
    });

    hashtagRepository.hashTags.listen((hashTags) {
      add(OnHashtagUpdatedListHashtagEvent(hashTags: hashTags));
    });

    on<OnHashtagUpdatedListHashtagEvent>((event, emit) {
      emit(ListHsahtagInitialState(listHashtags: event.hashTags)); 
    });
  }
}
