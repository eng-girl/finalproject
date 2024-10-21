class Customer {
  final String id;
  final String name; // This will be the username from the nested user object
  final String email; // Extract email from the nested user object
  final String address; // Optional, handle based on API

  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    final user = json['user'] ?? {}; // Extract the nested user object

    return Customer(
      id: json['_id'] ?? '',
      name: user['username'] ?? 'Unknown', // Use the username field from user
      email: user['email'] ?? 'No email provided', // Use the email field from user
      address: json['address'] ?? 'No address provided', // Handle if address is present
    );
  }
}
