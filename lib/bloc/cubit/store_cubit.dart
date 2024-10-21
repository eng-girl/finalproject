// store_cubit.dart
import 'package:bloc/bloc.dart';

import '../../data/repo/store_repository.dart';
import '../state/store_state.dart';


class StoreCubit extends Cubit<StoreState> {
  final StoreRepository storeRepository;

  StoreCubit(this.storeRepository) : super(StoreInitial());

  Future<void> fetchStore(String userId) async {
    emit(StoreLoading());
    try {
      final store = await storeRepository.getStoreByUserId(userId);
      if (store != null) {
        emit(StoreLoaded(store));
      } else {
        emit(StoreError('Failed to load store details.'));
      }
    } catch (e) {
      emit(StoreError('Error: $e'));
    }
  }
}