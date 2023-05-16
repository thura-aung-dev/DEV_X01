// ignore_for_file: invalid_use_of_protected_member
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dev_01/state/cotroller.dart';
import 'package:dev_01/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../widgets/total_item.dart';

class CartDetailScreen extends StatelessWidget {
  final box = GetStorage();
  final controller = Get.put(CartController());

  CartDetailScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          InkWell(
            onTap: () => controller.cart.clear(),
            child: const Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Icon(Icons.delete_forever),
            ),
          )
        ],
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
                child: controller.cart.isEmpty
                    ? const Center(
                        child: Text("No Item."),
                      )
                    : ListView.builder(
                        itemCount: controller.cart.value.length,
                        itemBuilder: (context, index) {
                          return Slidable(
                            endActionPane: ActionPane(
                              dragDismissible: false,
                              motion: const ScrollMotion(),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: InkWell(
                                    onTap: () => {
                                      calQty(controller.cart, 'remove', index),
                                      controller.cart.refresh()
                                    },
                                    child: const SizedBox(
                                      height: 80,
                                      width: 30,
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            child: Card(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 6.0),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "${controller.cart.value[index].thumbnailUrl}",
                                      ),
                                    ),
                                    Expanded(
                                        flex: 4,
                                        child: Container(
                                          padding: const EdgeInsets.all(6),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  'AlbumID: ${controller.cart.value[index].albumId}'),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0, bottom: 8.0),
                                                child: Text(
                                                    'ID: ${controller.cart.value[index].id}'),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 0.0, bottom: 8.0),
                                                child: Text(
                                                    'Cost: \$ ${controller.cart.value[index].id}'),
                                              ),
                                              Text(
                                                'Title: ${controller.cart.value[index].title}',
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            ],
                                          ),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: () => {
                                                  calQty(controller.cart, 'add',
                                                      index),
                                                  controller.cart.refresh()
                                                },
                                                child: Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration:
                                                        const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.blue),
                                                    child: const Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                    )),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0,
                                                    bottom: 8.0,
                                                    left: 8.0),
                                                child: Text(
                                                    '${controller.cart.value[index].quantity}'),
                                              ),
                                              InkWell(
                                                onTap: () => {
                                                  if (controller
                                                          .cart
                                                          .value[index]
                                                          .quantity >
                                                      0)
                                                    {
                                                      calQty(controller.cart,
                                                          'sub', index),
                                                    },
                                                  if (controller
                                                          .cart
                                                          .value[index]
                                                          .quantity ==
                                                      0)
                                                    {
                                                      calQty(controller.cart,
                                                          'remove', index),
                                                    },
                                                  controller.cart.refresh()
                                                },
                                                child: Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration:
                                                        const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.red),
                                                    child: const Icon(
                                                      Icons.remove,
                                                      color: Colors.white,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        })),
            TotalItem(
              cotroller: controller,
            )
          ],
        ),
      ),
    );
  }
}
