import 'package:flutter/material.dart';
import 'package:sale_tracker/screen/dashboard.dart';
import 'package:sale_tracker/screen/expenses.dart';

import 'new_expense.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});
  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedPageInt = 0;
  var activePageTitle = "Languages";

  @override
  void _selectPage(int index){
    setState(() {
      _selectedPageInt = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    Widget activeScreen = const DashBoardScreen();
    var activePageTitle = "Gas Inventory App";
    if(_selectedPageInt == 1){
      //activeScreen = const VideoScreen();
      activePageTitle = "Video";
    }else if(_selectedPageInt == 2){
      activeScreen = const Expenses(title: "Ex");
      activePageTitle = "Expense";
    }else if(_selectedPageInt == 3){
      //activeScreen = const Profile();
      activePageTitle = "Profile";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
        centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.density_medium_sharp,
              ),
            ),
          ],
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageInt,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.gas_meter), label: 'Gas', backgroundColor:   Color.fromARGB(255, 14, 14, 89),),
          BottomNavigationBarItem(icon: Icon(Icons.report_outlined), label: 'Report',  backgroundColor:  Color.fromARGB(255, 14, 14, 89),),
          BottomNavigationBarItem(icon: Icon(Icons.sd_card_alert), label: 'Expenses' , backgroundColor:  Color.fromARGB(255, 14, 14, 89),),
          BottomNavigationBarItem(icon: Icon(Icons.print), label: 'Reprint' , backgroundColor:  Color.fromARGB(255, 14, 14, 89),),
        ],
      ),
    );
  }
}
