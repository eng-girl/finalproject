class StoreOwnerProduct {
  final String id;
  final String name;
  final double price;
  final String description;
  final String material;
  final String category;
  final String? subcategory;
  final List<String> colors;
  final String storeOwner;
  final String timeToBeCreated;
  final List<String> images;
  final String? thumbnail; // Change to nullable
  final int stock;

  StoreOwnerProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.material,
    required this.category,
    this.subcategory,
    required this.colors,
    required this.storeOwner,
    required this.timeToBeCreated,
    required this.images,
    this.thumbnail, // Change to nullable
    required this.stock,
  });

  factory StoreOwnerProduct.fromJson(Map<String, dynamic> json) {
    return StoreOwnerProduct(
      id: json['_id'] ?? 'unknown',
      name: json['name'] ?? 'Unnamed Product',
      price: json['price']?.toDouble() ?? 0.0,
      description: json['description'] ?? 'No description available',
      material: json['material'] ?? 'No material specified',
      category: json['category'] ?? 'Uncategorized',
      subcategory: json['subcategory'],
      colors: List<String>.from(json['colors'] ?? []),
      storeOwner: json['storeOwner'] ?? 'unknown',
      timeToBeCreated: json['timeToBeCreated'] ?? 'unknown',
      images: List<String>.from(json['images'] ?? []),
      thumbnail: json['thumbnail'] != null && Uri.tryParse(json['thumbnail'])?.hasAbsolutePath == true
          ? json['thumbnail']
          : null, // Set to null when no valid thumbnail
      stock: json['stock'] ?? 0,
    );
  }
}