import 'package:budget_app/utils/SharedPreferences/category.dart';
import 'package:budget_app/utils/SharedPreferences/shared_prefs_helper.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'utils/color_utils.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  List<Category> spendingCategories = [
    Category(category: 'Food', amount: 120),
    Category(category: 'Transportation', amount: 60),
    Category(category: 'Entertainment', amount: 80),
    Category(category: 'Bills', amount: 200),
  ];

  List<Category> incomeCategories = [
    Category(category: 'Salary', amount: 1000),
    Category(category: 'Freelance', amount: 300),
    Category(category: 'Investments', amount: 150),
  ];

  bool showSpending = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  // Load categories when the page loads
  void _loadCategories() async {
    List<Category> loadedSpending =
        await SharedPrefsHelper.loadCategories(true);
    List<Category> loadedIncome = await SharedPrefsHelper.loadCategories(false);

    setState(() {
      spendingCategories =
          loadedSpending.isNotEmpty ? loadedSpending : spendingCategories;
      incomeCategories =
          loadedIncome.isNotEmpty ? loadedIncome : incomeCategories;
    });
  }

  // Save categories when button is pressed
  void _saveCategories() async {
    await SharedPrefsHelper.saveCategories(spendingCategories, true);
    await SharedPrefsHelper.saveCategories(incomeCategories, false);
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
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorUtils.primaryColor),
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
              showSpending
                  ? 'Top Spending Categories:'
                  : 'Top Earning Categories:',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: ColorUtils.primaryColor),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: showSpending
                    ? spendingCategories.length
                    : incomeCategories.length,
                itemBuilder: (context, index) {
                  final category = showSpending
                      ? spendingCategories[index]
                      : incomeCategories[index];
                  return ListTile(
                    title: Text(category.category,
                        style: const TextStyle(fontSize: 20)),
                    trailing: Text('\$${category.amount}',
                        style: const TextStyle(fontSize: 20)),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _saveCategories,
              child: Text('Save Categories'),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _generatePieChartSections(
      List<Category> categories) {
    return categories
        .map(
          (category) => PieChartSectionData(
            value: category.amount,
            color: _getCategoryColor(category.category),
            title: '${category.category} \n \$${category.amount}',
            radius: 60,
            titleStyle: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
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
      default:
        return Colors.grey;
    }
  }
}
