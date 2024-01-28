import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hash_tags_flutter/models/hashtag.dart';
import 'package:hash_tags_flutter/services/list_hashtag/list_hsahtag_bloc.dart';
import 'package:hash_tags_flutter/services/remove_hashtag/remove_hashtag_bloc.dart';

class ListHashTagView extends StatelessWidget {
  const ListHashTagView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RemoveHashtagBloc, RemoveHashtagState>(
      listener: (context, state) {
        if(state is RemoveHashtagSuccessState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Item removed")));
        }
      },
      child: BlocConsumer<ListHsahtagBloc, ListHsahtagState>(
          listener: (context, state) {}, 
          builder: (context, state) {
        List<HashtagModel> listHashtags = [];

        
        if (state is ListHsahtagInitialState) {
          print (state.listHashtags);
          listHashtags = state.listHashtags;
        }

        return listHashtags.isEmpty
            ? const Center(child: Text("No hashtags"))
            : ListView.builder(
                itemCount: listHashtags.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                      key: Key(
                          "${index.toString()}-${DateTime.now().millisecondsSinceEpoch}"),
                      background: Container(color: Colors.red),
                      onDismissed: (direction) {
                        context.read<RemoveHashtagBloc>().add(
                            OnRemoveHashTagEvent(
                                hashtagModel: listHashtags[index]));
                      },
                      child: Card(
                          child: ListTile(
                        title: Text("#${listHashtags[index].name}"),
                      )));
                });
      }),
    );
  }
}
