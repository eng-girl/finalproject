// store_state.dart
import '../../data/models/store_model.dart';

abstract class StoreState {}

class StoreInitial extends StoreState {}

class StoreLoading extends StoreState {}

class StoreLoaded extends StoreState {
  final Store store;

  StoreLoaded(this.store);
}

class StoreError extends StoreState {
  final String message;

  StoreError(this.message);
}