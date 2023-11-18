import 'package:flutter/material.dart';
import 'package:sale_tracker/model/category.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key, required this.category, required this.onSelected});

  final Category category;
  final  Function() onSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelected,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16)
        ),
        child: Column(
          children: [
            Image.asset("assets/images/gas.png",
              width: 100, height: 100,),
            Text(
              category.title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground, fontSize: 17,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
