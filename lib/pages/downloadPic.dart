import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

class DownloadEditedPicture extends StatefulWidget {
  const DownloadEditedPicture({Key? key}) : super(key: key);

  @override
  State<DownloadEditedPicture> createState() => _DownloadEditedPictureState();
}

class _DownloadEditedPictureState extends State<DownloadEditedPicture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Center(child: const Text("Download Picture")),
        foregroundColor: Colors.black,
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print("taped");
          await GallerySaver.saveImage(
              'https://images.pexels.com/photos/46251/sumatran-tiger-tiger-big-cat-stripes-46251.jpeg?cs=srgb&dl=pexels-pixabay-46251.jpg&fm=jpg',
              albumName: "Filter.It");
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  content: Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Text("Download successfull")),
                );
              });
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.download),
      ),
      body: Center(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 20, left: 20, right: 20),
                  child: Image.network(
                      'https://images.pexels.com/photos/46251/sumatran-tiger-tiger-big-cat-stripes-46251.jpeg?cs=srgb&dl=pexels-pixabay-46251.jpg&fm=jpg')))),
    );
  }
}
