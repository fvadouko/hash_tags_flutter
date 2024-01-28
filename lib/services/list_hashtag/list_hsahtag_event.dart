part of 'list_hsahtag_bloc.dart';

sealed class ListHsahtagEvent extends Equatable {
  const ListHsahtagEvent();

  @override
  List<Object> get props => [];
}

 class OnInitializeListHsahtagEvent extends ListHsahtagEvent {
  
} 

class OnHashtagUpdatedListHashtagEvent extends ListHsahtagEvent {
  final List<HashtagModel> hashTags;
  const OnHashtagUpdatedListHashtagEvent({required this.hashTags});

  @override
  List<Object> get props => [hashTags];
}