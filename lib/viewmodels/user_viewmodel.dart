import 'package:flutter/material.dart';
import 'package:college_ecommerce_app/models/user.dart';
import 'package:college_ecommerce_app/controllers/user_service.dart';

class UserViewModel extends ChangeNotifier {
  final UserService _userService = UserService();
  User? _currentUser;
  List<User> _users = [];
  String? _errorMessage;

  User? get currentUser => _currentUser;
  String? get errorMessage => _errorMessage;

  Future<void> loadUsers() async {
    _users = await _userService.readUsers();
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    try {
      await loadUsers();
      final user = _users.firstWhere(
        (user) => user.email == email && user.password == password,
        orElse: () => User(name: '', email: '', password: '', wishlist: [], cart: []),
      );

      if (user.email.isNotEmpty) {
        _currentUser = user;
        _errorMessage = null;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Invalid credentials';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String email, String password) async {
    try {
      await loadUsers();
      if (_users.any((user) => user.email == email)) {
        _errorMessage = 'Email already registered';
        notifyListeners();
        return false;
      }

      final name = email.split('@').first;
      final newUser = User(
        name: name,
        email: email,
        password: password,
        wishlist: [],
        cart: [],
      );
      _users.add(newUser);
      await _userService.writeUsers(_users);
      _currentUser = newUser;
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Registration failed: $e';
      notifyListeners();
      return false;
    }
  }

  Future<void> toggleWishlistItem(String productId) async {
    if (_currentUser == null) return;
    final updatedWishlist = List<String>.from(_currentUser!.wishlist);
    if (updatedWishlist.contains(productId)) {
      updatedWishlist.remove(productId);
    } else {
      updatedWishlist.add(productId);
    }
    _currentUser = _currentUser!.copyWith(wishlist: updatedWishlist);
    await _updateUser();
    notifyListeners();
  }

  bool isItemInWishlist(String productId) {
    return _currentUser?.wishlist.contains(productId) ?? false;
  }

  Future<void> toggleCartItem(String productId) async {
    if (_currentUser == null) return;
    final updatedCart = List<String>.from(_currentUser!.cart);
    if (updatedCart.contains(productId)) {
      updatedCart.remove(productId);
    } else {
      updatedCart.add(productId);
    }
    _currentUser = _currentUser!.copyWith(cart: updatedCart);
    await _updateUser();
    notifyListeners();
  }

  bool isItemInCart(String productId) {
    return _currentUser?.cart.contains(productId) ?? false;
  }

  Future<void> _updateUser() async {
    if (_currentUser == null) return;
    final index = _users.indexWhere((user) => user.email == _currentUser!.email);
    if (index != -1) {
      _users[index] = _currentUser!;
      await _userService.writeUsers(_users);
    }
  }

  void logout() {
    _currentUser = null;
    _errorMessage = null;
    notifyListeners();
  }
}
