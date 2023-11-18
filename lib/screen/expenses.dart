
import 'package:flutter/material.dart';

import '../model/expense.dart';
import 'chart.dart';
import 'expense_list.dart';
import 'new_expense.dart';


class Expenses extends StatefulWidget {
  const Expenses({super.key, required this.title});
  final String title;

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registerExpense = [
    Expense(
        date: DateTime.now(),
        title: 'Transport',
        amount: 3500,
        category: Category.food),
    Expense(
        date: DateTime.now(),
        title: 'Fueling',
        amount: 3500,
        category: Category.leisure),
    Expense(
        date: DateTime.now(),
        title: 'Feeding',
        amount: 3500,
        category: Category.travel),
    Expense(
        date: DateTime.now(),
        title: 'Recharge Card',
        amount: 3500,
        category: Category.work),
    Expense(
        date: DateTime.now(),
        title: 'Booking',
        amount: 3500,
        category: Category.food),
  ];

  void _showModal() {
    showModalBottomSheet(
      //isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registerExpense.add(expense);
    });
  }

  void _removeExpense(Expense expense) {

    final expenseIndex = _registerExpense.indexOf(expense);
    setState(() {
      _registerExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(

       SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Record Deleted"),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registerExpense.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No available content"),
    );

    if (_registerExpense.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registerExpense,
        onRemoved: _removeExpense,
      );
    }
    return Scaffold(
      // appBar: AppBar(
      //   title:  Text(widget.title),
      //   actions: [
      //     IconButton(
      //       onPressed: _showModal,
      //       icon: const Icon(
      //         Icons.add,
      //       ),
      //     ),
      //   ],
      //),
      body: Column(
        children: [ Chart(expenses: _registerExpense),
          Expanded(child: mainContent)],
      ),
    );
  }
}
