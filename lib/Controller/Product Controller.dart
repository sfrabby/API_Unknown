import 'dart:convert';
import 'dart:developer';
import 'package:api_unknown/Model/GetProductModel.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';



class GetProductController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    GetProduct();
  }

  RxBool isLoading = false.obs;

  RxList<GetProductModel> ProductList = <GetProductModel>[].obs;

  Future<List<GetProductModel>?> GetProduct() async {
    isLoading.value = true;
    try {
      var url = Uri.parse(" https://api.escuelajs.co/api/v1/products");
      var response = await http.get(url);
      if(response.statusCode == 200){
        List<GetProductModel> JsonData = jsonDecode(response.body);
        ProductList.value = JsonData.map((X)=>GetProductModel.fromJson( X as Map<String, dynamic>)).toList();


        return ProductList;

      }
      else{return null;}

    } catch (error) {
      log(error.toString());
    }finally {isLoading.value = false;}
  }
}
