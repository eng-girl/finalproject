import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laticraftproject/presentation/storeownerside/storemain_layout.dart';

import '../bloc/cubit/auth_cubit.dart';
import '../bloc/state/auth_state.dart';
import 'cutomer_side/main_layout.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                } else if (state is AuthLoggedIn) {
                  // Navigate based on user role
                  if (state.user.role == 'customer') {
                    print("Navigating to MainLayout for customer");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MainLayout()),
                    );
                  } else if (state.user.role == 'store_owner') {
                    print("Navigating to Store screen for store owner");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => storemainlayout()),
                    );
                  }
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return CircularProgressIndicator();
                }
                return ElevatedButton(
                  onPressed: () {
                    print("Attempting to login");

                    context.read<AuthCubit>().login(emailController.text.trim(), passwordController.text.trim());
                  },
                  child: Text('Login'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
