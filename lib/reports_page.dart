import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'utils/color_utils.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  List<Map<String, dynamic>> spendingCategories = [];
  List<Map<String, dynamic>> incomeCategories = [];
  bool showSpending = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _saveData();
    super.dispose();
  }

  // Load data from SharedPreferences
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      spendingCategories = _getStoredList(prefs, 'spendingCategories', [
        {'category': 'Food', 'amount': 120},
        {'category': 'Transportation', 'amount': 60},
        {'category': 'Entertainment', 'amount': 80},
        {'category': 'Bills', 'amount': 200},
      ]);
      incomeCategories = _getStoredList(prefs, 'incomeCategories', [
        {'category': 'Salary', 'amount': 1000},
        {'category': 'Freelance', 'amount': 300},
        {'category': 'Investments', 'amount': 150},
      ]);
    });
  }

  // Save data to SharedPreferences
  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('spendingCategories', jsonEncode(spendingCategories));
    await prefs.setString('incomeCategories', jsonEncode(incomeCategories));
  }

  // Get stored list from SharedPreferences or default value
  List<Map<String, dynamic>> _getStoredList(SharedPreferences prefs, String key, List<Map<String, dynamic>> defaultList) {
    final String? jsonString = prefs.getString(key);
    if (jsonString != null) {
      return List<Map<String, dynamic>>.from(jsonDecode(jsonString));
    }
    return defaultList;
  }

  // Update a category by adding a new expense or income
  void _updateCategory(String type, String categoryName, int amount) {
    setState(() {
      List<Map<String, dynamic>> categories = type == 'spending' ? spendingCategories : incomeCategories;
      int index = categories.indexWhere((category) => category['category'] == categoryName);

      if (index != -1) {
        categories[index]['amount'] += amount;
      } else {
        categories.add({'category': categoryName, 'amount': amount});
      }
    });

    _saveData(); // Save immediately after update
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Reports'),
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showSpending = !showSpending;
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: ColorUtils.primaryColor),
              child: Text(
                showSpending ? 'Show Income Report' : 'Show Spending Report',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 250,
              child: PieChart(
                PieChartData(
                  sections: showSpending
                      ? _generatePieChartSections(spendingCategories)
                      : _generatePieChartSections(incomeCategories),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              showSpending ? 'Top Spending Categories:' : 'Top Earning Categories:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: ColorUtils.primaryColor),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: showSpending ? spendingCategories.length : incomeCategories.length,
                itemBuilder: (context, index) {
                  final category = showSpending ? spendingCategories[index] : incomeCategories[index];
                  return ListTile(
                    title: Text(category['category'], style: const TextStyle(fontSize: 20)),
                    trailing: Text('\$${category['amount']}', style: const TextStyle(fontSize: 20)),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _updateCategory('spending', 'Groceries', 50);
              },
              child: const Text("Add \$50 to Groceries"),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _generatePieChartSections(List<Map<String, dynamic>> categories) {
    return categories
        .map(
          (category) => PieChartSectionData(
            value: category['amount'].toDouble(),
            color: _getCategoryColor(category['category']),
            title: '${category['category']} \n \$${category['amount']}',
            radius: 60,
            titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        )
        .toList();
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Food':
        return Colors.orange;
      case 'Transportation':
        return Colors.blue;
      case 'Entertainment':
        return Colors.green;
      case 'Bills':
        return Colors.red;
      case 'Salary':
        return Colors.purple;
      case 'Freelance':
        return Colors.yellow;
      case 'Investments':
        return Colors.pink;
      case 'Groceries':
        return Colors.brown;
      default:
        return Colors.grey;
    }
  }
}
