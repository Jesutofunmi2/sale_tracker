
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/expense.dart';
import 'package:http/http.dart' as http;

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});



  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleFieldController = TextEditingController();
  final _amountFieldController = TextEditingController();
  DateTime? _selectedDateTime;
  Category _selectedCategory = Category.leisure;

  final now =  DateTime.now();
  //String formatter = DateFormat('yMd').format(DateTime.now());
  @override
  void dispose() {
    _titleFieldController.dispose();
    _amountFieldController.dispose();
    super.dispose();
  }

  void _submitExpenseData() async {
    final enterAmount = double.tryParse(_amountFieldController.text);
    final amountIsValid = enterAmount == null || enterAmount <= 0;
    if (_titleFieldController.text.trim().isEmpty ||
        amountIsValid ||
        _selectedDateTime == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Invalid Text'),
          content: const Text('Please make sure a valid context'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Okay"),
            ),
          ],
        ),
      );
      return;
    }

    final url = Uri.https(
        'sale-tracker-e4ae0-default-rtdb.firebaseio.com', 'expenses-list.json');
    final response = await  http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'date': formatter.format(_selectedDateTime!),
            'amount': enterAmount,
            'title': _titleFieldController.text,
            'category':_selectedCategory.name
          },
        ),
    );

    if(response.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Processing Data, Saved Successfully'),
        ),
      );
      Navigator.pop(context);
    }
    // widget.onAddExpense(
    //   Expense(
    //       date: _selectedDateTime!,
    //       title: _titleFieldController.text,
    //       amount: enterAmount,
    //       category: _selectedCategory),
    // );

  }

  Future<void> _showDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final datePicker = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDateTime = datePicker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 48, 16,16),
          child: Column(
            children: [
              TextField(
                controller: _titleFieldController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text("Title"),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountFieldController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text("Amount"),
                        prefixText: "\#",
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _selectedDateTime == null
                              ? 'No Date Selected'
                              : formatter.format(_selectedDateTime!),
                        ),
                        IconButton(
                          onPressed: _showDatePicker,
                          icon: const Icon(Icons.date_range),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase()),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: _submitExpenseData,
                    child: const Text('Save Item'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
