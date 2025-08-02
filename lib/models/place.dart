class Place {
  final int id;
  final String name;
  final String image;
  final String category;
  bool isFavorite;

  Place({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.isFavorite,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      category: json['category'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'category': category,
      'isFavorite': isFavorite,
    };
  }
}