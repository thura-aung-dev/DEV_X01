import 'package:cached_network_image/cached_network_image.dart';
import 'package:dev_01/models/gallery_model.dart';
import 'package:dev_01/widgets/gallery_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//ignore:must_be_immutable
class GalleryImage extends StatelessWidget {
  Gallery? gallery;
  GalleryImage({Key? key, this.gallery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.to(GalleryInfo(gallery: gallery));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: CachedNetworkImage(
            imageUrl: "${gallery!.url}",
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => const Icon(Icons.image),
            progressIndicatorBuilder: (context, url, progress) => const Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: CircularProgressIndicator(),
                )),
          ),
        ));
  }
}
