import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class GetApi extends StatelessWidget {
  const GetApi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Api practice", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(child: ListTile(
            title: Text("Hello"),
            subtitle: Text("Price"),
            leading: CircleAvatar(child: Text("I"),backgroundColor: Colors.teal ,),
          ));
        },
      ),
    );
  }
}
