import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../widgets/custom_tab_bar.dart';

import '../../../bloc/cubit/auth_cubit.dart';
import '../../../bloc/cubit/order_cubit.dart';
import '../../../bloc/state/order_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/order.dart';
import '../../../widgets/order_card.dart';

class OrderInfo extends StatefulWidget {
  const OrderInfo({super.key});

  @override
  _OrderInfoState createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
  int _selectedTabIndex = 0;

  Future<void> _refreshOrders(BuildContext context) async {
    final user = BlocProvider.of<AuthCubit>(context).currentUser;
    if (user != null) {
      context.read<OrderCubit>().fetchOrdersByUserId(user.id);
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<AuthCubit>(context).currentUser;

    if (user != null) {
      context.read<OrderCubit>().fetchOrdersByUserId(user.id);
    }

    return Scaffold(
      body: Column(
        children: [
          // Removed AppBar, added a Container for title
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: const Text(
              'قائمة الطلبات',
              style: TextStyle(
                fontFamily: 'Cairo', // Custom font for title
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center, // Center the title
            ),
          ),
          CustomTabBar(
            tabTitles: ['الكل', 'قيد الانتظار', 'قيد التنفيذ', 'تم التسليم'],
            selectedIndex: _selectedTabIndex,
            onTabTapped: _onTabTapped,
          ),
          Expanded(
            child: BlocConsumer<OrderCubit, OrderState>(
              listener: (context, orderState) {
                if (orderState is OrderError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(orderState.message)),
                  );
                }
              },
              builder: (context, orderState) {
                if (orderState is OrderLoading) {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: AppColors.primary,
                      size: 30,
                    ),
                  );
                } else if (orderState is OrderLoaded) {
                  final List<Order> orders = orderState.orderList;
                  final filteredOrders = _filterOrders(orders);

                  return RefreshIndicator(
                    onRefresh: () => _refreshOrders(context),
                    color: AppColors.primary,
                    backgroundColor: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.lightText
                        : AppColors.white,
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: filteredOrders.length,
                      itemBuilder: (context, index) {
                        final order = filteredOrders[index];
                        return OrderCard(order: order);
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10);
                      },
                    ),
                  );
                }

                return const Center(child: Text('لا توجد طلبات.'));
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Order> _filterOrders(List<Order> orders) {
    switch (_selectedTabIndex) {
      case 0:
        return orders;
      case 1:
        return orders.where((order) => order.status == 'قيد الانتظار').toList();
      case 2:
        return orders.where((order) => order.status == 'قيد التنفيذ').toList();
      case 3:
        return orders.where((order) => order.status == 'تم التسليم').toList();
      default:
        return orders;
    }
  }
}