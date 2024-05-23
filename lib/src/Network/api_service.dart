
import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:productapp/src/Model/produt_model.dart';
class ApiService {
   int page= 1;
  Future<List<Products>> getPtoduct() async {
    List<Products> products = [];
      var totalProduct;

    try {
      final res = await http.get(Uri.parse(
          "https://dummyjson.com/products?limit=5&page=$page"));
      if (res.statusCode == 200) {
        print("code${res.statusCode}");
        var data = res.body;
        print("data${data}");
        List<dynamic> product = jsonDecode(data)["products"];
        product.forEach((element) {
          Products product = Products.fromJson(element);
          products.add(product);

        });
        return products;
      } else {
        print("Invalid data");
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}