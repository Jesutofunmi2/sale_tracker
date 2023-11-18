import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sale_tracker/screen/end_user.dart';
import 'package:http/http.dart' as http;

import '../model/sales.dart';

class Record extends StatefulWidget {
  const Record({super.key});

  @override
  State<Record> createState() => _RecordState();
}

class _RecordState extends State<Record> {
  List<Sales> sales =[];

  void _loadData() async {
    final url = Uri.https(
        'sale-tracker-e4ae0-default-rtdb.firebaseio.com', 'sales-list.json');

    final response = await http.get(url);

      final Map<String, dynamic> data = json.decode(response.body);
     final List<Sales> salesLoad =[];
      for (final item in data.entries){
         salesLoad.add(Sales(id: item.key, kg: item.value['kg'], name:  item.value['name'], price:  item.value['price'], time:  item.value['item']));
      }

      setState(() {
        sales = salesLoad;
      });


  }

  void _addItem() async {
    await Navigator.of(context).push<Sales>(
      MaterialPageRoute(
        builder: (ctx) => const EndUser(title:'Add New Sales'),
      ),
    );

    _loadData();
  }

  void _removeItem(Sales item) {
    setState(() {
      sales.remove(item);
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

    if (sales.isNotEmpty) {
      content = ListView.builder(
        itemCount: sales.length,
        itemBuilder: (ctx, index) =>

            Dismissible(
              onDismissed: (direction) {
                _removeItem(sales[index]);
              },
              key: ValueKey(sales[index].id),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${sales[index].kg?? ''}KG",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Text('\# ${sales[index].price?? ''}'),
                          const Spacer(),
                          Row(
                            children: [
                              const Icon(Icons.person),
                              Text(sales[index].name?? ''),
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
          title: const Text('Your Sales'),
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
