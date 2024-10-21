import '../../data/models/storeowner_product.dart';

abstract class StoreOwnerProductState {}

class ProductInitial extends StoreOwnerProductState {}

class ProductLoading extends StoreOwnerProductState {}

class ProductLoaded extends StoreOwnerProductState {
  final List<StoreOwnerProduct> productList; // Updated to hold a list of products

  ProductLoaded(this.productList);
}

class ProductError extends StoreOwnerProductState {
  final String message;

  ProductError(this.message);
}