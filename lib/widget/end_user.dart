import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sale_tracker/screen/approve.dart';

class EndUserWidget extends StatefulWidget {
  const EndUserWidget({Key? key}) : super(key: key);

  @override
  State<EndUserWidget> createState() => _EndUserWidgetState();
}

class _EndUserWidgetState extends State<EndUserWidget> {
  final _titleFieldController = TextEditingController();
  final _amountFieldController = TextEditingController();
  final _priceFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double total = 0;

  final now =  DateTime.now();
  String formatter = DateFormat('yMd').format(DateTime.now());

  _price(kg,  price){
    setState(() {
      total = (double.tryParse(kg)! * int.parse(price))! ;
    });
  }

  _value(kg,  price, title, type) async {
    final enterKg = int.tryParse(_amountFieldController.text);
    final enterPrice = int.tryParse(_priceFieldController.text);
    final amountIsValid = enterKg == null || enterPrice == null;
    if (_titleFieldController.text.trim().isEmpty ||
        amountIsValid ||
        _titleFieldController.text == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Invalid Data'),
          content: const Text('Please make sure you enter a valid Data'),
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

    setState(() {
      total = (double.tryParse(kg)! * int.parse(price))!  ;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final url = Uri.https(
          'sale-tracker-e4ae0-default-rtdb.firebaseio.com', 'sales-list.json');
    final response = await  http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'name': title,
            'price': price,
            'kg': kg,
            'payment_type': type,
            'time': formatter
          },
        ),
      );

    if(response.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Processing Data, Saved Successfully'),
        ),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ApproveScreen(),),);
    }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 38, 16, 16),
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter value';
                  }
                  return null;
                },
                controller: _titleFieldController,
                maxLength: 50,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  label: Text(
                    "How Much Gas/Customer Name",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter value';
                  }
                  return null;
                },
                controller: _amountFieldController,
                maxLength: 50,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  label: Text(
                    "KG",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
               // onEditingComplete: _price(_amountFieldController.text, _priceFieldController.text),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter value';
                  }
                  return null;
                },
                controller: _priceFieldController,
                maxLength: 50,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  label: Text(
                    "Price",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  prefixText: "\#",
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Mode of Payment",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _value(_amountFieldController.text, _priceFieldController.text, _titleFieldController.text, 'cash');
                    },
                    icon: const Icon(Icons.print),
                    label: const Text(
                      'Cash at Hand',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  const SizedBox(width: 35,),
                   Text(
                    "$total",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      _value(_amountFieldController.text, _priceFieldController.text, _titleFieldController.text, 'POS');
                    },
                    icon: const Icon(Icons.no_transfer_rounded),
                    label: const Text(
                      'POS Card Tr.',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  const SizedBox(width: 45,),
                   Text(
                    "$total",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      _value(_amountFieldController.text, _priceFieldController.text, _titleFieldController.text, 'Bank Transfer');
                    },
                    icon: const Icon(Icons.food_bank_outlined),
                    label: const Text(
                      'Bank Transfer',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  const SizedBox(width: 35,),
                  Text(
                    "$total",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
               Text(
                 " Total :  $total",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
