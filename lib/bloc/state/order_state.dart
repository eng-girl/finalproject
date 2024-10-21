import '../../data/models/order.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<Order> orderList;

  OrderLoaded(this.orderList);
}

class OrderError extends OrderState {
  final String message;

  OrderError(this.message);
}