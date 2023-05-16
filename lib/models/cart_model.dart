import 'package:dev_01/models/gallery_model.dart';

class CartModel extends Gallery {
  int quantity = 0;
  CartModel(
      {required super.albumId,
      required super.id,
      required super.title,
      required super.url,
      required super.thumbnailUrl,
      required this.quantity});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    final gallery = Gallery.fromJson(json);
    final quantity = json['quantity'];
    return CartModel(
        albumId: gallery.albumId,
        id: gallery.id,
        title: gallery.title,
        url: gallery.url,
        thumbnailUrl: gallery.thumbnailUrl,
        quantity: quantity);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['albumId'] = albumId;
    data['id'] = id;
    data['title'] = title;
    data['url'] = url;
    data['thumbnailUrl'] = thumbnailUrl;
    data['quantity'] = quantity;
    return data;
  }
}
