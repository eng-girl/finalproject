import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../models/storeowner_product.dart';

class StoreOwnerProductRepository {
  final Dio dio = Dio();

  Future<List<StoreOwnerProduct>> getProductsByStoreOwner(String storeOwnerId) async {
    try {
      final response = await dio.get('${ApiConstants.storeOwner}/$storeOwnerId');

      if (response.statusCode == 200 && response.data != null) {
        print('Response data: ${response.data}');

        // Extract the product list from the response
        final storeData = response.data['store'];
        if (storeData != null && storeData['products'] != null) {
          final productList = List<Map<String, dynamic>>.from(storeData['products']);
          return productList.map((product) => StoreOwnerProduct.fromJson(product)).toList();
        }
      }
    } catch (e) {
      print('Error fetching product details: $e');
    }
    return [];
  }
}