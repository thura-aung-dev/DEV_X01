import 'package:dev_01/state/cotroller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//ignore:must_be_immutable
class TotalItem extends StatelessWidget {
  CartController?  cotroller;
  final format= NumberFormat.simpleCurrency();

  TotalItem({
    Key? key, required this.cotroller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                const Text("Total",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                Text(format.format(cotroller?.calCart()).toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
              ],
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                const Text("Shipping Fee",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16),),
                Text(format.format(cotroller?.shipFee()).toString(),style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 16)),
              ],
            ),
            const Padding(
             padding:  EdgeInsets.only(top:8.0,bottom: 8.0),
             child: Divider(height: 3,),
           ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                const Text("Sub Total",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                Text((format.format(cotroller?.calCart()+cotroller?.shipFee())).toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}