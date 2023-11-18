import 'package:flutter/material.dart';
import 'package:sale_tracker/widget/end_user.dart';
class EndUser extends StatefulWidget {
  const EndUser({super.key, required this.title});
  final String title;

  @override
  State<EndUser> createState() => _EndUserState();
}

class _EndUserState extends State<EndUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      body: const EndUserWidget(),
    );
  }
}
