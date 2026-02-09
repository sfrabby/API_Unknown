import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/Create Product Controller.dart';

class CreateProductScreen extends StatelessWidget {
  CreateProductScreen({super.key});

  // কন্ট্রোলার ইনজেক্ট করা
  final CreateProductController controller = Get.put(CreateProductController());

  // টেক্সট এডিট কন্ট্রোলার (ইউজার ইনপুট নেওয়ার জন্য)
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Product"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Product Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            // প্রোডাক্টের নাম
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Product Title",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.shopping_bag),
              ),
            ),
            const SizedBox(height: 15),

            // প্রোডাক্টের দাম
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Price",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
            const SizedBox(height: 15),

            // প্রোডাক্টের বর্ণনা
            TextField(
              controller: descController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
              ),
            ),
            const SizedBox(height: 30),

            // সাবমিট বাটন
            Obx(() => SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: controller.isLoading.value
                    ? null
                    : () {
                  // বাটন ক্লিক করলে কন্ট্রোলারের ফাংশন কল হবে
                  if(titleController.text.isNotEmpty && priceController.text.isNotEmpty) {
                    controller.createProduct(
                        titleController.text,
                        int.parse(priceController.text),
                        descController.text,
                        1, // Category ID (ডিফল্ট ১ দিলাম)
                        ["https://placeimg.com/640/480/any"] // ডামি ইমেজ
                    );
                  } else {
                    Get.snackbar("Warning", "Please fill all fields");
                  }
                },
                child: controller.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("CREATE PRODUCT",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            )),

            const SizedBox(height: 20),

            // ডাটা সফলভাবে তৈরি হলে নিচে আইডি দেখাবে
            Obx(() {
              if (controller.createdProduct.value != null) {
                return Container(
                  padding: const EdgeInsets.all(15),
                  color: Colors.green.shade50,
                  child: Text(
                    "Success! Product ID: ${controller.createdProduct.value!.id} has been created.",
                    style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                );
              }
              return const SizedBox();
            }),
          ],
        ),
      ),
    );
  }
}