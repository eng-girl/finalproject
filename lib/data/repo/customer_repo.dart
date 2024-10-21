import 'package:dio/dio.dart';
import '../models/customer.dart';
import '../../core/constants/api_constants.dart';

class CustomerRepository {
  final Dio dio = Dio();

  Future<Customer?> getCustomerById(String customerId) async {
    try {
      final response = await dio.get('${ApiConstants.customer}/$customerId'); // Adjust endpoint

      // Log the response for debugging
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        final customerData = response.data['data']['customer'];
        return Customer.fromJson(customerData); // Pass correct data
      }
    } catch (e) {
      print('Error fetching customer by ID: $e');
    }
    return null; // Return null if there is an error
  }
}
