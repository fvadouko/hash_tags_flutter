import 'dart:async';
import 'dart:math';
import 'package:hash_tags_flutter/models/hashtag.dart';
import 'package:sqflite/sqlite_api.dart';

class HashtagRepository {
  final Database database;

  final List<Map<String, dynamic>> listHashtags=[];
  int numberHashtags;

  HashtagRepository({
    required this.database,
    this.numberHashtags =0
  });

  final StreamController<List<HashtagModel>> _hashTagController = 
  StreamController<List<HashtagModel>>();
  
  Stream <List<HashtagModel>> get hashTags => _hashTagController.stream;

  int get number => numberHashtags;
  set number(int value) => numberHashtags = value;

  Future <void> initialize() async {
    List<Map<String, dynamic>> maps = await database.query(
      "hashtags",
    );

    listHashtags.addAll(maps);

print(listHashtags);
     List<HashtagModel> hashtags = listHashtags.map((e) => 
        HashtagModel(id:e["id"], name: e["name"])).toList();
   
    _hashTagController.add(hashtags);
  }

  Future <void> addNewHashtag(Map<String, dynamic> data)  async {

    final HashtagModel hashtag = HashtagModel(
      id: listHashtags.length + 1,
      name: data["name"]
    );

    int id = await database.insert(
      "hashtags", 
      hashtag.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );

    listHashtags.add({
      ...data,
      ...{"id": id}
    });

   
   List<HashtagModel> hashtags = 
   listHashtags
   .map((e) => HashtagModel(id:e["id"], name: e["name"]))
   .toList();
   
    _hashTagController.add(hashtags);
  }

  Future<void> removeHashtag(HashtagModel hashtagModel) async {
   await database.delete(
      "hashtags",
      where: "id = ?",
      whereArgs: [hashtagModel.id],
    );

    listHashtags.removeWhere((element) => element["id"] == hashtagModel.id);
    
    List<HashtagModel> hashtags = 
    listHashtags
    .map((e) => HashtagModel(id:e["id"], name: e["name"]))
    .toList();

    _hashTagController.add(hashtags);
    
  }

  Future <List<HashtagModel>> generate() async {
    listHashtags.shuffle();

    final int n = numberHashtags > listHashtags.length
     ? listHashtags.length 
     : numberHashtags;
    
    int i = 0;
    List<HashtagModel> hashtags = listHashtags
              .sublist(0, numberHashtags)
              .map((e) => HashtagModel(id:i++, name: e["name"]))
              .toList();

    return hashtags;
  }
}