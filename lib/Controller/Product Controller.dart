import 'dart:convert';
import 'dart:developer';
import 'package:api_unknown/Model/GetProductModel.dart'; // পাথ ঠিক আছে কি না দেখে নিন
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class GetProductController extends GetxController {
  // ১. অবজারভেবল ভ্যারিয়েবল
  RxBool isLoading = false.obs;
  RxList<GetProductModel> productList = <GetProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getProduct(); // অ্যাপ শুরুতেই ডাটা কল করবে
  }

  Future<void> getProduct() async {
    try {
      isLoading.value = true;

      var url = Uri.parse("https://api.escuelajs.co/api/v1/products");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        // ২. ডাটা ডিকোড করা
        List<dynamic> jsonData = jsonDecode(response.body);

        // ৩. মডেলে কনভার্ট করা (নিরাপদ উপায়)
        productList.assignAll(
            jsonData.map((item) => GetProductModel.fromJson(item)).toList()
        );

        log("Data Loaded: ${productList.length} items");
      } else {
        log("Server Error: ${response.statusCode}");
      }
    } catch (error) {
      log("Fetch Error: ${error.toString()}");
      // ইউজারকে মেসেজ দেখানোর জন্য Get.snackbar ব্যবহার করতে পারেন
      Get.snackbar("Error", "ডাটা লোড করতে সমস্যা হয়েছে");
    } finally {
      isLoading.value = false;
    }
  }
}