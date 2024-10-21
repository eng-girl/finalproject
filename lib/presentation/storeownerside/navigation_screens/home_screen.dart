import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../bloc/cubit/auth_cubit.dart';
import '../../../bloc/cubit/store_cubit.dart';
import '../../../bloc/state/store_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/store_model.dart';
import '../../../widgets/transaction_item.dart';
import '../store_setting.dart'; // Import TransactionItem from widgets

class StorInfo extends StatelessWidget {
  const StorInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<AuthCubit>(context).currentUser;

    // Fetch store details when the widget builds and user is not null
    if (user != null) {
      context.read<StoreCubit>().fetchStore(user.id);
    }

    return Directionality(
      textDirection: TextDirection.rtl, // RTL layout
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                /*IconButton(
                icon: Icon(Icons.edit,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.white
                        : AppColors.black),*/
                IconButton(
                  icon:  Icon(
                    Iconsax.setting_2, // Use Iconsax icon
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.white
                        : AppColors.black, // Icon color set to black
                  ),
                onPressed: () {
                  final store = context.read<StoreCubit>().state is StoreLoaded
                      ? (context.read<StoreCubit>().state as StoreLoaded).store
                      : null;
                  if (store != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(store: store),
                      ),
                    );
                  }
                },
              ),

                Spacer(),
                Icon(
                  Icons.notifications,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.white
                      : AppColors.black,
                ),
              ],
            ),
          ),
        ),
        body: BlocConsumer<StoreCubit, StoreState>(
          listener: (context, storeState) {
            if (storeState is StoreError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(storeState.message)),
              );
            }
          },
          builder: (context, storeState) {
            if (storeState is StoreLoading) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: AppColors.primary,
                  size: 30,
                ),
              );
            } else if (storeState is StoreLoaded) {
              final Store store = storeState.store;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 250,
                    child: Image.network(
                      store.image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: LoadingAnimationWidget.staggeredDotsWave(
                                color: AppColors.primary,
                                size: 30,
                              ),
                            ),
                          );
                        }
                      },
                      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                        return Center(
                          child: Icon(Icons.error, color: AppColors.red),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    store.name,
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.white
                          : AppColors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "الاحصائيات",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        TransactionItem(
                          icon: Icons.credit_card,
                          label: "منتجات",
                          amount: "25",
                          color: Colors.grey,
                        ),
                        Divider(),
                        TransactionItem(
                          icon: Icons.attach_money,
                          label: "الأرباح",
                          amount: "\$3000",
                          color: Colors.green,
                        ),
                        Divider(),
                        TransactionItem(
                          icon: Icons.receipt,
                          label: "الطلبيات",
                          amount: "20",
                          color: Colors.orange,
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ],
              );
            }
            return Center(
              child: Text('لا توجد بيانات تحقق من الاتصال بالانترنت', style: TextStyle(fontSize: 18)),
            );
          },
        ),
      ),
    );
  }
}

