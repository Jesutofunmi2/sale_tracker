import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sale_tracker/screen/end_user.dart';
import 'package:http/http.dart' as http;
import 'package:sale_tracker/screen/new_expense.dart';

import '../model/expense.dart';
import '../model/sales.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key, required this.title});
  final String title;

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List<Expense> expense =[];
  void _loadData() async {
    final url = Uri.https(
        'sale-tracker-e4ae0-default-rtdb.firebaseio.com', 'expenses-list.json');

    final response = await http.get(url);

    final Map<String, dynamic> data = json.decode(response.body);
    final List<Expense> loadExpense =[];
    for (final item in data.entries){
      loadExpense.add(Expense(id: item.key, title: item.value['title'], amount: item.value['amount'], today: item.value['date'],),);
    }

    setState(() {
      expense = loadExpense;
    });
  }

  void _addItem() async {
    await Navigator.of(context).push<Sales>(
      MaterialPageRoute(
        builder: (ctx) =>  NewExpense(),
      ),
    );
    _loadData();
  }

  void _removeItem(Expense item) {
    setState(() {
      expense.remove(item);
    });
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (expense.isNotEmpty) {
      content = ListView.builder(
          itemCount: expense.length,
          itemBuilder: (ctx, index) =>

              Dismissible(
                onDismissed: (direction) {
                  _removeItem(expense[index]);
                },
                key: ValueKey(expense[index].id),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${expense[index].title?? ''}",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Text('\# ${expense[index].amount?? ''}'),
                            const Spacer(),
                            Row(
                              children: [
                                const Icon(Icons.date_range),
                                Text(expense[index].today?? ''),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Expenses'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
