import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sale_tracker/screen/end_user.dart';
import 'package:http/http.dart' as http;
import 'package:sale_tracker/screen/new_registration.dart';

import '../model/sales.dart';
import '../model/user.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  List<Users> users =[];

  void _loadData() async {
    final url = Uri.https(
        'sale-tracker-e4ae0-default-rtdb.firebaseio.com', 'user-list.json');

    final response = await http.get(url);

    final Map<String, dynamic> data = json.decode(response.body);
    final List<Users> usersLoad =[];
    for (final item in data.entries){
      usersLoad.add(Users(id: item.key, email: item.value['email'], name:  item.value['name'], phone: item.value['phone']));
    }
    setState(() {
      users = usersLoad;
    });

  }

  void _addItem() async {
    await Navigator.of(context).push<Users>(
      MaterialPageRoute(
        builder: (ctx) => const RegistrationScreen(),
      ),
    );

    _loadData();
  }

  void _removeItem(Users item) {
    setState(() {
      users.remove(item);
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

    if (users.isNotEmpty) {
      content = ListView.builder(
          itemCount: users.length,
          itemBuilder: (ctx, index) =>

              Dismissible(
                onDismissed: (direction) {
                  _removeItem(users[index]);
                },
                key: ValueKey(users[index].id),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          users[index].email?? '',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Text(users[index].phone?? ''),
                            SizedBox(width: 5,),
                            Row(
                              children: [
                                const Icon(Icons.person),
                                Text(users[index].name?? ''),
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
        title: const Text('Your Users'),
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
