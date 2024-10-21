// customer_state.dart
import '../../data/models/customer.dart';

abstract class CustomerState {}

class CustomerInitial extends CustomerState {}

class CustomerLoading extends CustomerState {}

class CustomerLoaded extends CustomerState {
  final Customer customer;

  CustomerLoaded(this.customer);
}

class CustomerError extends CustomerState {
  final String message;

  CustomerError(this.message);
}
