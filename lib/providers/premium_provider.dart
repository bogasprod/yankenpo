import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class PremiumProvider with ChangeNotifier {
  bool _isPremium = false;
  ProductDetails? _product;

  bool get isPremium => _isPremium;
  ProductDetails? get product => _product;

  PremiumProvider() {
    _loadPremiumStatus();
  }

   void setPremium(bool value) {
    _isPremium = value;
    notifyListeners();
  }

  Future<void> _loadPremiumStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isPremium = prefs.getBool('isPremium') ?? false;
    notifyListeners();
  }

  Future<void> activatePremium() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPremium', true);
    _isPremium = true;
    notifyListeners();
  }

  Future<void> resetPremium() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPremium', false);
    _isPremium = false;
    notifyListeners();
  }

  void setProduct(ProductDetails? product) {
    _product = product;
    notifyListeners();
  }
}
