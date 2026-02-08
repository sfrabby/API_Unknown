import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/Product Controller.dart';

class GetApi extends StatelessWidget {
  GetApi({super.key});

  final GetProductController getProductController = Get.put(GetProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Api practice", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: getProductController.productList.length,
          itemBuilder: (context, index) {
            var product = getProductController.productList[index];
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
