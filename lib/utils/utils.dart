import 'dart:convert';
import 'package:dev_01/models/gallery_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import '../models/cart_model.dart';


const String cartKey = 'Cart';
Future<List<Gallery>> readData() async {
  final rawData = await rootBundle.loadString("assets/data/gallery.json");
  final list = json.decode(rawData) as List<dynamic>;
  return list.map((e) => Gallery.fromJson(e)).toList();
}

bool isExists(RxList<CartModel> cart, CartModel cartItem) {
  return cart.isEmpty
      ? false
      : cart.any((element) => element.id == cartItem.id && element.albumId== cartItem.albumId)
          ? true
          : false;
}

void calQty(RxList<CartModel> cart, String cmd, int index) {
  var box = GetStorage();
  if (cmd == 'remove') {
    cart.removeAt(index);
  } else {
    cmd == 'add'
        ? cart[index].quantity = cart[index].quantity + 1
        : cart[index].quantity = cart[index].quantity - 1;
  }
  box.write(cartKey, jsonEncode(cart));
}
