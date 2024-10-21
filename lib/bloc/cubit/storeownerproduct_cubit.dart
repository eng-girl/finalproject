import 'package:bloc/bloc.dart';
import '../../data/models/storeowner_product.dart';
import '../../data/repo/storeownerproduct_repo.dart';
import '../state/storeownerproduct_state.dart';

class StoreOwnerProductCubit extends Cubit<StoreOwnerProductState> {
  final StoreOwnerProductRepository repository;

  StoreOwnerProductCubit(this.repository) : super(ProductInitial());

  // In storeownerproduct_cubit.dart
  Future<void> fetchProductByStoreOwner(String storeOwnerId) async {
    emit(ProductLoading());
    try {
      final List<StoreOwnerProduct> products = await repository.getProductsByStoreOwner(storeOwnerId);
      if (products.isNotEmpty) {
        emit(ProductLoaded(products));
      } else {
        emit(ProductError('No products available.')); // Emit error state for no products
      }
    } catch (e) {
      emit(ProductError('Error: $e'));
    }
  }
}