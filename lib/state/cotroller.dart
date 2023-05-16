import 'package:dev_01/models/cart_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
  var cart = List<CartModel>.empty(growable: true).obs;

  calCart(){
    return cart.isEmpty?0:cart.map((element) => double.parse(element.id.toString())*element.quantity).reduce((value, element) => value+element);
  }
  getQty(){
    return cart.isEmpty?0:cart.map((element) => double.parse(element.quantity.toString())).reduce((value, element) => value+element).ceil();
  }
  shipFee(){
    return calCart()*0.2;
  }
}