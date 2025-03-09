import 'dart:convert';

class Category {
  String category;
  double amount;

  Category({required this.category, required this.amount});

  // Factory constructor to create Category from a Map
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      category: json['category'],
      amount: json['amount'].toDouble(),
    );
  }

  // Convert Category to JSON map
  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'amount': amount,
    };
  }
}

class CategoryList {
  List<Category> categories;

  CategoryList({required this.categories});

  // Factory constructor to create CategoryList from JSON
  factory CategoryList.fromJson(List<dynamic> json) {
    return CategoryList(
      categories: json.map((e) => Category.fromJson(e)).toList(),
    );
  }

  // Convert CategoryList to JSON list
  List<Map<String, dynamic>> toJson() {
    return categories.map((category) => category.toJson()).toList();
  }
}
