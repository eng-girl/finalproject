/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/cubit/auth_cubit.dart';
import '../../../bloc/cubit/storeownerproduct_cubit.dart';
import '../../../bloc/state/storeownerproduct_state.dart';
import '../../../data/models/storeowner_product.dart';
import '../../storeownernoproduct.dart';
import '../ProductDetailScreen.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<AuthCubit>(context).currentUser;

    // Fetch product details when the widget builds and user is not null
    if (user != null) {
      context.read<StoreOwnerProductCubit>().fetchProductByStoreOwner(user.id);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: BlocConsumer<StoreOwnerProductCubit, StoreOwnerProductState>(
        listener: (context, productState) {
          if (productState is ProductError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(productState.message)),
            );
          }
        },
        builder: (context, productState) {
          if (productState is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (productState is ProductLoaded) {
            final List<StoreOwnerProduct> products = productState.productList;

            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final StoreOwnerProduct product = products[index];
                return ListTile(
                  leading: product.thumbnail != null
                      ? Image.network(
                    product.thumbnail!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image_not_supported);
                    },
                  )
                      : const Icon(Icons.image_not_supported),
                  title: Text(product.name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(product: product),
                      ),
                    );
                  },
                );
              },
            );
          } else if (productState is ProductError) {
            // Display the no product screen if the error message indicates no products
            return StoreOwnerNoProduct();
          }
          // If no product data available, show the no product screen
          return StoreOwnerNoProduct();
        },
      ),
    );
  }
}*/



// with design

/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/cubit/auth_cubit.dart';
import '../../../bloc/cubit/storeownerproduct_cubit.dart';
import '../../../bloc/state/storeownerproduct_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/storeowner_product.dart';
import '../../storeownernoproduct.dart';
import '../ProductDetailScreen.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<AuthCubit>(context).currentUser;

    // Fetch product details when the widget builds and user is not null
    if (user != null) {
      context.read<StoreOwnerProductCubit>().fetchProductByStoreOwner(user.id);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'منتجاتي ',
          style: TextStyle(
            fontFamily: 'Cairo', // Custom font for AppBar title
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Search functionality can be implemented here
            },
          ),
        ],
      ),
      body: BlocConsumer<StoreOwnerProductCubit, StoreOwnerProductState>(
        listener: (context, productState) {
          if (productState is ProductError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(productState.message)),
            );
          }
        },
        builder: (context, productState) {
          if (productState is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (productState is ProductLoaded) {
            final List<StoreOwnerProduct> products = productState.productList;

            return ListView.builder(
              itemCount: products.length,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16), // Adds padding around the list
              itemBuilder: (context, index) {
                final StoreOwnerProduct product = products[index];
                return Card(
                  color: Theme.of(context).brightness ==
                      Brightness.dark
                      ? AppColors.black
                      : AppColors.white,  // Add the color property to the Card

                  elevation: 1, // Elevates the product item for better visibility
                  margin: const EdgeInsets.symmetric(vertical: 8), // Spacing between items
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10), // Adds padding inside the ListTile
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10), // Adds rounded corners to the image
                      child: product.thumbnail != null
                          ? Image.network(
                        product.thumbnail!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.image_not_supported);
                        },
                      )
                          : const Icon(Icons.image_not_supported),
                    ),
                    title: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      product.description ?? 'No description available',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios), // Trailing arrow icon
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(product: product),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (productState is ProductError) {
            // Display the no product screen if the error message indicates no products
            return StoreOwnerNoProduct();
          }
          // If no product data available, show the no product screen
          return StoreOwnerNoProduct();
        },
      ),
    );
  }
}*/


// with flutter pub add flutter_spinkit
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../bloc/cubit/auth_cubit.dart';
import '../../../bloc/cubit/storeownerproduct_cubit.dart';
import '../../../bloc/state/storeownerproduct_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/storeowner_product.dart';
import '../../storeownernoproduct.dart';
import '../ProductDetailScreen.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<AuthCubit>(context).currentUser;

    // Fetch product details when the widget builds and user is not null
    if (user != null) {
      context.read<StoreOwnerProductCubit>().fetchProductByStoreOwner(user.id);
    }

    Future<void> _refreshProducts() async {
      // Re-fetch product details
      if (user != null) {
        await context.read<StoreOwnerProductCubit>().fetchProductByStoreOwner(user.id);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'منتجاتي ',
          style: TextStyle(
            fontFamily: 'Cairo', // Custom font for AppBar title
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // Search icon button
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement the search functionality here
             /* showSearch(
                context: context,
                delegate: ProductSearchDelegate(), // You can define this search delegate
              );*/
            },
          ),
          // Circular button with "+" icon for adding products
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16), // Adds padding to the right
            child: CircleAvatar(
              backgroundColor: AppColors.primary, // Set the background color to primary color
              radius: 20, // Radius of the circle
              child: IconButton(
                icon: const Icon(
                  Icons.add, // "+" icon
                  color: Colors.black, // Icon color set to black
                ),
                onPressed: () {
                  // Navigate to the new product screen
                 /* Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewProductScreen(), // Replace with your target screen
                    ),
                  );*/
                },
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<StoreOwnerProductCubit, StoreOwnerProductState>(
        listener: (context, productState) {
          if (productState is ProductError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(productState.message)),
            );
          }
        },
        builder: (context, productState) {
          if (productState is ProductLoading) {
            return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: AppColors.primary, // Customize the spinner color
                size: 30,           // Customize the spinner size
              ),
            );
          } else if (productState is ProductLoaded) {
            final List<StoreOwnerProduct> products = productState.productList;

            return RefreshIndicator(
              onRefresh: _refreshProducts, // Calls the refresh method
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.lightText
                  : AppColors.white,    // Color of the refresh spinner
              backgroundColor: Colors.white,  // Background color of the refresh circle
              child: ListView.builder(
                itemCount: products.length,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16), // Adds padding around the list
                itemBuilder: (context, index) {
                  final StoreOwnerProduct product = products[index];
                  return Card(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.lightText
                        : AppColors.white, // Add the color property to the Card
                    elevation: 3, // Elevates the product item for better visibility
                    margin: const EdgeInsets.symmetric(vertical: 8), // Spacing between items
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10), // Adds padding inside the ListTile
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10), // Adds rounded corners to the image
                        child: product.thumbnail != null
                            ? Image.network(
                          product.thumbnail!,
                          width: 80,
                          height: 150,
                          fit: BoxFit.cover,
                          // Show custom loading spinner while the image is loading
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child; // Image is fully loaded
                            } else {
                              return Container(
                                width: 50,
                                height: 50,
                                child: Center(
                                  child: LoadingAnimationWidget.staggeredDotsWave(
                                    color: AppColors.primary, // Customize the spinner color
                                    size: 30,           // Customize the spinner size
                                  ),
                                ),
                              );
                            }
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.image_not_supported);
                          },
                        )
                            : const Icon(Icons.image_not_supported),
                      ),
                      title: Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        product.description ?? 'No description available',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios), // Trailing arrow icon
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(product: product),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          } else if (productState is ProductError) {
            // Display the no product screen if the error message indicates no products
            return StoreOwnerNoProduct();
          }
          // If no product data available, show the no product screen
          return StoreOwnerNoProduct();
        },
      ),
    );
  }
}





