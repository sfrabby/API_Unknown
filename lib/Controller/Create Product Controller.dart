import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../Model/Create Product Model.dart';

class CreateProductController extends GetxController {
  RxBool isLoading = false.obs;

  // নতুন তৈরি হওয়া প্রোডাক্টের ডাটা এখানে জমা থাকবে
  Rx<CreateProductModel?> createdProduct = Rx<CreateProductModel?>(null);

  // প্রোডাক্ট তৈরি করার ফাংশন
  Future<void> createProduct(String title, int price, String desc, int categoryId, List<String> images) async {
    try {
      isLoading.value = true;

      var url = Uri.parse("https://api.escuelajs.co/api/v1/products/");

      // ১. বডি তৈরি (যা API-তে পাঠাতে হবে)
      Map<String, dynamic> bodyData = {
        "title": title,
        "price": price,
        "description": desc,
        "categoryId": categoryId,
        "images": images
      };

      // ২. POST রিকোয়েস্ট পাঠানো
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(bodyData),
      );

      if (response.statusCode == 201) { // প্রোডাক্ট তৈরি হলে সাধারণত 201 কোড আসে
        var decodedData = jsonDecode(response.body);

        // ৩. রেসপন্স ডাটাকে মডেলে কনভার্ট করা
        createdProduct.value = CreateProductModel.fromJson(decodedData);

        Get.snackbar("Success", "প্রোডাক্ট সফলভাবে তৈরি হয়েছে!");
        log("New Product ID: ${createdProduct.value?.id}");
      } else {
        log("Server Error: ${response.statusCode} - ${response.body}");
        Get.snackbar("Error", "সার্ভার এরর: ${response.statusCode}");
      }
    } catch (error) {
      log("Error: $error");
      Get.snackbar("Error", "কিছু একটা ভুল হয়েছে!");
    } finally {
      isLoading.value = false;
    }
  }
}