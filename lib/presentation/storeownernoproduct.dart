import 'package:flutter/material.dart';

class StoreOwnerNoProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/No data-cuate.png', width: 300),
            const SizedBox(height: 8),
            const Text('متجرك خالي من المنتجات لنقم بتعبئته معا', style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
               /* Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddStoreOwnerProduct()),
                );*/
              },
              child: const Text('إضافة منتج جديد'), // Change button text to Arabic
            ),
          ],
        ),
      ),
    );
  }
}