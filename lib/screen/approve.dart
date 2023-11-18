import 'package:flutter/material.dart';

class ApproveScreen extends StatelessWidget {
  const ApproveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  const Text('Approved'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
       body: Center(
         child: Column(
         mainAxisSize: MainAxisSize.min,
         children: [
           Image.asset(
             'assets/images/approve.jpeg',
             width: 550,
             // color: const Color.fromARGB(150, 255, 255, 255),
           ),
         ],
       ),
    ),);
  }
}
