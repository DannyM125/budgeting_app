import 'package:flutter/material.dart';

void showAddTransferDialog(BuildContext context, TextEditingController amountController, TextEditingController categoryController, DateTime? selectedDate, String transactionType, Function(String) onTransactionTypeChanged, Function(DateTime?) onDateSelected) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Add Transfer'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<String>(
            value: transactionType,
            items: ['Withdrawal', 'Deposit']
                .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                .toList(),
            onChanged: (value) {
              onTransactionTypeChanged(value!);
            },
          ),
          TextField(
            controller: amountController,
            decoration: const InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: categoryController,
            decoration: const InputDecoration(labelText: 'Category'),
          ),
          ElevatedButton(
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              onDateSelected(pickedDate);
            },
            child: const Text('Select Date'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}

void showRecurringTransferDialog(BuildContext context, TextEditingController amountController, TextEditingController categoryController, DateTime? selectedDate, Function(DateTime?) onDateSelected) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Add Recurring Transfer'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: categoryController,
            decoration: const InputDecoration(labelText: 'Category'),
          ),
          TextField(
            controller: amountController,
            decoration: const InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
          ),
          ElevatedButton(
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              onDateSelected(pickedDate);
            },
            child: const Text('Select Start Date'),
          ),
          DropdownButton<String>(
            value: 'Monthly',
            items: ['Daily', 'Weekly', 'Monthly', 'Yearly']
                .map((cycle) => DropdownMenuItem(value: cycle, child: Text(cycle)))
                .toList(),
            onChanged: (value) {},
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}
