import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  // Dummy data for spending and income categories
  final List<Map<String, dynamic>> spendingCategories = [
    {'category': 'Food', 'amount': 120},
    {'category': 'Transportation', 'amount': 60},
    {'category': 'Entertainment', 'amount': 80},
    {'category': 'Bills', 'amount': 200},
  ];

  final List<Map<String, dynamic>> incomeCategories = [
    {'category': 'Salary', 'amount': 1000},
    {'category': 'Freelance', 'amount': 300},
    {'category': 'Investments', 'amount': 150},
  ];

  bool showSpending = true; // To toggle between spending and income pie charts

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
            // Toggle button to switch between spending and income pie chart
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showSpending = !showSpending;
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text(
                showSpending ? 'Show Income Chart' : 'Show Spending Chart',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),

            // Pie chart to show spending or income data
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

            // Title for the top categories list
            const Text(
              'Top Spending Categories',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // List of top spending categories
            Expanded(
              child: ListView.builder(
                itemCount: spendingCategories.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(spendingCategories[index]['category']),
                    trailing: Text('\$${spendingCategories[index]['amount']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to generate pie chart sections from a given category list
  List<PieChartSectionData> _generatePieChartSections(List<Map<String, dynamic>> categories) {
    return categories
        .map(
          (category) => PieChartSectionData(
            value: category['amount'].toDouble(),
            color: _getCategoryColor(category['category']),
            title: '${category['category']} \n \$${category['amount']}',
            radius: 60,
            titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        )
        .toList();
  }

  // Method to generate a color for each category
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
