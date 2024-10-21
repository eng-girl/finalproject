import 'package:bloc/bloc.dart';
import '../../data/models/order.dart';
import '../../data/repo/order_repo.dart';
import '../state/order_state.dart';
import '../../data/repo/customer_repo.dart';
import '../../data/models/customer.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository orderRepository;
  final Map<String, Customer?> customerCache = {}; // Cache for customer data

  OrderCubit(this.orderRepository) : super(OrderInitial());

  Future<void> fetchOrdersByUserId(String userId) async {
    emit(OrderLoading());
    try {
      final List<Order> orders = await orderRepository.getOrdersByUserId(userId);
      if (orders.isNotEmpty) {
        // Fetch customer data for each order
        for (var order in orders) {
          final customer = await CustomerRepository().getCustomerById(order.customerId);
          customerCache[order.customerId] = customer; // Cache the customer info
        }
        emit(OrderLoaded(orders));
      } else {
        emit(OrderError('No orders available.'));
      }
    } catch (e) {
      emit(OrderError('Error: $e'));
    }
  }

  Customer? getCustomer(String customerId) {
    return customerCache[customerId]; // Retrieve cached customer info
  }

}


