import 'dart:convert';
import 'dart:developer';
import 'package:api_unknown/Model/GetProductModel.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class GetProductController extends GetxController {
  RxBool isLoading = false.obs;

  Future<Type?> GetProduct() async {
    isLoading.value = true;
    try {
      var url = Uri.parse(" https://api.escuelajs.co/api/v1/products");
      var response = await http.get(url);
      if(response.statusCode == 200){
        List<GetProductModel> getProductModel = List<GetProductModel>.from(jsonDecode(response.body).map((x)=>GetProductModel.fromJson(x)));
        return GetProductModel;

      }
      else{return null;}

    } catch (error) {
      log(error.toString());
    }finally {isLoading.value = false;}
  }
}
