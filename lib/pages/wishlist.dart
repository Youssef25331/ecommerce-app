import 'package:college_ecommerce_app/constants/app_colors.dart';
import 'package:college_ecommerce_app/controllers/product_service.dart';
import 'package:college_ecommerce_app/models/product.dart';
import 'package:college_ecommerce_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class wishlistPage extends StatefulWidget {
  const wishlistPage({super.key});

  @override
  State<wishlistPage> createState() => _wishlistPageState();
}

class _wishlistPageState extends State<wishlistPage> {
  final _productservice = ProductService();
  List<Product?> prodcuts = [];

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List;
    final user = args[0] as User;
    final wishListMode = args[1] as bool;
    final emptyList = wishListMode ? user.wishlist.isEmpty : user.cart.isEmpty;

    return Scaffold(
      appBar: wishlistAppBar(wishListMode),
      body: Container(
        child:
            emptyList
                ? Center(
                  child: Text(
                    wishListMode
                        ? 'Your wishlist is empty'
                        : 'Your cart is empty',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                    ),
                  ),
                )
                : FutureBuilder<List<Product?>>(
                  future: Future.wait(
                    wishListMode
                        ? user.wishlist
                            .map((id) => _productservice.getProductById(id))
                            .toList()
                        : user.cart
                            .map((id) => _productservice.getProductById(id))
                            .toList(),
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          wishListMode
                              ? 'No products in wishlist'
                              : 'No products in cart',
                        ),
                      );
                    }

                    final products = snapshot.data!;
                    List<Widget> listItems = [];
                    for (var product in products) {
                      if (product != null) {
                        listItems.add(wishlistCard(product));
                      }
                    }

                    return wishlistScrollBody(listItems);
                  },
                ),
      ),
      bottomNavigationBar:
          wishListMode ? mainBottomBar() : Container(child: Text("")),
    );
  }

  SingleChildScrollView wishlistScrollBody(List<Widget> listItems) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
            child: Column(children: listItems),
          ),
        ],
      ),
    );
  }

  InkWell wishlistCard(Product product) {
    final args = ModalRoute.of(context)!.settings.arguments as List;
    final user = args[0] as User;
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: () {
        Navigator.pushNamed(context, '/details', arguments: [product, user]);
      },
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 8, bottom: 16),
        margin: EdgeInsets.only(bottom: 8, top: 8),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: AppColors.edges)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 150,
                  height: 112,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      bottomLeft: Radius.circular(4),
                    ),
                    child: Image.asset(product.imagePath, fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        product.price,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),

                      SizedBox(height: 4),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/Light_Pin.svg',
                            width: 10,
                          ),
                          SizedBox(width: 4),
                          Text(
                            product.sellerLocation,

                            style: TextStyle(
                              fontSize: 10,

                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            'Sold by: ',
                            style: TextStyle(
                              fontSize: 12,

                              fontWeight: FontWeight.bold,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            product.seller,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,

                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  AppBar wishlistAppBar(bool wishListMode) {
    return AppBar(
      leading:
          !wishListMode
              ? InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/icons/Light_Arrow_Left.svg',
                    height: 24,
                    color: AppColors.textSecondary,
                  ),
                ),
              )
              : AppBar(),
      title: Row(
        children: [
          SizedBox(width: wishListMode ? 100 : 112),
          Text(
            wishListMode ? 'Wishlist' : "Cart",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class mainBottomBar extends StatelessWidget {
  const mainBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List;
    final user = args[0] as User;
    return Container(
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.edges),
        color: AppColors.background,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home', arguments: user);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/Light_Home.svg',
                  color: AppColors.secondary,
                  width: 32.0,
                  height: 32.0,
                ),
                Text(
                  'Home',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/Light_Heart.svg',
                color: AppColors.primary,
                width: 32.0,
                height: 32.0,
              ),
              Text(
                'Wishlist',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/Light_Container.svg',
                  color: AppColors.secondary,
                  width: 32.0,
                  height: 32.0,
                ),
                Text(
                  'Sell',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/bots', arguments: user);
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/Light_Bot.svg',
                  color: AppColors.secondary,
                  width: 32.0,
                  height: 32.0,
                ),
                Text(
                  'Bots',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
