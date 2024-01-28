import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hash_tags_flutter/services/add_hashtag/add_hashtag_bloc.dart';

class AddHashTagComponent extends StatefulWidget {
  const AddHashTagComponent({super.key});

  @override
  State<AddHashTagComponent> createState() => _AddHashTagComponentState();
}

class _AddHashTagComponentState extends State<AddHashTagComponent> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _modal(BuildContext context) => showModalBottomSheet(
      context: context,
      builder: (context) => BlocListener<AddHashtagBloc, AddHashtagState>(
            listener: (context, state) {
              if(state is AddHashTagSuccessSate) {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Hashtag added")),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Hashtag Creator",
                      style: Theme.of(context).textTheme.headlineSmall),
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                          labelText: "Hashtag", hintText: "Enter your hashtag")),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancel".toUpperCase()),
                      ),
                      TextButton(
                        onPressed: () {
                          
                          if (_controller.text.isNotEmpty) {
                            context
                            .read<AddHashtagBloc>()
                            .add(OnAddHashTagEvent(hashtag: _controller.text));
                            _controller.clear();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("The hashtag can't be empty")));
                          }
                        },
                        child: Text("Add".toUpperCase()),
                      )
                    ],
                  ),
                )
              ]),
            ),
          ));

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: const Icon(Icons.add), onPressed: () => _modal(context));
  }
}
