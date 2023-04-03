import 'package:automobile_management/Widgets/custom_toast.dart';
import 'package:automobile_management/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductApi extends ChangeNotifier {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static const String _collection = 'product';
  List<Product> product = <Product>[];

  Future<bool> add(Product product) async {
    try {
      await _instance
          .collection(_collection)
          .doc(product.pid)
          .set(product.toMap());
      CustomToast.successToast(message: 'Successfully Added');
      notifyListeners();
      return true;
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
      return false;
    }
  }

  Future<List<Product>> getdata() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _instance.collection(_collection).get();
    for (DocumentSnapshot<Map<String, dynamic>> e in snapshot.docs) {
      product.add(Product.fromMap(e));
    }
    notifyListeners();
    return product;
  }

  Future<List<Product>> getSearchResults(String text) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _instance
        .collection(_collection)
        .where('product_name', isGreaterThanOrEqualTo: text)
        .get();
    print('here');
    product.clear();
    print(snapshot.docs);
    for (DocumentSnapshot<Map<String, dynamic>> e in snapshot.docs) {
      product.add(Product.fromMap(e));
    }
    notifyListeners();
    return product;
  }
}
