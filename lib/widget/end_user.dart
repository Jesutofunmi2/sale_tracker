import 'package:flutter/material.dart';

class EndUserWidget extends StatefulWidget {
  const EndUserWidget({Key? key}) : super(key: key);

  @override
  State<EndUserWidget> createState() => _EndUserWidgetState();
}

class _EndUserWidgetState extends State<EndUserWidget> {
  final _titleFieldController = TextEditingController();
  final _amountFieldController = TextEditingController();
  final _priceFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 38, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleFieldController,
            maxLength: 50,
            decoration: const InputDecoration(
              labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              label: Text(
                "How Much Gas",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            controller: _amountFieldController,
            maxLength: 50,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              label: Text(
                "0.00",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              prefixText: "\#",
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
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
                onPressed: () {},
                icon: const Icon(Icons.print),
                label: const Text(
                  'Cash at Hand',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              const SizedBox(width: 35,),
              const Text(
                "0.00",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.no_transfer_rounded),
                label: const Text(
                  'POS Card Tr.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              const SizedBox(width: 45,),
              const Text(
                "0.00",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.food_bank_outlined),
                label: const Text(
                  'Bank Transfer',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              const SizedBox(width: 35,),
              const Text(
                "0.00",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "820.00",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
