// import 'package:camera_deep_ar/camera_deep_ar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'dart:io';

import 'package:scan_app/pages/downloadPic.dart';

// import 'config.dart';

const apiKey =
    "ed233c386033a1ed1ef64ad92222a9cf77bc9c082c4a796177d78d3ae159ff60f836af39dae610b6";

class EditPicture extends StatefulWidget {
  EditPicture({
    Key? key,
    required this.pickedImage,
  }) : super(key: key);
  File? pickedImage;
  @override
  State<EditPicture> createState() => _EditPictureState();
}

class _EditPictureState extends State<EditPicture> {
  int selectedIndex = 0;
  bool edit = false;
  bool showColorPallete = false;
  List filters = [
    Colors.transparent,
    Colors.black54,
    Colors.blue.shade300,
    Colors.yellow.shade400,
    Colors.orange,
    Colors.pink.shade200,
    Colors.green,
    Colors.indigo,
    Colors.grey,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Center(child: const Text("Filter.It")),
        foregroundColor: Colors.black,
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          // Picture and Color Pallete
          Center(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 5.0, bottom: 0, left: 20, right: 20),
                  child: Expanded(
                    child: SizedBox(
                      height: height * .7,
                      width: 400,
                      child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              filters[selectedIndex], BlendMode.color),
                          child: Image.file(widget.pickedImage!)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                showColorPallete
                    ? SizedBox(height: 200, child: colorPallette())
                    : Container()
              ],
            ),
          )),
          // Floating Action Buttons
          Padding(
            padding: EdgeInsets.fromLTRB(
                width * .8, edit ? height * .305 : height * .5, 10, 10),
            child: Column(children: [
              edit
                  ? FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: Colors.blue,
                      child: Text("AR"),
                    )
                  : Container(),
              const SizedBox(
                height: 10,
              ),
              edit
                  ? FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.person),
                    )
                  : Container(),
              const SizedBox(
                height: 10,
              ),
              edit
                  ? FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          showColorPallete = !showColorPallete;
                        });
                      },
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.color_lens),
                    )
                  : Container(),
              const SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    edit = !edit;
                  });
                },
                backgroundColor: Colors.blue,
                child: edit ? Icon(Icons.check) : Icon(Icons.edit),
              ),
              const SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                onPressed: () {},
                backgroundColor: Colors.blue,
                child: Icon(Icons.download),
              ),
            ]),
          )
        ],
      ),
    );
  }

  Widget coloredContainer(int index) {
    return Container(height: 50, width: 50, color: filters[index]);
  }

  Widget colorPallette() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
        ),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: filters[index]),
                    color: filters[index],
                  ),
                  height: 40,
                  width: 40,
                ),
              ));
        },
      ),
    );
  }
}
