import 'dart:convert';
import 'package:ecommerce_tis/app/model/customer_response_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../core/service/urls.dart';

class CustomerController extends GetxController{

  
  
  RxList<Customer> customerList=<Customer>[].obs;


   getCustomer({required String query}) async {

     final response = await http.get(Uri.parse('${baseUrl}/customers/?search_query=$query'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      final customerdata=CustomerResponse.fromJson(data);
      return    customerdata.data;

    } else {
      return [];
    }
   
    

    
    
  }



  @override
  void onInit() async {
    super.onInit();

   customerList.value= await getCustomer(query: "");
    
    
  }


  
}