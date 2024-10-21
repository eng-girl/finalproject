import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:iconsax/iconsax.dart'; // Import Iconsax
import '../../core/theme/app_colors.dart';
import '../../data/models/storeowner_product.dart';

class ProductDetailScreen extends StatefulWidget {
  final StoreOwnerProduct product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  Color get textColor => Theme.of(context).brightness == Brightness.dark ? AppColors.white : AppColors.black;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _deleteProduct() {
    showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl, // Set text direction to RTL
        child: AlertDialog(
          title: Text(
            'تأكيد الحذف', // Confirm Delete
            style: TextStyle(color:Theme.of(context).brightness == Brightness.dark
                ? AppColors.white
                : AppColors.black,), // Change title text color
          ),
          content:  Text(
            'هل أنت متأكد أنك تريد حذف هذا المنتج؟', // Are you sure you want to delete this product?
            style: TextStyle(color:Theme.of(context).brightness == Brightness.dark
                ? AppColors.white
                : AppColors.black,), // Change content text color
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:  Text(
                'إلغاء', // Cancel
                style: TextStyle(color:AppColors.primary ), // Change cancel text color
              ),
            ),
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
                // Navigate to the confirmation screen or perform delete action
                /*Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ConfirmationScreen(), // Navigate to the confirmation screen
                  ),
                );*/
              },
              child: const Text(
                'حذف', // Delete
                style: TextStyle(color: Colors.red), // Change delete text color
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // RTL layout
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back button with product name
              Expanded(
                child: Text(
                  widget.product.name,
                  style: TextStyle(color: textColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // CircleAvatar with Iconsax icon
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Adds padding to the left
                child: CircleAvatar(
                  backgroundColor: AppColors.primary, // Set the background color to primary color
                  radius: 20, // Radius of the circle
                  child: IconButton(
                    icon: const Icon(
                      Iconsax.edit, // Use Iconsax icon
                      color: Colors.black, // Icon color set to black
                    ),
                    onPressed: () {
                      // Navigate to the new product screen
                      /*Navigator.push(
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
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image carousel for product images
                if (widget.product.images.isNotEmpty) ...[
                  SizedBox(
                    height: 300,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: widget.product.images.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Image.network(
                            widget.product.images[index],
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
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(child: Text('Image not available'));
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Dot indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.product.images.length,
                          (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        width: 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? AppColors.primary // Active dot color
                              : Colors.grey, // Inactive dot color
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Text(
                  'اسم المنتج: ${widget.product.name}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
                ),
                const SizedBox(height: 16),
                Text(
                  'السعر: ${widget.product.price} دل',
                  style: TextStyle(fontSize: 20, color: textColor),
                ),
                const SizedBox(height: 16),
                Text(
                  'الوصف: ${widget.product.description}',
                  style: TextStyle(fontSize: 18, color: textColor),
                ),
                const SizedBox(height: 8),
                Text(
                  'المادة: ${widget.product.material}',
                  style: TextStyle(fontSize: 18, color: textColor),
                ),
                const SizedBox(height: 8),
                Text(
                  'الفئة: ${widget.product.category}',
                  style: TextStyle(fontSize: 18, color: textColor),
                ),
                Text(
                  'المخزون: ${widget.product.stock}',
                  style: TextStyle(fontSize: 18, color: textColor),
                ),
                const SizedBox(height: 16),
                // Product colors section
                Text(
                  'الألوان المتاحة:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
                ),
                const SizedBox(height: 8),
                if (widget.product.colors.isNotEmpty) ...[
                  Row(
                    children: widget.product.colors.map((colorString) {
                      String colorHex = colorString.startsWith('#') ? colorString : '#$colorString';
                      Color color;

                      try {
                        color = Color(int.parse(colorHex.replaceAll('#', '0xff')));
                      } catch (e) {
                        color = Colors.grey; // Fallback color for invalid hex
                        print('Invalid color format: $colorString');
                      }

                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color,
                        ),
                      );
                    }).toList(),
                  ),
                ],
                const SizedBox(height: 35),
                // Full-width Delete button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _deleteProduct,
                    child: const Text('حذف المنتج'), // Delete Product
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Button color
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}