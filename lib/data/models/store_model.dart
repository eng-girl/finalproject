class Store {
  final String id;
  final String name;
  final String image;
  final String bio;
  final String contactInfo;
  final int totalOrders;

  Store({
    required this.id,
    required this.name,
    required this.image,
    required this.bio,
    required this.contactInfo,
    required this.totalOrders,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['_id'] ?? 'unknown',
      name: json['store']['name'] ?? 'Unnamed Store',
      image: json['store']['image'] ?? '',
      bio: json['store']['bio'] ?? 'No bio available',
      contactInfo: json['store']['contactInfo'] ?? 'No contact info',
      totalOrders: json['store']['totalOrders'] ?? 0,
    );
  }
}