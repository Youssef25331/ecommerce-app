import 'dart:io';

import 'package:college_ecommerce_app/constants/app_colors.dart';
import 'package:college_ecommerce_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:college_ecommerce_app/models/product.dart';
import 'package:college_ecommerce_app/controllers/product_service.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        title: AddressSelection(), // Replaced with interactive widget
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/wishlist',
                arguments: [user, false],
              );
            },
            child: Ink(
              child: SvgPicture.asset(
                'assets/icons/Light_Cart.svg',
                height: 28.0,
                width: 28.0,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          SizedBox(width: 20),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(65),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
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
                      height: 32,
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        style: TextStyle(fontSize: 14),
                        onSubmitted: (value) {
                          if (value.isNotEmpty) {
                            Navigator.pushNamed(
                              context,
                              '/search',
                              arguments: [value, user, false],
                            );
                          }
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
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            menuCarousel(),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Category', style: TextStyle(fontSize: 14)),
                  Padding(
                    padding: const EdgeInsets.only(top: 13),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4, right: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/search',
                                arguments: ['apparel', user, true],
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 223, 241, 255),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/icons/categories/Fashion.png',
                                      width: 32,
                                      height: 32,
                                    ),
                                  ),
                                ),
                                Text('Apparel', style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/search',
                                arguments: ['school', user, true],
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFDFFAFF),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/icons/categories/School.png',
                                      width: 32,
                                      height: 32,
                                    ),
                                  ),
                                ),
                                Text('School', style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/search',
                                arguments: ['sports', user, true],
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFEDDD),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/icons/categories/Sports.png',
                                      width: 32,
                                      height: 32,
                                    ),
                                  ),
                                ),
                                Text('Sports', style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/search',
                                arguments: ['electronics', user, true],
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFEEED),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/icons/categories/Electronics.png',
                                      width: 32,
                                      height: 32,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Electronics',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                      ) => CategorySelectionPage(user: user),
                                  transitionsBuilder: (
                                    context,
                                    animation,
                                    secondaryAnimation,
                                    child,
                                  ) {
                                    const begin = Offset(
                                      1.0,
                                      0.0,
                                    ); // Slide from right
                                    const end = Offset.zero;
                                    const curve = Curves.easeInOut;
                                    var tween = Tween(
                                      begin: begin,
                                      end: end,
                                    ).chain(CurveTween(curve: curve));
                                    var offsetAnimation = animation.drive(
                                      tween,
                                    );
                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE9FFF8),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/icons/categories/Category.svg',
                                      width: 32,
                                      height: 32,
                                    ),
                                  ),
                                ),
                                Text('All', style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            productsSlider(),
          ],
        ),
      ),
      bottomNavigationBar: mainMenuNav(),
    );
  }

  CarouselSlider menuCarousel() {
    return CarouselSlider(
      items: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 2),
                color: Colors.black.withAlpha(20),
                blurRadius: 5,
                spreadRadius: 0,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset('assets/images/Menu_Banner_1.png'),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 2),
                color: Colors.black.withAlpha(20),
                blurRadius: 5,
                spreadRadius: 0,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset('assets/images/Menu_Banner_2.png'),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 2),
                color: Colors.black.withAlpha(20),
                blurRadius: 5,
                spreadRadius: 0,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset('assets/images/Menu_Banner_4.png'),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 2),
                color: Colors.black.withAlpha(20),
                blurRadius: 5,
                spreadRadius: 0,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset('assets/images/Menu_Banner_3.png'),
          ),
        ),
      ],
      options: CarouselOptions(
        height: 150,
        enableInfiniteScroll: true,
        viewportFraction: 0.85,
        autoPlay: true,
        initialPage: 0,
        padEnds: true,
      ),
    );
  }
}

// Address Selection Widget
class AddressSelection extends StatefulWidget {
  const AddressSelection({super.key});

  @override
  State<AddressSelection> createState() => _AddressSelectionState();
}

class _AddressSelectionState extends State<AddressSelection> {
  String _selectedCity = 'Alexandria, Egypt';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Delivery Address',
          style: TextStyle(color: const Color(0xFFC8C8CB), fontSize: 10),
        ),
        FittedBox(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder:
                      (context, animation, secondaryAnimation) =>
                          CitySelectionPage(
                            onCitySelected: (city) {
                              setState(() {
                                _selectedCity = city;
                              });
                            },
                          ),
                  transitionsBuilder: (
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ) {
                    const begin = Offset(1.0, 0.0); // Slide from right
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;
                    var tween = Tween(
                      begin: begin,
                      end: end,
                    ).chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
              );
            },
            child: Row(
              children: [
                Text(
                  _selectedCity,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 4),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: SvgPicture.asset(
                    'assets/icons/Light_Drop_Down_Arrow.svg',
                    color: AppColors.textSecondary,
                    height: 12.0,
                    width: 12.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CitySelectionPage extends StatefulWidget {
  final Function(String) onCitySelected;

  const CitySelectionPage({super.key, required this.onCitySelected});

  @override
  State<CitySelectionPage> createState() => _CitySelectionPageState();
}

class _CitySelectionPageState extends State<CitySelectionPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _allCities = [
    'Alexandria, Egypt',
    'Cairo, Egypt',
    'Giza, Egypt',
    'Luxor, Egypt',
    'Aswan, Egypt',
    'Hurghada, Egypt',
    'Sharm El Sheikh, Egypt',
    'Mansoura, Egypt',
    'Tanta, Egypt',
    'Port Said, Egypt',
    'Suez, Egypt',
    'Ismailia, Egypt',
    'Fayoum, Egypt',
    'Minya, Egypt',
    'Assiut, Egypt',
  ];
  List<String> _filteredCities = [];

  @override
  void initState() {
    super.initState();
    _filteredCities = _allCities;
    _searchController.addListener(_filterCities);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCities() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCities =
          _allCities
              .where((city) => city.toLowerCase().contains(query))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select City',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textSecondary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for a city',
                prefixIcon: SvgPicture.asset(
                  'assets/icons/Light_Search.svg',
                  color: AppColors.secondary,
                ),
                contentPadding: EdgeInsets.all(12),
                prefixIconConstraints: BoxConstraints(maxHeight: 24),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: AppColors.thickEdges),
                ),
              ),
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredCities.length,
              itemBuilder: (context, index) {
                final city = _filteredCities[index];
                return ListTile(
                  title: Text(
                    city,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  onTap: () {
                    widget.onCitySelected(city);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class mainMenuNav extends StatelessWidget {
  const mainMenuNav({super.key});

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;
    return Container(
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.edges),
        color: AppColors.background,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/Full_Home.svg',
                width: 32.0,
                color: AppColors.primary,
                height: 32.0,
              ),
              Text(
                'Home',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(
                context,
                '/wishlist',
                arguments: [user, true],
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/Light_Heart.svg',
                  color: AppColors.secondary,
                  width: 32.0,
                  height: 32.0,
                ),
                Text(
                  'Wishlist',
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
              Navigator.pushReplacementNamed(context, '/sell', arguments: user);
            },
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

class productsSlider extends StatefulWidget {
  const productsSlider({super.key});

  @override
  State<productsSlider> createState() => _productsSliderState();
}

class _productsSliderState extends State<productsSlider> {
  final ProductService _productService = ProductService();

  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final products = await _productService.readProducts();
    setState(() {
      _products = products;
      if (_products.isEmpty) {
        _productService.fillProducts();
        _loadProducts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;
    bool isItemInList(String item) {
      return user.wishlist.any((element) => element.contains(item));
    }

    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "New Products",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder:
                          (context, animation, secondaryAnimation) =>
                              CategorySelectionPage(user: user),
                      transitionsBuilder: (
                        context,
                        animation,
                        secondaryAnimation,
                        child,
                      ) {
                        const begin = Offset(1.0, 0.0); // Slide from right
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;
                        var tween = Tween(
                          begin: begin,
                          end: end,
                        ).chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);
                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: Ink(
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
              ),
            ],
          ),
          SizedBox(height: 13),
          GridView.builder(
            reverse: false,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              mainAxisExtent: 234,
            ),
            shrinkWrap: true,
            itemCount: _products.length,
            itemBuilder: (_, index) {
              bool _inWishlist = isItemInList(_products[index].id);
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/details',
                    arguments: [_products[index], user],
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
                      Container(
                        width: double.infinity,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child:
                              _products[index].imagePath.split('/')[0] ==
                                      "assets"
                                  ? Image.asset(
                                    _products[index].imagePath,
                                    fit: BoxFit.cover,
                                  )
                                  : Image.file(
                                    File(_products[index].imagePath),
                                    fit: BoxFit.cover,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 13, top: 13),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _products[index].name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'arial',
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Text(
                              _products[index].price,
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
                                        ? user.wishlist.remove(
                                          _products[index].id,
                                        )
                                        : user.wishlist.add(
                                          _products[index].id,
                                        );
                                    setState(() {
                                      _inWishlist = !_inWishlist;
                                    });
                                  },
                                  child: Ink(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: _inWishlist ? 41 : 22,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          _inWishlist
                                              ? AppColors.secondary
                                              : AppColors.primary,
                                      borderRadius: BorderRadius.circular(4),
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
          ),
        ],
      ),
    );
  }
}

class CategorySelectionPage extends StatelessWidget {
  final User user;

  const CategorySelectionPage({super.key, required this.user});

  final List<String> _allCategories = const [
    'Apparel',
    'School',
    'Sports',
    'Electronics',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Category',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textSecondary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        itemCount: _allCategories.length,
        itemBuilder: (context, index) {
          final category = _allCategories[index];
          return ListTile(
            title: Text(
              category,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
            onTap: () {
              Navigator.pop(context); // Close the selection page
              Navigator.pushNamed(
                context,
                '/search',
                arguments: [category.toLowerCase(), user, true],
              );
            },
          );
        },
      ),
    );
  }
}
