import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hash_tags_flutter/repositories/hashtag.dart';
import 'package:hash_tags_flutter/screens/home_screen.dart';
import 'package:hash_tags_flutter/services/add_hashtag/add_hashtag_bloc.dart';
import 'package:hash_tags_flutter/services/generate_hashtag/generate_hashtag_bloc.dart';
import 'package:hash_tags_flutter/services/list_hashtag/list_hsahtag_bloc.dart';
import 'package:hash_tags_flutter/services/remove_hashtag/remove_hashtag_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final Database database = await openDatabase(
    join(
      await getDatabasesPath(),
      'hash_tags.db',
    ),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE hashtags(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)",
      );
    },
    version: 1,
  );

  final HashtagRepository hashtagRepository = HashtagRepository(
    database: database,
  );

  runApp( MyApp(
    hashtagRepository: hashtagRepository
  ));
}

class MyApp extends StatelessWidget {
  final HashtagRepository hashtagRepository;
  const MyApp({super.key, required this.hashtagRepository});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: 
            (context) => 
            ListHsahtagBloc(hashtagRepository)
            ..add(OnInitializeListHsahtagEvent()),
          ),
        BlocProvider <AddHashtagBloc>(
          create: (context) => AddHashtagBloc(hashtagRepository),
        ),
        BlocProvider <RemoveHashtagBloc>(
          create: (context) => RemoveHashtagBloc(hashtagRepository),
        ),
        BlocProvider <GenerateHashtagBloc>(
          create: (context) => 
          GenerateHashtagBloc(hashtagRepository)
          ..add(const OnChangeNumberHashtagEvent(number:0)),
        )
      ],
      child: MaterialApp(
        title: 'Hash tags',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen()
      )
    );
  }
}
