import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'category.dart'; // import the Category and CategoryList classes

class SharedPrefsHelper {
  static const String _spendingKey = 'spendingCategories';
  static const String _incomeKey = 'incomeCategories';

  // Save categories to SharedPreferences
  static Future<void> saveCategories(
      List<Category> categories, bool isSpending) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> jsonData =
        CategoryList(categories: categories).toJson();
    final jsonString = jsonEncode(jsonData);
    if (isSpending) {
      prefs.setString(_spendingKey, jsonString);
    } else {
      prefs.setString(_incomeKey, jsonString);
    }
  }

  // Load categories from SharedPreferences
  static Future<List<Category>> loadCategories(bool isSpending) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = isSpending
        ? prefs.getString(_spendingKey)
        : prefs.getString(_incomeKey);
    if (jsonString == null) return [];
    List<dynamic> jsonData = jsonDecode(jsonString);
    return CategoryList.fromJson(jsonData).categories;
  }
}
