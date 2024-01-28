import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hash_tags_flutter/components/number_text_field.dart';
import 'package:hash_tags_flutter/models/hashtag.dart';
import 'package:hash_tags_flutter/services/generate_hashtag/generate_hashtag_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  Future<void> _copyToClipBoard(
    BuildContext context, 
    GenerateHashtagSuccessState state, 
    List<HashtagModel> listHashtags) async {
    final String listHashtags = state.hashTags.map((e) => "#${e.name}").join(" ");

    await Clipboard.setData(ClipboardData(text: listHashtags));

    ScaffoldMessenger.of(context)
      .showSnackBar(const SnackBar(content: Text("Hashtags copied to clipboard")));
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          const Padding(
            padding: const EdgeInsets.all(8.0),
            child: const NumberTextFieldComponent(),
          ),
          SizedBox(
            height: 45.0,
            child: ElevatedButton(
              onPressed: () {
                context.read<GenerateHashtagBloc>()
                .add(OnGenerateHashtagEvent());
              }, 
              child:const     Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Geneate"),
                  ),
                  Icon(Icons.copy)
                ]
              )
            ),
          ),
          Expanded(
            child:BlocConsumer<GenerateHashtagBloc, GenerateHashtagState>(
              listener: (context, state) async {
                if(state is GenerateHashtagSuccessState) {
                  _copyToClipBoard(context, state, state.hashTags);
                }
              },
              builder: (context, state) {
                if(state is GenerateHashtagSuccessState) {
                  return ListView.builder(
                    itemCount: state.hashTags.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key("${index.toString()}-${DateTime.now().millisecondsSinceEpoch}"), 
                        background: Container(color: Colors.red),
                        onDismissed: (direction) {
                          state.hashTags.removeAt(index);
                           _copyToClipBoard(context, state, state.hashTags);
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(state.hashTags[index].name),
                          )
                       )
                      );
                    }
                  );
                }
                return Container(
                  height: 50.0,
                  child: const Center(
                    child: Text("No hashtags generated"),
                    ),
                );
              }
            )
            )
        ],
      )
    );
  }
}