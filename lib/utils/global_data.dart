import 'package:budget_app/utils/SharedPreferences/category.dart';
import 'package:budget_app/utils/SharedPreferences/shared_prefs_helper.dart';
import 'package:fl_chart/fl_chart.dart';

class GlobalData {
  static List<Category> spendingCategories = [
    Category(category: 'Food', amount: 120),
    Category(category: 'Transportation', amount: 60),
    Category(category: 'Entertainment', amount: 80),
    Category(category: 'Bills', amount: 200),
  ];

  static List<Category> incomeCategories = [
    Category(category: 'Salary', amount: 1000),
    Category(category: 'Freelance', amount: 300),
    Category(category: 'Investments', amount: 150),
  ];

  // Add a category while preventing duplicates
  static void addCategory(String categoryName, double amount, bool isSpending) {
    List<Category> categories =
        isSpending ? spendingCategories : incomeCategories;

    // Check if category exists
    int index = categories.indexWhere((c) => c.category == categoryName);
    if (index != -1) {
      // If exists, update amount
      categories[index].amount += amount;
    } else {
      // If not exists, add new entry
      categories.add(Category(category: categoryName, amount: amount));
    }
  }

  // Save all categories
  static Future<void> saveCategories() async {
    await SharedPrefsHelper.saveCategories(spendingCategories, true);
    await SharedPrefsHelper.saveCategories(incomeCategories, false);
  }

  // Load all categories
  static Future<void> loadCategories() async {
    spendingCategories = await SharedPrefsHelper.loadCategories(true);
    incomeCategories = await SharedPrefsHelper.loadCategories(false);
  }

  static double _currentBalance = 5000.00;
  static List<FlSpot> _balanceHistory = [
    const FlSpot(0, 2000),
    const FlSpot(1, 3000),
    const FlSpot(2, 4000),
    const FlSpot(3, 4500),
    const FlSpot(4, 5000),
  ];

  static double getCurrentBalance() {
    return _currentBalance;
  }

  static List<FlSpot> getBalanceHistory() {
    return _balanceHistory;
  }

  static void updateBalance(double amount) {
    _currentBalance += amount;
    _balanceHistory.add(FlSpot(_balanceHistory.length.toDouble(), _currentBalance));
  }
}
