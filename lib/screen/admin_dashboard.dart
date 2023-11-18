import 'package:flutter/material.dart';
import 'package:sale_tracker/data/dummy_data.dart';
import 'package:sale_tracker/model/category.dart';
import 'package:sale_tracker/screen/end_user.dart';
import 'package:sale_tracker/screen/expenses.dart';
import 'package:sale_tracker/screen/new_registration.dart';
import 'package:sale_tracker/widget/category_grid.dart';

import '../data/admin_dummy_data.dart';
import '../widget/admin_category_grid.dart';

class AdminDashBoardScreen extends StatelessWidget {
  const AdminDashBoardScreen({Key? key}) : super(key: key);

  _onSelectedScreen(BuildContext context, Category category) {
    if (category.id == 'c3') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) =>  EndUser(
            title: category.title,
          ),
        ),
      );
    } else if (category.id == 'c1') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => const RegistrationScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 2,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18),
        children: [
          // availableCategories.map((category) => CategoryGrid(category: category)).toList();
          for (final category in adminavailableCategories)
            AdminCategoryGrid(
                category: category,
                onSelected: () {
                  _onSelectedScreen(context, category);
                })
        ],
      ),
    );
  }
}
