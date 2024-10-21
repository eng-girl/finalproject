import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../data/models/order.dart';
import '../../../bloc/cubit/order_cubit.dart';
import '../core/theme/app_colors.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    // Fetch cached customer info
    final customer = context.read<OrderCubit>().getCustomer(order.customerId);

    // Define common TextStyle based on theme
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? AppColors.white
        : AppColors.black;

    Color statusColor;

    switch (order.status) {
      case 'قيد التنفيذ':
        statusColor = Colors.orange;
        break;
      case 'تم الإلغاء':
        statusColor = Colors.red;
        break;
      case 'تم التسليم':
        statusColor = Colors.green;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2, // Add elevation for shadow
      color: Theme.of(context).brightness == Brightness.dark
          ? AppColors.lightText
          : AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Aligns text to the left
                    children: [
                      Row(
                        children: [
                          Icon(Icons.circle, color: statusColor, size: 10),
                          SizedBox(width: 5),
                          Text(order.status, style: TextStyle(color: statusColor)),
                        ],
                      ),
                      Text(
                        'رقم الطلب: ${order.id}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: textColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text('المبلغ الإجمالي: ', style: TextStyle(color: textColor)),
                Text('${order.totalAmount}', style: TextStyle(color: textColor)),
                Text('دل  ', style: TextStyle(color: textColor)),
              ],
            ),
            SizedBox(height: 8),
            Text('عنوان الشحن: ${order.shippingAddress}', style: TextStyle(color: textColor)),
            SizedBox(height: 8),
            if (customer != null) ...[
              Text('اسم العميل: ${customer.name}', style: TextStyle(color: textColor)),
            ] else ...[
              const Text('جارٍ تحميل معلومات العميل...', style: TextStyle(color: Colors.grey)),
            ],
            const SizedBox(height: 10),
            const Text('المنتجات:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...order.products.map((product) {
              return Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      product.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child; // Image is fully loaded
                        } else {
                          return Container(
                            width: 50,
                            height: 50,
                            child: Center(
                              child: LoadingAnimationWidget.staggeredDotsWave(
                                color: AppColors.primary,
                                size: 20,
                              ),
                            ),
                          );
                        }
                      },
                      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                        return Container(
                          width: 50,
                          height: 50,
                          child: Center(
                            child: Icon(Icons.error, color: Colors.red),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${product.product.name} (x${product.quantity})',
                            style: TextStyle(color: textColor),
                          ),
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('السعر ', style: TextStyle(color: textColor)),
                              Text('${order.totalAmount}', style: TextStyle(color: textColor)),
                              SizedBox(width: 4),
                              Text('دل', style: TextStyle(color: textColor)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}