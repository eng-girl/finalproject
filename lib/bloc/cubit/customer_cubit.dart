import 'package:bloc/bloc.dart';
import '../../data/models/customer.dart';
import '../../data/repo/customer_repo.dart';
import '../state/customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  final CustomerRepository customerRepository;

  CustomerCubit(this.customerRepository) : super(CustomerInitial());

  Future<void> fetchCustomerById(String customerId) async {
    emit(CustomerLoading());
    try {
      final Customer? customer = await customerRepository.getCustomerById(customerId);
      if (customer != null) {
        emit(CustomerLoaded(customer));
      } else {
        emit(CustomerError('Customer not found.'));
      }
    } catch (e) {
      emit(CustomerError('Error: $e'));
    }
  }
}
