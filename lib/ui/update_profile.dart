import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traval/const/appstyle.dart';
import 'package:traval/const/text_field.dart';
import 'package:traval/ui/home.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController adrController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  List<String> gender = ["Male", "Female", "Other"];

  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null)
      setState(() {
        dobController.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
  }

  sendUserDataToDB() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-form-data");
    return _collectionRef
        .doc(currentUser!.email)
        .set({
          "name": nameController.text,
          "phone": phoneController.text,
          "dob": dobController.text,
          "gender": genderController.text,
          "adr": adrController.text,
          "pImage": _image.toString(),
        })
        .then((value) =>
            Navigator.push(context, MaterialPageRoute(builder: (_) => Home())))
        .catchError((error) => print("something is wrong. $error"));
  }

  File? _image;
  final picker = ImagePicker();

  Future getImageGallery() async {
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (PickedFile != null) {
        _image = File(PickedFile.path);
      } else {
        print("No Image Seleted");
      }
    });
  }

  Future getCameraImage() async {
    final PickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (PickedFile != null) {
        _image = File(PickedFile.path);
      } else {
        print("No Image Seleted");
      }
    });
  }

  void dialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            content: Container(
              height: 120,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      getCameraImage();
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      leading: Icon(Icons.camera_alt),
                      title: Text("Camera"),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      getImageGallery();
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text("gallery"),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: bgColor,
        centerTitle: true,
        title: Text("Update Profile"),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  dialog(context);
                },
                child: Center(
                  child: Container(
                    margin: EdgeInsets.all(16),
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF8E8E93),
                    ),
                    child: _image == null
                        ? Padding(
                            padding: EdgeInsets.all(32),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.camera_alt),
                                SizedBox(height: 5),
                                Text(
                                  "Upload Image",
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: FileImage(_image!),
                          ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              CustomeTextField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Required";
                  }
                },
                title: "Name",
                hintText: "Enter Your Name",
                controller: nameController,
                icon: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Icon(
                    Icons.person,
                    color: Color(0xFF8A8A8E),
                  ),
                ),
              ),
              SizedBox(height: 8),
              CustomeTextField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Required";
                  }
                },
                title: "Gender",
                hintText: "Gender",
                controller: genderController,
                sicon: DropdownButton<String>(
                  items: gender.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                      onTap: () {
                        setState(() {
                          genderController.text = value;
                        });
                      },
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
                icon: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Icon(
                    Icons.male,
                    color: Color(0xFF8A8A8E),
                  ),
                ),
              ),
              SizedBox(height: 8),
              CustomeTextField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Required";
                  }
                },
                title: "Phone Number",
                hintText: "+880",
                controller: phoneController,
                icon: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Icon(
                    Icons.phone,
                    color: Color(0xFF8A8A8E),
                  ),
                ),
              ),
              SizedBox(height: 8),
              CustomeTextField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Required";
                  }
                },
                title: "Dath of Birthday",
                hintText: "Enter Your Birthday",
                controller: dobController,
                sicon: IconButton(
                  onPressed: () => _selectDateFromPicker(context),
                  icon: Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.white,
                  ),
                ),
                icon: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Icon(
                    Icons.timer,
                    color: Color(0xFF8A8A8E),
                  ),
                ),
              ),
              SizedBox(height: 8),
              CustomeTextField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Required";
                  }
                },
                title: "Address",
                hintText: "Enter Your Address",
                controller: adrController,
                icon: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Icon(
                    Icons.location_pin,
                    color: Color(0xFF8A8A8E),
                  ),
                ),
              ),
              SizedBox(height: 18),
              CupertinoButton(
                onPressed: () {
                  sendUserDataToDB();
                },
                color: Color(0xFF5EDFFF),
                child: Text("Continue"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
