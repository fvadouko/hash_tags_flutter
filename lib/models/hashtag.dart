class HashtagModel {
  final int id;
  final String name;

  const HashtagModel({
    required this.id, 
    required this.name
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name
  };
}