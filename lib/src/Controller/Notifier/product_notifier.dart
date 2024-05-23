import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:productapp/src/Model/produt_model.dart';
import 'package:productapp/src/Network/api_service.dart';
import 'package:http/http.dart'as http;

import '../../Model/sort_model.dart';

class ProductNotifier extends ChangeNotifier {
  List<dynamic> products = [];

  List<dynamic> productssearch = [];

  List<String> myCategories = [];

  String selectedCategory = "All";
  int page = 1;
  int limit= 10;

  bool isLoadMore= true;

  bool showList = false;
  bool showshort = false;
  bool  isSelect = false;
  int ?selectedIndex;
  ScrollController scrollController = ScrollController();
 TextEditingController search = TextEditingController();





 List<ShortModel> sortmodel =[
    ShortModel(title: "Assendind- desending", isCheck: false),
    ShortModel(title: "relevance", isCheck: false),
    ShortModel(title: "Newest First", isCheck: false),
    ShortModel(title: "popularity", isCheck: false),
    ShortModel(title: "price- high to low ", isCheck: false),
    ShortModel(title: "price- low to high ", isCheck: false),

  ];
    SelectItem(index){
      selectedIndex = index;
      //selectedIndex = selectedIndex == index ? -1 : index;
      sortmodel[index].isCheck= !sortmodel[index].isCheck!;
    //  sortmodel[index].isCheck=true;
     // isSelect =! isSelect;
      //print("short${sortmodel[index].isCheck}");
      notifyListeners();
    }

  Showsorting(){
    showshort=!showshort;
    print(showshort);
    notifyListeners();
  }

  show() {
    showList = !showList;
    notifyListeners();
  }

  initState() async {

    fetchCategories();
    fetchCategorieProducts("All");
   // scrollController.addListener(scroll);
notifyListeners();

/// pagination

/*    scrollController.addListener((){
      print("sctoll");
      if(scrollController.position.maxScrollExtent==scrollController.offset){
    page++;
print("${page}");
     fetchCategorieProducts("All");
      }

    });
    scrollController = ScrollController()..addListener(loadmore);


  }
  loadmore(){
    print("scroll");*/
  }

/// fetch product
  void fetchCategorieProducts(String category) async {
    Uri url = Uri.parse("https://dummyjson.com/products");
    try {
      final response = await http.get(url);
      final List<dynamic> data = json.decode(response.body)[
      "products"];
      /* page++;
       notifyListeners();
      print("page${page}")*/;
      if(data.length<limit){
        isLoadMore = false;
        notifyListeners();
      }
      final List<dynamic> categorieProducts = [];

      for (var prdouct in data) {
        final String productCategory = prdouct["category"];
        if (category == "All" || productCategory == category) {
          categorieProducts.add(prdouct);
        }else{

          notifyListeners();
        }
      }

      selectedCategory = category;
      notifyListeners();
      products = categorieProducts;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
/// fetch category
  Future<void> fetchCategories() async {
    Uri url = Uri.parse("https://dummyjson.com/products");
    try {
      final response = await http.get(url);
      final List<dynamic> data = json.decode(response.body)[
      "products"]; // name must be same from api otherwis you got error
      final List<String> fetchdeCategories = [
        "All"
      ]; // first we display all the api data in all category section

      for (var prdouct in data) {
        final String category = prdouct["category"];
        if (!fetchdeCategories.contains(category)) {
          fetchdeCategories.add(category);
        }
      }

      myCategories = fetchdeCategories;
      notifyListeners();
      print("ctagory${myCategories.length}");
    } catch (e) {
      print(e);
    }
  }


/// search product
  void searchProducts(String query) {
    if (query.isEmpty) {
      productssearch = [];
    } else {
      productssearch = products
          .where((product) =>
          product['title'].toLowerCase().contains(query.toLowerCase())||product["description"].toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

}


