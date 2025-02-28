import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restapi/module-13/utils/urls.dart';

class ProductController{
  List products = [];
  Future<void>fetchProducts() async{
    final response = await http.get(Uri.parse(Urls.readProduct));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      products = data['data'];
    } else {
      throw Exception('Failed to load products');
    }
}
}