import 'dart:io';

import 'package:college_ecommerce_app/constants/app_colors.dart';
import 'package:college_ecommerce_app/models/product.dart';
import 'package:college_ecommerce_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class detailsPage extends StatefulWidget {
  const detailsPage({super.key});

  @override
  State<detailsPage> createState() => _detailsPageState();
}

class _detailsPageState extends State<detailsPage> {
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as List;
    final product = arg[0] as Product;

    final user = arg[1] as User;
    bool inWishlist = false;
    bool inCart = false;

    void isItemInList() {
      final itemId = product.id;
      setState(() {
        inWishlist = user.wishlist.any((element) => element.contains(itemId));
      });
    }

    void isItemInCart() {
      final itemId = product.id;
      setState(() {
        inCart = user.cart.any((element) => element.contains(itemId));
      });
    }

    isItemInList();
    isItemInCart();

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/icons/Light_Arrow_Left.svg',
              width: 24,
            ),
          ),
        ),
        title: Row(
          children: [
            SizedBox(width: 72),
            Text(
              'Product Details',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavBar(
        inWishlist,
        inCart,
        user,
        product,
        isItemInList,
        isItemInCart,
      ),

      body: scrollableBody(product, inWishlist, user, isItemInList),
    );
  }

  SingleChildScrollView scrollableBody(
    Product product,
    bool inWishlist,
    User user,
    void Function() isItemInList,
  ) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child:
                  product.imagePath.split('/')[0] == "assets"
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
                              style: TextStyle(
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
                              SizedBox(width: 8),
                              Text(
                                product.sellerLocation,
                                style: TextStyle(
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
                        onTap: () {
                          setState(() {
                            if (inWishlist) {
                              user.wishlist.remove(product.id);

                              isItemInList();
                            } else {
                              user.wishlist.add(product.id);

                              isItemInList();
                            }
                          });
                        },
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
                            color:
                                inWishlist
                                    ? AppColors.primary
                                    : AppColors.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 1.0,
                          color: Colors.black.withAlpha(40),
                        ),
                        bottom: BorderSide(
                          width: 1.0,
                          color: Colors.black.withAlpha(40),
                        ),
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

                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Seller',

                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              product.seller,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16),
                  Text(
                    'Description',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    product.details,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container bottomNavBar(
    bool inWishlist,
    bool inCart,
    User user,
    Product product,
    void Function() isItemInList,
    void Function() isItemInCart,
  ) {
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
            onTap:
                () => {
                  setState(() {
                    if (inWishlist) {
                      user.wishlist.remove(product.id);

                      isItemInCart();
                    } else {
                      user.wishlist.add(product.id);

                      isItemInCart();
                    }
                  }),
                },
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
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          SizedBox(width: 14),
          InkWell(
            onTap: () {
              if (inCart) {
                user.cart.remove(product.id);
                isItemInCart();
                print('remove');
              } else {
                user.cart.add(product.id);
                isItemInCart();
                print('add');
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: inCart ? 60 : 54,
                vertical: 13,
              ),
              decoration: BoxDecoration(
                color: inCart ? AppColors.secondary : Color(0xfff0f2f1),

                border: Border.all(width: 1, color: Color(0xffD9D9D9)),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                inCart ? 'In Cart' : 'Buy Now',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color:
                      inCart ? AppColors.textPrimary : AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView detailsBody(Product product) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: Image.asset(product.imagePath, fit: BoxFit.cover),
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
                              style: TextStyle(
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
                              color: Colors.green,
                            ),
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/Light_Pin.svg',

                                color: AppColors.textSecondary,
                                width: 12,
                              ),
                              SizedBox(width: 8),
                              Text(
                                product.sellerLocation,
                                style: TextStyle(
                                  fontSize: 14,

                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset('assets/icons/Light_Heart.svg'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 1.0,
                          color: Colors.black.withAlpha(40),
                        ),
                        bottom: BorderSide(
                          width: 1.0,
                          color: Colors.black.withAlpha(40),
                        ),
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

                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Seller',

                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              product.seller,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textSecondary,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16),
                  Text(
                    'Description',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    product.details,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
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

class detailsBar extends StatelessWidget {
  const detailsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Container(
        alignment: Alignment.center,
        child: SvgPicture.asset(
          'assets/icons/Light_Arrow_Left.svg',
          width: 24,
          color: AppColors.textSecondary,
        ),
      ),
      title: Row(
        children: [
          SizedBox(width: 72),
          Text(
            'Product Details',

            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
