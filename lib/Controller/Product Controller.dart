import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class GetProductController extends GetxController {
  RxBool isLoading = false.obs;

  Future<void> getProduct() async {
    isLoading.value = true;
    try {
      var url = Uri.parse(" https://api.escuelajs.co/api/v1/products");
      var response = await http.get(url);

    } catch (error) {
      log(error.toString());
    }
  }
}
