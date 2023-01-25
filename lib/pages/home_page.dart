import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan_app/pages/editPicture.dart';
import 'package:scan_app/pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = const FlutterSecureStorage();
  var _timer;
  File? pickedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Center(child: const Text("Add Picture")),
        foregroundColor: Colors.black,
        backgroundColor: Colors.blue,
      ),
      // drawer: Drawer(
      //   // Add a ListView to the drawer. This ensures the user can scroll
      //   // through the options in the drawer if there isn't enough vertical
      //   // space to fit everything.
      //   child: ListView(
      //     // Important: Remove any padding from the ListView.
      //     padding: EdgeInsets.zero,
      //     children: [
      //       const DrawerHeader(
      //           decoration: BoxDecoration(
      //             color: Colors.blue,
      //           ),
      //           child: Center(
      //             child: Text('Profile'),
      //           )),
      //       ListTile(
      //         title: Center(child: const Text('Log Out')),
      //         onTap: () async => {
      //           await FirebaseAuth.instance.signOut(),
      //           await storage.delete(key: "uid"),
      //           Navigator.pushAndRemoveUntil(
      //               context,
      //               MaterialPageRoute(builder: (context) => const LoginPage()),
      //               ((route) => false))
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        pickImage(ImageSource.camera);
                      },
                      child: Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.blueAccent,
                                blurRadius: 12.0,
                              ),
                            ],
                          ),
                          child: Center(
                            child: const Icon(Icons.camera_alt_outlined),
                          )),
                    ),
                    const SizedBox(width: 40),
                    GestureDetector(
                      onTap: () {
                        pickImage(ImageSource.gallery);
                      },
                      child: Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.blueAccent,
                                blurRadius: 12.0,
                              ),
                            ],
                          ),
                          child: Center(
                            child: const Icon(Icons.photo_album_outlined),
                          )),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Container(
                  child: pickedImage != null
                      ? CircleAvatar(
                          radius: 200,
                          backgroundColor: Colors.blue,
                          child: CircleAvatar(
                            backgroundImage: FileImage(pickedImage!),
                            radius: 198,
                          ),
                        )
                      : const CircleAvatar(
                          radius: 200,
                          backgroundColor: Colors.blue,
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/camera.png'),
                            radius: 198,
                          ),
                        ),
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
                    if (pickedImage == null) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              content: Padding(
                                  padding: EdgeInsets.only(left: 25),
                                  child: Text("Please Select an Image")),
                            );
                          });
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditPicture(
                                  pickedImage: pickedImage,
                                )),
                      );
                    }
                  },
                  child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.blueAccent,
                            blurRadius: 12.0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: const Text(
                          "Edit",
                          style: TextStyle(fontSize: 20),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
        print("$pickedImage");
      });
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
