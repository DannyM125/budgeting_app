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
      appBar: AppBar(title: const Text('Transfers')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () => showAddTransferDialog(
                context,
                _amountController,
                _categoryController,
                _selectedDate,
                _transactionType,
                (value) => setState(() => _transactionType = value),
                (date) => setState(() => _selectedDate = date),
              ),
              child: const Text('Add Transfer'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => showRecurringTransferDialog(
                context,
                _amountController,
                _categoryController,
                _selectedDate,
                (date) => setState(() => _selectedDate = date),
              ),
              child: const Text('Add Recurring Transfer'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Transfer History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Example transactions
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Transfer #$index'),
                    subtitle: Text('Amount: \$${(index + 1) * 50}'), //TODO actually make this part work
                    trailing: const Icon(Icons.arrow_forward_ios),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
