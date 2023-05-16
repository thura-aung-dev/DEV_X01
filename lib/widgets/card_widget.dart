import 'package:dev_01/models/gallery_model.dart';
import 'package:dev_01/widgets/gallery_image.dart';
import 'package:flutter/material.dart';

//ignore:must_be_immutable
class CardWidget extends StatelessWidget {
  Gallery? gallery;
  CardWidget({Key? key, this.gallery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      child: Stack(
        children: [
          GalleryImage(gallery: gallery),
          Center(
              child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                      width: 80,
                      height: 20,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          )),
                      child: Center(child: Text("Album ID: ${gallery?.albumId}")))))
        ],
      ),
    );
  }
}
