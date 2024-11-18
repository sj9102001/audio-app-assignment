class Program {
  final String id;
  final String name;
  final String description;
  final String duration;
  final String imageUrl;

  Program({
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
    required this.imageUrl,
  });

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      duration: json['duration'],
      imageUrl: json['imageUrl'],
    );
  }
}
