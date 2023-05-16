import 'package:dev_01/models/gallery_model.dart';
import 'package:dev_01/utils/utils.dart';
import 'package:dev_01/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const GetMaterialApp(home: HomePage()));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Gallery with GetX'),
              centerTitle: true,
            ),
            body: FutureBuilder(
              future: readData(),
              builder: (content, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  //get data from json
                  var list = snapshot.data as List<Gallery>;
                  var set = <String>{};
                  var album = list
                      .where((element) => set.add(element.albumId.toString()))
                      .toList();
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: ListView.builder(
                        itemCount: album.length,
                        itemBuilder: (context, index) {
                          return CardWidget(gallery: album[index]);
                        }),
                  );
                }
              },
            )));
  }
}
