import 'package:flutter/material.dart';
import 'package:sale_tracker/screen/dashboard.dart';
import 'package:sale_tracker/screen/expenses.dart';

import 'admin_dashboard.dart';
import 'new_expense.dart';

class AdminTabScreen extends StatefulWidget {
  const AdminTabScreen({super.key});
  @override
  State<AdminTabScreen> createState() => _AdminTabScreenState();
}

class _AdminTabScreenState extends State<AdminTabScreen> {
  int _selectedPageInt = 0;
  var activePageTitle = "Languages";

  @override
  void _selectPage(int index){
    setState(() {
      _selectedPageInt = index;
    });
  }

  // void _showModal() {
  //   showModalBottomSheet(
  //     //isScrollControlled: true,
  //     context: context,
  //     builder: (ctx) => NewExpense(onAddExpense: _addExpense),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    Widget activeScreen = const AdminDashBoardScreen();
    var activePageTitle = "Admin DashBoard";
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
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.home),
        ),
        centerTitle: true,
        backgroundColor:const Color.fromARGB(255, 72, 154, 107),
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
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'New User', backgroundColor:    Color.fromARGB(255, 72, 154, 107),),
          BottomNavigationBarItem(icon: Icon(Icons.report_outlined), label: 'Report',  backgroundColor:   Color.fromARGB(255, 72, 154, 107),),
          BottomNavigationBarItem(icon: Icon(Icons.sd_card_alert), label: 'Expenses' , backgroundColor:  Color.fromARGB(255, 72, 154, 107),),
          BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Bonus' , backgroundColor:  Color.fromARGB(255, 72, 154, 107),),
        ],
      ),
    );
  }
}
