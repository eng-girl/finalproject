import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laticraftproject/presentation/cutomer_side/main_layout.dart';
import 'package:laticraftproject/presentation/login_screen.dart';
import 'package:laticraftproject/presentation/storeownerside/storemain_layout.dart';
import 'package:provider/provider.dart';
import 'bloc/cubit/auth_cubit.dart';
import 'bloc/cubit/bottom_nav_bar_cubit.dart';
import 'bloc/cubit/customer_cubit.dart';
import 'bloc/cubit/order_cubit.dart';
import 'bloc/cubit/store_cubit.dart';
import 'bloc/cubit/storeownerproduct_cubit.dart';
import 'bloc/state/auth_state.dart';
import 'core/network/dio_client.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';
import 'data/repo/auth_repo.dart';
import 'data/repo/customer_repo.dart';
import 'data/repo/order_repo.dart';
import 'data/repo/store_repository.dart';
import 'data/repo/storeownerproduct_repo.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        Provider<DioClient>(create: (_) => DioClient()),

        BlocProvider<BottomNavBarCubit>(
          create: (context) => BottomNavBarCubit(),
        ),
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(AuthRepository()),
        ),
        BlocProvider(
          create: (context) => StoreCubit(StoreRepository()),
        ),
        BlocProvider(
          create: (context) => StoreOwnerProductCubit(StoreOwnerProductRepository()),
        ),
        BlocProvider(
          create: (context) => OrderCubit(OrderRepository()),
        ),
        BlocProvider(
          create: (context) => CustomerCubit(CustomerRepository()),
        ),


        // add product to store owner
       /* BlocProvider(
          create: (context) => ProductRepository(ProductRepository()),
        ),*/





      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: const Locale('ar'),
            title: 'Craft It App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,

            home: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                // Check the authentication state
                if (authState is AuthLoading) {
                  print('loading');
                  return const Directionality(
                    textDirection: TextDirection.rtl,
                    child: Center(child: CircularProgressIndicator()),
                  ); // Show a loading indicator
                } else if (authState is AuthLoggedIn) {
                  return authState.user.role == 'customer'
                      ? const Directionality(
                      textDirection: TextDirection.rtl, child: MainLayout())
                      : const Directionality(
                      textDirection: TextDirection.rtl,
                      child:
                      storemainlayout()); // Replace with your actual home screen based on role
                } else {
                  print("login");
                  return Directionality(
                      textDirection: TextDirection.rtl,
                      child:
                      LoginScreen()); // Replace with your actual login screen
                }
              },
            ),

          );
        },
      ),
    );
  }
}
