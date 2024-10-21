import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../models/store_model.dart';

class StoreRepository {
  final Dio dio = Dio();

  Future<Store?> getStoreByUserId(String userId) async {
    try {
      print('Fetching store for userId: $userId');
      final response = await dio.get('${ApiConstants.storeOwner}/$userId');
      print('Response status: ${response.statusCode}');
      if (response.statusCode == 200 && response.data != null) {
        return Store.fromJson(response.data);
      }
    } catch (e) {
      print('Error fetching store details: $e');
    }
    return null;
  }
}
