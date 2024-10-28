import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  File? pic;
  final ImagePicker picker = ImagePicker();

  Future takeimagefromcamera() async {
    final pickedfile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 1200,
      maxWidth: 1200,
      imageQuality: 100,
    );
    setState(() {
      if (pickedfile != null) {
        pic = File(pickedfile.path);
      } else {
        print("no image selected");
      }
    });
  }

  Future takeimagefromgallery() async {
    final pickedfile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1200,
      maxWidth: 1200,
      imageQuality: 100,
    );
    setState(() {
      if (pickedfile != null) {
        pic = File(pickedfile.path);
      } else {
        print("no image selected");
      }
    });
  }

  void showbottom() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ab) {
          return SafeArea(
              child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text("camera"),
                onTap: () {
                  takeimagefromcamera();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.browse_gallery),
                title: Text("gallery"),
                onTap: () {
                  takeimagefromgallery();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Acessing images",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          pic != null
              ? Image.file(
                  pic!,
                  height: MediaQuery.sizeOf(context).height / 2,
                  width: MediaQuery.sizeOf(context).width,
                  fit: BoxFit.fitWidth,
                )
              : Image.asset(
                  "assets/images/placeholder.webp",
                  height: MediaQuery.sizeOf(context).height / 2,
                  width: MediaQuery.sizeOf(context).width,
                  fit: BoxFit.fitWidth,
                ),
          SizedBox(
            height: 40,
          ),
          SizedBox(
            width: 250,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                onPressed: () {
                  showbottom();
                },
                child: Text(
                  "Pick a Image",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
