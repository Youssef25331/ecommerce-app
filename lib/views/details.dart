import 'dart:io';
import 'package:college_ecommerce_app/constants/app_colors.dart';
import 'package:college_ecommerce_app/models/product.dart';
import 'package:college_ecommerce_app/viewmodels/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    final userViewModel = Provider.of<UserViewModel>(context);
    final inWishlist = userViewModel.isItemInWishlist(product.id);
    final inCart = userViewModel.isItemInCart(product.id);

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () => Navigator.pop(context),
          child: Container(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/icons/Light_Arrow_Left.svg',
              width: 24,
            ),
          ),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Product Details',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        inWishlist: inWishlist,
        inCart: inCart,
        product: product,
        onToggleWishlist: () => userViewModel.toggleWishlistItem(product.id),
        onToggleCart: () => userViewModel.toggleCartItem(product.id),
      ),
      body: ScrollableBody(
        product: product,
        inWishlist: inWishlist,
        onToggleWishlist: () => userViewModel.toggleWishlistItem(product.id),
      ),
    );
  }
}

class ScrollableBody extends StatelessWidget {
  final Product product;
  final bool inWishlist;
  final VoidCallback onToggleWishlist;

  const ScrollableBody({
    super.key,
    required this.product,
    required this.inWishlist,
    required this.onToggleWishlist,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: product.imagePath.split('/')[0] == "assets"
                  ? Image.asset(product.imagePath, fit: BoxFit.cover)
                  : Image.file(File(product.imagePath), fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 280,
                            child: Text(
                              product.name,
                              maxLines: 1,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            product.price,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/Light_Pin.svg',
                                width: 12,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                product.sellerLocation,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: onToggleWishlist,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            'assets/icons/Light_Heart.svg',
                            color: inWishlist ? AppColors.primary : AppColors.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 1.0, color: Colors.black.withAlpha(40)),
                        bottom: BorderSide(width: 1.0, color: Colors.black.withAlpha(40)),
                      ),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            product.sellerProfile,
                            fit: BoxFit.cover,
                            width: 56,
                            height: 56,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Seller',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              product.seller,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Description',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.details,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  final bool inWishlist;
  final bool inCart;
  final Product product;
  final VoidCallback onToggleWishlist;
  final VoidCallback onToggleCart;

  const BottomNavBar({
    super.key,
    required this.inWishlist,
    required this.inCart,
    required this.product,
    required this.onToggleWishlist,
    required this.onToggleCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.edges),
        color: Colors.white,
      ),
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: onToggleWishlist,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: inWishlist ? 55 : 32,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: inWishlist ? AppColors.secondary : AppColors.primary,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                inWishlist ? 'Remove' : 'Add to wishlist',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          InkWell(
            onTap: onToggleCart,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: inCart ? 60 : 54,
                vertical: 13,
              ),
              decoration: BoxDecoration(
                color: inCart ? AppColors.secondary : const Color(0xfff0f2f1),
                border: Border.all(width: 1, color: const Color(0xffD9D9D9)),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                inCart ? 'In Cart' : 'Buy Now',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: inCart ? AppColors.textPrimary : AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
