class Track {
  final String id;
  final String programId;
  final String title;
  final String description;
  final String audioFileUrl;

  Track({
    required this.id,
    required this.programId,
    required this.title,
    required this.description,
    required this.audioFileUrl,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    print(json["_id"]);
    print(json["programId"]);
    print(json["title"]);
    print("description ${json["description"]}");
    print("audioFileUrl ${json["audioFileUrl"]}");

    return Track(
      id: json['_id'],
      programId: json['programId'],
      title: json['title'],
      description: json['description'],
      audioFileUrl: json['audioFileUrl'],
    );
  }
}
