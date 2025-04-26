import 'dart:io';

import 'package:college_ecommerce_app/constants/app_colors.dart';
import 'package:college_ecommerce_app/controllers/product_service.dart';
import 'package:college_ecommerce_app/models/product.dart';
import 'package:college_ecommerce_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class searchPage extends StatelessWidget {
  const searchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SingleChildScrollView(child: ProductsSlider()),
    );
  }

  AppBar appBar(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List;
    final user = args[1] as User;

    return AppBar(
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        borderRadius: BorderRadius.circular(30),
        child: Container(
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/icons/Light_Arrow_Left.svg',
            width: 24,
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [searchBar(context)],
      ),
      actions: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/wishlist', arguments: [user, false]);
          },
          child: Container(
            padding: const EdgeInsets.only(right: 20),
            child: SvgPicture.asset(
              'assets/icons/Light_Cart.svg',

              color: AppColors.textSecondary,
              height: 28.0,
              width: 28.0,
            ),
          ),
        ),
      ],
    );
  }

  Container searchBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: AppColors.edges),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/Light_Search.svg',
            height: 20.0,
            width: 20.0,
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 150,
            height: 22,
            child: TextField(
              style: TextStyle(fontSize: 14),
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                Navigator.pushReplacementNamed(
                  context,
                  '/search',
                  arguments: value,
                );
              },
              decoration: InputDecoration(
                hintText: 'Search here...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 6),
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductsSlider extends StatefulWidget {
  const ProductsSlider({super.key});

  @override
  State<ProductsSlider> createState() => _ProductsSliderState();
}

class _ProductsSliderState extends State<ProductsSlider> {
  final ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List;
    final query = args[0] as String;
    final user = args[1] as User;
    final isCategory = args[2] as bool;

    bool isItemInList(String item) {
      return user.wishlist.any((element) => element.contains(item));
    }

    Future<List<Product>> _filterProductsByQuery(String query) async {
      final products = await _productService.readProducts();
      final filteredProducts = <Product>[];

      for (var product in products) {
        if (!isCategory) {
          if (product.name.toLowerCase().contains(query.toLowerCase())) {
            filteredProducts.add(product);
          }
        }
        if (isCategory) {
          if (product.category.toLowerCase().contains(query.toLowerCase())) {
            filteredProducts.add(product);
          }
        }
      }

      return filteredProducts;
    }

    String _formatQuery(String query) {
      if (query.length <= 10) {
        return query;
      }
      return '${query.substring(0, 10)}...';
    }

    return Padding(
      padding: const EdgeInsets.only(top: 13, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isCategory
                    ? "Items in $query category"
                    : "Search result for \"${_formatQuery(query)}\"",
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.edges),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Filters",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(width: 14),
                      SvgPicture.asset(
                        'assets/icons/Light_Filter.svg',
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 13),
          FutureBuilder<List<Product>>(
            future: _filterProductsByQuery(query),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No products found'));
              }

              final products = snapshot.data!;
              return GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  mainAxisExtent: 234,
                ),
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (_, index) {
                  final product = products[index];
                  bool _inWishlist = isItemInList(product.id);

                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/details',
                        arguments: [product, user],
                      );
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 2),
                            color: Colors.black.withAlpha(20),
                            blurRadius: 1,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child:
                                product.imagePath.split('/')[0] == "assets"
                                    ? Image.asset(
                                      product.imagePath,
                                      fit: BoxFit.cover,
                                      height: 120,
                                      width: double.infinity,
                                      errorBuilder:
                                          (
                                            context,

                                            error,
                                            stackTrace,
                                          ) => Image.asset(
                                            'assets/images/Monitor_Item.png',
                                            fit: BoxFit.cover,
                                            height: 120,
                                            width: double.infinity,
                                          ),
                                    )
                                    : Image.file(
                                      File(product.imagePath),
                                      fit: BoxFit.cover,

                                      height: 120,
                                      width: double.infinity,
                                      errorBuilder:
                                          (
                                            context,
                                            error,
                                            stackTrace,
                                          ) => Image.asset(
                                            'assets/images/Monitor_Item.png',
                                            fit: BoxFit.cover,
                                            height: 120,
                                            width: double.infinity,
                                          ),
                                    ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 13, top: 13),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                Text(
                                  product.price,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,

                                    color: AppColors.textSecondary,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Row(
                                  children: [
                                    SizedBox(width: 7.5),
                                    InkWell(
                                      onTap: () {
                                        _inWishlist
                                            ? user.wishlist.remove(product.id)
                                            : user.wishlist.add(product.id);
                                        setState(() {
                                          _inWishlist = !_inWishlist;
                                        });
                                      },
                                      child: Ink(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: _inWishlist ? 46 : 27,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              _inWishlist
                                                  ? AppColors.secondary
                                                  : AppColors.primary,
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child: Text(
                                          _inWishlist
                                              ? 'Remove'
                                              : 'Add to wishlist',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
