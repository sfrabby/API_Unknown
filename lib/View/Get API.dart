import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/Product Controller.dart';

class GetApi extends StatelessWidget {
  GetApi({super.key});

  @override
  final GetProductController getProductController = Get.put(
    GetProductController(),
  );
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Api practice", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: getProductController.ProductList.length,
          itemBuilder: (context, index) {
            var product = getProductController.ProductList[index];
            return Card(
              child: ListTile(
                title: Text(product.title.toString()),
                subtitle: Text("Price"),
                leading: CircleAvatar(
                  child: Text("I"),
                  backgroundColor: Colors.teal,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
