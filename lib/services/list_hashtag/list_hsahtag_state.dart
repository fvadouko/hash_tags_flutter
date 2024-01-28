part of 'list_hsahtag_bloc.dart';

sealed class ListHsahtagState extends Equatable {
  const ListHsahtagState();
  
  @override
  List<Object> get props => [];
}

final class ListHsahtagInitialState extends ListHsahtagState {
  final List<HashtagModel> listHashtags;

  const ListHsahtagInitialState({required this.listHashtags});

  @override
  List<Object> get props => [];
}
