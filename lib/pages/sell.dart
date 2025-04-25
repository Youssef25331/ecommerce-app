import 'dart:io';
import 'package:college_ecommerce_app/constants/app_colors.dart';
import 'package:college_ecommerce_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class sellPage extends StatefulWidget {
  const sellPage({super.key});

  @override
  State<sellPage> createState() => _sellPageState();
}

class _sellPageState extends State<sellPage> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Failed to pick image: ')));
        });
      }
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to pick image: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                _pickImage();
              },

              child: Text(
                'Sell Product',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Category'),
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              image: DecorationImage(
                image:
                    _selectedImage != null
                        ? FileImage(_selectedImage!)
                        : const AssetImage("assets/images/Menu_Banner_1.png")
                            as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text('Price'),
          Text('Details'),
        ],
      ),
      bottomNavigationBar: sellPageNav(),
    );
  }
}

class sellPageNav extends StatelessWidget {
  const sellPageNav({super.key});

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;
    return Container(
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(width: 1),
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
                  'assets/icons/Full_Home.svg',
                  width: 32.0,
                  height: 32.0,
                ),
                Text(
                  'Home',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
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
                  color: Colors.black,
                  width: 32.0,
                  height: 32.0,
                ),
                Text(
                  'Wishlist',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(
                context,
                '/sell',
                arguments: [user, true],
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/Light_Container.svg',
                  color: Colors.black,
                  width: 32.0,
                  height: 32.0,
                ),
                Text(
                  'Sell',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
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
                  color: Colors.black,
                  width: 32.0,
                  height: 32.0,
                ),
                Text(
                  'Bots',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
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
