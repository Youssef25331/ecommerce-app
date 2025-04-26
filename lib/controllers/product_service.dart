import 'dart:io';
import 'package:college_ecommerce_app/models/product.dart';
import 'package:path_provider/path_provider.dart';

class ProductService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/products.json');
  }

  Future<List<Product>> readProducts() async {
    try {
      final file = await _localFile;
      if (!await file.exists()) {
        return [];
      }
      final contents = await file.readAsString();
      return productsFromJson(contents);
    } catch (e) {
      print('Error reading products: $e');
      return [];
    }
  }

  Future<void> writeProducts(List<Product> products, File image) async {
    try {
      final file = await _localFile;
      final path = await _localPath;
      products[0].imagePath = "$path/${products[0].id}.png";
      final jsonString = productsToJson(products);
      await image.copy(products[0].imagePath);
      await file.writeAsString(jsonString);
    } catch (e) {
      print('Error writing products: $e');
    }
  }

  Future<void> clearProducts() async {
    try {
      final file = await _localFile;
      await file.writeAsString('[]');
      print('Cleared products.json');
    } catch (e) {
      print('Error clearing products: $e');
    }
  }

  Future<Product?> getProductById(String id) async {
    try {
      final products = await readProducts();
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      print('Error getting product by id: $e');
      return null;
    }
  }

  Future<void> fillProducts() async {
    try {
      final file = await _localFile;
      await file.writeAsString('''[
  {
    "id": "62cbef22-b1dc-462b-93f8-365423648f7c",
    "name": "Sports Jacket",
    "seller": "ActiveWear Co.",
    "price": "EGP 850",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    "imagePath": "assets/images/products/sports_1.png",
    "sellerProfile": "assets/images/profiles/profile_7.png",
    "sellerLocation": "Cairo, Egypt",
    "category": "sports"
  },
  {
    "id": "a1b2c3d4-5e6f-7a8b-9c0d-1e2f3a4b5c6d",
    "name": "Laptop Charger",
    "seller": "TechTrend",
    "price": "EGP 1200",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut enim ad minim veniam, quis nostrud exercitation ullamco.",
    "imagePath": "assets/images/products/electronics_3.png",
    "sellerProfile": "assets/images/profiles/profile_2.png",
    "sellerLocation": "Alexandria, Egypt",
    "category": "electronics"
  },
  {
    "id": "b2c3d4e5-6f7a-8b9c-0d1e-2f3a4b5c6d7e",
    "name": "School Backpack",
    "seller": "StudyBuddy",
    "price": "EGP 450",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis aute irure dolor in reprehenderit in voluptate velit.",
    "imagePath": "assets/images/products/school_4.png",
    "sellerProfile": "assets/images/profiles/profile_10.png",
    "sellerLocation": "Giza, Egypt",
    "category": "school"
  },
  {
    "id": "c3d4e5f6-7a8b-9c0d-1e2f-3a4b5c6d7e8f",
    "name": "Casual Shirt",
    "seller": "FashionHub",
    "price": "EGP 600",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Excepteur sint occaecat cupidatat non proident.",
    "imagePath": "assets/images/products/apparel_2.png",
    "sellerProfile": "assets/images/profiles/profile_5.png",
    "sellerLocation": "Mansoura, Egypt",
    "category": "apparel"
  },
  {
    "id": "d4e5f6a7-8b9c-0d1e-2f3a-4b5c6d7e8f9a",
    "name": "Running Shoes",
    "seller": "FitGear",
    "price": "EGP 950",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sunt in culpa qui officia deserunt mollit anim id est laborum.",
    "imagePath": "assets/images/products/sports_5.png",
    "sellerProfile": "assets/images/profiles/profile_12.png",
    "sellerLocation": "Luxor, Egypt",
    "category": "sports"
  },
  {
    "id": "e5f6a7b8-9c0d-1e2f-3a4b-5c6d7e8f9a0b",
    "name": "Wireless Earbuds",
    "seller": "GadgetZone",
    "price": "EGP 1800",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quis ipsum suspendisse ultrices gravida dictum fusce.",
    "imagePath": "assets/images/products/electronics_1.png",
    "sellerProfile": "assets/images/profiles/profile_3.png",
    "sellerLocation": "Asyut, Egypt",
    "category": "electronics"
  },
  {
    "id": "f6a7b8c9-0d1e-2f3a-4b5c-6d7e8f9a0b1c",
    "name": "Notebook Set",
    "seller": "LearnEasy",
    "price": "EGP 200",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Temporibus autem quibusdam et aut officiis debitis aut.",
    "imagePath": "assets/images/products/school_2.png",
    "sellerProfile": "assets/images/profiles/profile_8.png",
    "sellerLocation": "Suez, Egypt",
    "category": "school"
  },
  {
    "id": "a7b8c9d0-1e2f-3a4b-5c6d-7e8f9a0b1c2d",
    "name": "Denim Jeans",
    "seller": "StyleVibe",
    "price": "EGP 700",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Accusantium doloremque laudantium, totam rem aperiam.",
    "imagePath": "assets/images/products/apparel_4.png",
    "sellerProfile": "assets/images/profiles/profile_1.png",
    "sellerLocation": "Port Said, Egypt",
    "category": "apparel"
  },
  {
    "id": "b8c9d0e1-2f3a-4b5c-6d7e-8f9a0b1c2d3e",
    "name": "Soccer Ball",
    "seller": "SportyShop",
    "price": "EGP 400",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eaque ipsa quae ab illo inventore veritatis et quasi.",
    "imagePath": "assets/images/products/sports_3.png",
    "sellerProfile": "assets/images/profiles/profile_6.png",
    "sellerLocation": "Aswan, Egypt",
    "category": "sports"
  },
  {
    "id": "c9d0e1f2-3a4b-5c6d-7e8f-9a0b1c2d3e4f",
    "name": "USB Cable",
    "seller": "TechBit",
    "price": "EGP 150",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Neque porro quisquam est, qui dolorem ipsum quia dolor.",
    "imagePath": "assets/images/products/electronics_5.png",
    "sellerProfile": "assets/images/profiles/profile_9.png",
    "sellerLocation": "Ismailia, Egypt",
    "category": "electronics"
  },
  {
    "id": "d0e1f2a3-4b5c-6d7e-8f9a-0b1c2d3e4f5a",
    "name": "Track Pants",
    "seller": "AthleteZone",
    "price": "EGP 650",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut perspiciatis unde omnis iste natus error sit.",
    "imagePath": "assets/images/products/sports_2.png",
    "sellerProfile": "assets/images/profiles/profile_4.png",
    "sellerLocation": "Damietta, Egypt",
    "category": "sports"
  },
  {
    "id": "e1f2a3b4-5c6d-7e8f-9a0b-1c2d3e4f5a6b",
    "name": "Smartphone Case",
    "seller": "TechTrove",
    "price": "EGP 300",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nemo enim ipsam voluptatem quia voluptas sit aspernatur.",
    "imagePath": "assets/images/products/electronics_4.png",
    "sellerProfile": "assets/images/profiles/profile_11.png",
    "sellerLocation": "Fayoum, Egypt",
    "category": "electronics"
  },
  {
    "id": "f2a3b4c5-6d7e-8f9a-0b1c-2d3e4f5a6b7c",
    "name": "Pencil Case",
    "seller": "SchoolSmart",
    "price": "EGP 100",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. At vero eos et accusamus et iusto odio dignissimos.",
    "imagePath": "assets/images/products/school_3.png",
    "sellerProfile": "assets/images/profiles/profile_3.png",
    "sellerLocation": "Beni Suef, Egypt",
    "category": "school"
  },
  {
    "id": "a3b4c5d6-7e8f-9a0b-1c2d-3e4f5a6b7c8d",
    "name": "Hoodie",
    "seller": "TrendyWear",
    "price": "EGP 800",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam libero tempore, cum soluta nobis est eligendi.",
    "imagePath": "assets/images/products/apparel_1.png",
    "sellerProfile": "assets/images/profiles/profile_8.png",
    "sellerLocation": "Minya, Egypt",
    "category": "apparel"
  },
  {
    "id": "b4c5d6e7-8f9a-0b1c-2d3e-4f5a6b7c8d9e",
    "name": "Fitness Tracker",
    "seller": "SportTech",
    "price": "EGP 1500",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quia non numquam eius modi tempora incidunt ut labore.",
    "imagePath": "assets/images/products/sports_4.png",
    "sellerProfile": "assets/images/profiles/profile_1.png",
    "sellerLocation": "Sohag, Egypt",
    "category": "sports"
  },
  {
    "id": "c5d6e7f8-9a0b-1c2d-3e4f-5a6b7c8d9e0f",
    "name": "Power Bank",
    "seller": "GadgetHub",
    "price": "EGP 900",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Et harum quidem rerum facilis est et expedita distinctio.",
    "imagePath": "assets/images/products/electronics_2.png",
    "sellerProfile": "assets/images/profiles/profile_6.png",
    "sellerLocation": "Qena, Egypt",
    "category": "electronics"
  },
  {
    "id": "d6e7f8a9-0b1c-2d3e-4f5a-6b7c8d9e0f1a",
    "name": "Geometry Set",
    "seller": "EduTools",
    "price": "EGP 150",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Neque porro quisquam est, qui dolorem ipsum quia dolor.",
    "imagePath": "assets/images/products/school_1.png",
    "sellerProfile": "assets/images/profiles/profile_9.png",
    "sellerLocation": "Tanta, Egypt",
    "category": "school"
  },
  {
    "id": "e7f8a9b0-1c2d-3e4f-5a6b-7c8d9e0f1a2b",
    "name": "Sneakers",
    "seller": "FashionFit",
    "price": "EGP 1000",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut perspiciatis unde omnis iste natus error sit.",
    "imagePath": "assets/images/products/apparel_3.png",
    "sellerProfile": "assets/images/profiles/profile_4.png",
    "sellerLocation": "Zagazig, Egypt",
    "category": "apparel"
  },
  {
    "id": "f8a9b0c1-2d3e-4f5a-6b7c-8d9e0f1a2b3c",
    "name": "Yoga Mat",
    "seller": "FitLife",
    "price": "EGP 500",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. At vero eos et accusamus et iusto odio dignissimos.",
    "imagePath": "assets/images/products/sports_1.png",
    "sellerProfile": "assets/images/profiles/profile_12.png",
    "sellerLocation": "Kafr El Sheikh, Egypt",
    "category": "sports"
  },
  {
    "id": "a9b0c1d2-3e4f-5a6b-7c8d-9e0f1a2b3c4d",
    "name": "Headphones",
    "seller": "SoundWave",
    "price": "EGP 2000",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam libero tempore, cum soluta nobis est eligendi.",
    "imagePath": "assets/images/products/electronics_1.png",
    "sellerProfile": "assets/images/profiles/profile_7.png",
    "sellerLocation": "Damanhur, Egypt",
    "category": "electronics"
  },
  {
    "id": "b0c1d2e3-4f5a-6b7c-8d9e-0f1a2b3c4d5e",
    "name": "Art Supplies",
    "seller": "CreativeKids",
    "price": "EGP 250",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quia non numquam eius modi tempora incidunt ut labore.",
    "imagePath": "assets/images/products/school_5.png",
    "sellerProfile": "assets/images/profiles/profile_2.png",
    "sellerLocation": "Banha, Egypt",
    "category": "school"
  },
  {
    "id": "c1d2e3f4-5a6b-7c8d-9e0f-1a2b3c4d5e6f",
    "name": "T-Shirt",
    "seller": "CoolThreads",
    "price": "EGP 400",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Et harum quidem rerum facilis est et expedita distinctio.",
    "imagePath": "assets/images/products/apparel_5.png",
    "sellerProfile": "assets/images/profiles/profile_10.png",
    "sellerLocation": "Shibin El Kom, Egypt",
    "category": "apparel"
  },
  {
    "id": "d2e3f4a5-6b7c-8d9e-0f1a-2b3c4d5e6f7a",
    "name": "Basketball",
    "seller": "SportsStar",
    "price": "EGP 600",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Neque porro quisquam est, qui dolorem ipsum quia dolor.",
    "imagePath": "assets/images/products/sports_2.png",
    "sellerProfile": "assets/images/profiles/profile_5.png",
    "sellerLocation": "Hurghada, Egypt",
    "category": "sports"
  },
  {
    "id": "e3f4a5b6-7c8d-9e0f-1a2b-3c4d5e6f7a8b",
    "name": "Mouse Pad",
    "seller": "TechEase",
    "price": "EGP 200",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut perspiciatis unde omnis iste natus error sit.",
    "imagePath": "assets/images/products/electronics_4.png",
    "sellerProfile": "assets/images/profiles/profile_3.png",
    "sellerLocation": "Arish, Egypt",
    "category": "electronics"
  },
  {
    "id": "f4a5b6c7-8d9e-0f1a-2b3c-4d5e6f7a8b9c",
    "name": "Calculator",
    "seller": "StudyTools",
    "price": "EGP 350",
    "details": "Lorem ipsum dour sit amet, consectetur adipiscing elit. At vero eos et accusamus et iusto odio dignissimos.",
    "imagePath": "assets/images/products/school_3.png",
    "sellerProfile": "assets/images/profiles/profile_8.png",
    "sellerLocation": "Marsa Matruh, Egypt",
    "category": "school"
  },
  {
    "id": "a5b6c7d8-9e0f-1a2b-3c4d-5e6f7a8b9c0d",
    "name": "Jacket",
    "seller": "UrbanStyle",
    "price": "EGP 900",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam libero tempore, cum soluta nobis est eligendi.",
    "imagePath": "assets/images/products/apparel_1.png",
    "sellerProfile": "assets/images/profiles/profile_1.png",
    "sellerLocation": "Assiut, Egypt",
    "category": "apparel"
  },
  {
    "id": "b6c7d8e9-0f1a-2b3c-4d5e-6f7a8b9c0d1e",
    "name": "Tennis Racket",
    "seller": "PlayHard",
    "price": "EGP 1200",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quia non numquam eius modi tempora incidunt ut labore.",
    "imagePath": "assets/images/products/sports_4.png",
    "sellerProfile": "assets/images/profiles/profile_6.png",
    "sellerLocation": "Luxor, Egypt",
    "category": "sports"
  },
  {
    "id": "c7d8e9f0-1a2b-3c4d-5e6f-7a8b9c0d1e2f",
    "name": "Keyboard",
    "seller": "TechGear",
    "price": "EGP 800",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Et harum quidem rerum facilis est et expedita distinctio.",
    "imagePath": "assets/images/products/electronics_3.png",
    "sellerProfile": "assets/images/profiles/profile_9.png",
    "sellerLocation": "Cairo, Egypt",
    "category": "electronics"
  },
  {
    "id": "d8e9f0a1-2b3c-4d5e-6f7a-8b9c0d1e2f3a",
    "name": "School Planner",
    "seller": "EduPlan",
    "price": "EGP 300",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Neque porro quisquam est, qui dolorem ipsum quia dolor.",
    "imagePath": "assets/images/products/school_2.png",
    "sellerProfile": "assets/images/profiles/profile_4.png",
    "sellerLocation": "Alexandria, Egypt",
    "category": "school"
  },
  {
    "id": "e9f0a1b2-3c4d-5e6f-7a8b-9c0d1e2f3a4b",
    "name": "Sweatshirt",
    "seller": "ChicWear",
    "price": "EGP 750",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut perspiciatis unde omnis iste natus error sit.",
    "imagePath": "assets/images/products/apparel_2.png",
    "sellerProfile": "assets/images/profiles/profile_12.png",
    "sellerLocation": "Giza, Egypt",
    "category": "apparel"
  },
  {
    "id": "f0a1b2c3-4d5e-6f7a-8b9c-0d1e2f3a4b5c",
    "name": "Dumbbells",
    "seller": "FitEquip",
    "price": "EGP 700",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. At vero eos et accusamus et iusto odio dignissimos.",
    "imagePath": "assets/images/products/sports_5.png",
    "sellerProfile": "assets/images/profiles/profile_7.png",
    "sellerLocation": "Mansoura, Egypt",
    "category": "sports"
  },
  {
    "id": "a1b2c3d4-5e6f-7a8b-9c0d-1e2f3a4b5c6d",
    "name": "Webcam",
    "seller": "TechVision",
    "price": "EGP 1100",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam libero tempore, cum soluta nobis est eligendi.",
    "imagePath": "assets/images/products/electronics_2.png",
    "sellerProfile": "assets/images/profiles/profile_2.png",
    "sellerLocation": "Suez, Egypt",
    "category": "electronics"
  },
  {
    "id": "b2c3d4e5-6f7a-8b9c-0d1e-2f3a4b5c6d7e",
    "name": "Highlighters",
    "seller": "StudyAid",
    "price": "EGP 120",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quia non numquam eius modi tempora incidunt ut labore.",
    "imagePath": "assets/images/products/school_1.png",
    "sellerProfile": "assets/images/profiles/profile_10.png",
    "sellerLocation": "Port Said, Egypt",
    "category": "school"
  },
  {
    "id": "c3d4e5f6-7a8b-9c0d-1e2f-3a4b5c6d7e8f",
    "name": "Cap",
    "seller": "TrendSet",
    "price": "EGP 250",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Et harum quidem rerum facilis est et expedita distinctio.",
    "imagePath": "assets/images/products/apparel_3.png",
    "sellerProfile": "assets/images/profiles/profile_5.png",
    "sellerLocation": "Aswan, Egypt",
    "category": "apparel"
  },
  {
    "id": "d4e5f6a7-8b9c-0d1e-2f3a-4b5c6d7e8f9a",
    "name": "Volleyball",
    "seller": "GameOn",
    "price": "EGP 450",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Neque porro quisquam est, qui dolorem ipsum quia dolor.",
    "imagePath": "assets/images/products/sports_3.png",
    "sellerProfile": "assets/images/profiles/profile_3.png",
    "sellerLocation": "Ismailia, Egypt",
    "category": "sports"
  },
  {
    "id": "e5f6a7b8-9c0d-1e2f-3a4b-5c6d7e8f9a0b",
    "name": "USB Hub",
    "seller": "TechConnect",
    "price": "EGP 400",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut perspiciatis unde omnis iste natus error sit.",
    "imagePath": "assets/images/products/electronics_5.png",
    "sellerProfile": "assets/images/profiles/profile_8.png",
    "sellerLocation": "Damietta, Egypt",
    "category": "electronics"
  },
  {
    "id": "f6a7b8c9-0d1e-2f3a-4b5c-6d7e8f9a0b1c",
    "name": "Textbooks",
    "seller": "BookWorm",
    "price": "EGP 500",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. At vero eos et accusamus et iusto odio dignissimos.",
    "imagePath": "assets/images/products/school_4.png",
    "sellerProfile": "assets/images/profiles/profile_1.png",
    "sellerLocation": "Fayoum, Egypt",
    "category": "school"
  },
  {
    "id": "a7b8c9d0-1e2f-3a4b-5c6d-7e8f9a0b1c2d",
    "name": "Scarf",
    "seller": "ElegantWear",
    "price": "EGP 300",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam libero tempore, cum soluta nobis est eligendi.",
    "imagePath": "assets/images/products/apparel_4.png",
    "sellerProfile": "assets/images/profiles/profile_6.png",
    "sellerLocation": "Beni Suef, Egypt",
    "category": "apparel"
  },
  {
    "id": "b8c9d0e1-2f3a-4b5c-6d7e-8f9a0b1c2d3e",
    "name": "Gym Bag",
    "seller": "ActiveGear",
    "price": "EGP 800",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quia non numquam eius modi tempora incidunt ut labore.",
    "imagePath": "assets/images/products/sports_1.png",
    "sellerProfile": "assets/images/profiles/profile_9.png",
    "sellerLocation": "Minya, Egypt",
    "category": "sports"
  },
  {
    "id": "c9d0e1f2-3a4b-5c6d-7e8f-9a0b1c2d3e4f",
    "name": "Smartwatch",
    "seller": "TechTrend",
    "price": "EGP 2500",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Et harum quidem rerum facilis est et expedita distinctio.",
    "imagePath": "assets/images/products/electronics_1.png",
    "sellerProfile": "assets/images/profiles/profile_4.png",
    "sellerLocation": "Sohag, Egypt",
    "category": "electronics"
  },
  {
    "id": "d0e1f2a3-4b5c-6d7e-8f9a-0b1c2d3e4f5a",
    "name": "Stationery Set",
    "seller": "LearnFun",
    "price": "EGP 180",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Neque porro quisquam est, qui dolorem ipsum quia dolor.",
    "imagePath": "assets/images/products/school_5.png",
    "sellerProfile": "assets/images/profiles/profile_12.png",
    "sellerLocation": "Qena, Egypt",
    "category": "school"
  },
  {
    "id": "e1f2a3b4-5c6d-7e8f-9a0b-1c2d3e4f5a6b",
    "name": "Chinos",
    "seller": "SmartWear",
    "price": "EGP 650",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut perspiciatis unde omnis iste natus error sit.",
    "imagePath": "assets/images/products/apparel_5.png",
    "sellerProfile": "assets/images/profiles/profile_7.png",
    "sellerLocation": "Tanta, Egypt",
    "category": "apparel"
  },
  {
    "id": "f2a3b4c5-6d7e-8f9a-0b1c-2d3e4f5a6b7c",
    "name": "Jump Rope",
    "seller": "FitPulse",
    "price": "EGP 300",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. At vero eos et accusamus et iusto odio dignissimos.",
    "imagePath": "assets/images/products/sports_2.png",
    "sellerProfile": "assets/images/profiles/profile_2.png",
    "sellerLocation": "Zagazig, Egypt",
    "category": "sports"
  },
  {
    "id": "a3b4c5d6-7e8f-9a0b-1c2d-3e4f5a6b7c8d",
    "name": "Speaker",
    "seller": "SoundTech",
    "price": "EGP 1500",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam libero tempore, cum soluta nobis est eligendi.",
    "imagePath": "assets/images/products/electronics_4.png",
    "sellerProfile": "assets/images/profiles/profile_10.png",
    "sellerLocation": "Kafr El Sheikh, Egypt",
    "category": "electronics"
  },
  {
    "id": "b4c5d6e7-8f9a-0b1c-2d3e-4f5a6b7c8d9e",
    "name": "Ruler Set",
    "seller": "EduGear",
    "price": "EGP 80",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quia non numquam eius modi tempora incidunt ut labore.",
    "imagePath": "assets/images/products/school_3.png",
    "sellerProfile": "assets/images/profiles/profile_5.png",
    "sellerLocation": "Damanhur, Egypt",
    "category": "school"
  },
  {
    "id": "c5d6e7f8-9a0b-1c2d-3e4f-5a6b7c8d9e0f",
    "name": "Sunglasses",
    "seller": "CoolShades",
    "price": "EGP 500",
    "details": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Et harum quidem rerum facilis est et expedita distinctio.",
    "imagePath": "assets/images/products/apparel_1.png",
    "sellerProfile": "assets/images/profiles/profile_3.png",
    "sellerLocation": "Banha, Egypt",
    "category": "apparel"
  }
]''', flush: true);
      print('Filled products.json');
    } catch (e) {
      print('Error filling products: $e');
    }
  }
}
