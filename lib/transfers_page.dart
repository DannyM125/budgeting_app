import 'package:flutter/material.dart';
import 'utils/transfer_dialog.dart'; // Import the utility file

class TransfersPage extends StatefulWidget {
  const TransfersPage({super.key});

  @override
  _TransfersPageState createState() => _TransfersPageState();
}

class _TransfersPageState extends State<TransfersPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  DateTime? _selectedDate;
  String _transactionType = 'Withdrawal';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Transfers'), backgroundColor: Colors.white,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () => showAddTransferDialog(
                  context,
                  _amountController,
                  _categoryController,
                  _selectedDate,
                  _transactionType,
                  (value) => setState(() => _transactionType = value),
                  (date) => setState(() => _selectedDate = date),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 4,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Text('Add Transfer', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => showRecurringTransferDialog(
                  context,
                  _amountController,
                  _categoryController,
                  _selectedDate,
                  (date) => setState(() => _selectedDate = date),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 4,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Text('Add Recurring Transfer', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Transfer History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: 5, // Example transactions
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                      child: ListTile(
                        title: Text('Transfer #$index'),
                        subtitle: Text('Amount: \$${(index + 1) * 50}'), //TODO actually make this part work
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
