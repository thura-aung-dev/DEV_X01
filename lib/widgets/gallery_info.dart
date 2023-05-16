import 'dart:convert';
import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dev_01/models/cart_model.dart';
import 'package:dev_01/models/gallery_model.dart';
import 'package:dev_01/screen/cart_detail.dart';
import 'package:dev_01/state/cotroller.dart';
import 'package:dev_01/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

//ignore:must_be_immutable
class GalleryInfo extends StatefulWidget {
  Gallery? gallery;
  GalleryInfo({Key? key, this.gallery}) : super(key: key);

  @override
  State<GalleryInfo> createState() => _GalleryInfoState();
}

class _GalleryInfoState extends State<GalleryInfo> {
  final controller = Get.put(CartController());
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var data = await box.read(cartKey);
      if (data.length != 0 && data.isNotEmpty) {
        final listCart = jsonDecode(data) as List<dynamic>;
        final listData =
            listCart.map((item) => CartModel.fromJson(item)).toList();
        if (listData.isNotEmpty) {
          controller.cart.value = listData;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text("Album ID${widget.gallery!.albumId}")),
      body: FutureBuilder(
          future: readData(),
          builder: (content, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var list = (snapshot.data ?? []) as List<Gallery>;
              var album = list
                  .where(
                      (element) => element.albumId == widget.gallery!.albumId)
                  .toList();
              return Padding(
                padding: const EdgeInsets.all(8),
                child: ListView.builder(
                    itemCount: album.length,
                    itemBuilder: (context, index) {
                      //return Container();
                      return Card(
                        elevation: 10,
                        child: Stack(children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 80,
                                child: CachedNetworkImage(
                                  imageUrl: "${album[index].thumbnailUrl}",
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("AlbumID: ${album[index].albumId}"),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 8.0),
                                        child: Text("ID: ${album[index].id}"),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 0.0, bottom: 8.0),
                                        child:
                                            Text('Cost: \$ ${album[index].id}'),
                                      ),
                                      Text(
                                        "${album[index].title}",
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () async {
                                var cartItem = CartModel(
                                    albumId: album[index].albumId,
                                    id: album[index].id,
                                    title: album[index].title,
                                    url: album[index].url,
                                    thumbnailUrl: album[index].thumbnailUrl,
                                    quantity: 1);
                                //print(isExists(controller.cart, cartItem));
                                if (!isExists(controller.cart, cartItem)) {
                                  controller.cart.add(cartItem);
                                  var json = jsonEncode(controller.cart);
                                  await box.write(cartKey, json);
                                  controller.cart.refresh(); //update
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.add),
                              ),
                            ),
                          )
                        ]),
                      );
                    }),
              );
            }
          }),
      floatingActionButton: Obx(() => badges.Badge(
        position: badges.BadgePosition.custom(top: -5, end: 2),
            badgeAnimation: const badges.BadgeAnimation.fade(),
            showBadge: true,
            badgeStyle: const badges.BadgeStyle(badgeColor: Colors.red),
            badgeContent: Text(
              controller.getQty() > 9 ? "+9" : "${controller.getQty()}",
              style: const TextStyle(color: Colors.white),
            ),
            child: FloatingActionButton(
              onPressed: () => Get.to(CartDetailScreen()),
              child: const Icon(Icons.list),
            ),
          )),
    ));
  }
}
