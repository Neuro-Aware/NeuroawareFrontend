import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neuroaware/controller/editprofile.controller.dart';
import 'package:neuroaware/widgets/submit_button.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late File _image = File('assets/images/logo.png');
  final imagePicker = ImagePicker();
  bool loading = false;
  EditProfileController profileController = EditProfileController();
  @override
  Future popUp() async {
    // options for image picker by gallery or camera
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose an option'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: Text('Gallery'),
                  onTap: () {
                    Navigator.pop(context, ImageSource.gallery);
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text('Camera'),
                  onTap: () {
                    Navigator.pop(context, ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              topBar(context),
              SizedBox(
                height: 10,
              ),
              profileImage(),
              SizedBox(
                height: 35,
              ),
              textFields(
                'Full Name',
                CupertinoIcons.person,
                TextInputType.name,
                false,
                Colors.black,
              ),
              SizedBox(
                height: 15,
              ),
              textFields(
                'Phone No',
                CupertinoIcons.phone,
                TextInputType.phone,
                false,
                Colors.black,
              ),
              SizedBox(
                height: 15,
              ),
              SubmitButton(
                onPressed: handleEditProfile,
                title: 'Edit Profile',
                loading: loading,
                color: Colors.black,
                radius: 20,
                textsize: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  void handleSubmission() {
    Navigator.pushNamed(context, '/profile');
  }

  // handle registration method
  void handleEditProfile() async {
    setState(() {
      loading = true; // show loading indicator
    });
    var responseDetails = await profileController.editProfileDetails();
    var responseImage = await profileController.editProfileImage(_image);
    setState(() {
      loading = false; // hide loading indicator
    });
    var messageDetail = jsonDecode(responseDetails.body);
    var messageImage = jsonDecode(responseImage.body);

    if (responseDetails.statusCode == 201 && responseImage.statusCode == 201) {
      handleSubmission();
    }
    if (responseDetails.statusCode == 400 ||
        responseDetails.statusCode == 401 ||
        responseDetails.statusCode == 404 && responseImage.statusCode == 201) {
      errorDialog(messageDetail['message']);
    }
    if (responseImage.statusCode == 400 ||
        responseImage.statusCode == 401 ||
        responseImage.statusCode == 404 && responseDetails.statusCode == 201) {
      errorDialog(messageImage['message']);
    }
    if (responseDetails.statusCode == 400 ||
        responseDetails.statusCode == 401 ||
        responseDetails.statusCode == 404 && responseImage.statusCode == 400 ||
        responseImage.statusCode == 401 ||
        responseImage.statusCode == 404) {
      errorDialog(messageDetail['message'] + messageImage['message']);
    }
    if (responseDetails.statusCode == 500 && responseImage.statusCode == 500) {
      errorDialog('Internal Server Error');
    }
  }

  void errorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  TextField textFields(String label, IconData icon, TextInputType type,
      bool obsecure, Color color) {
    return TextField(
      style: TextStyle(
        color: color,
      ),
      keyboardType: type,
      obscureText: obsecure,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 17, 20, 17),
        prefixIcon: Icon(
          icon,
          color: color,
        ),
        labelText: label,
        labelStyle: TextStyle(
          color: color,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(34),
        ),
      ),
    );
  }

  Future getImage(value) async {
    final pickedFile = await imagePicker.pickImage(source: value);

    // options for image picker by gallery or camera
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Row topBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Edit Profile',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w400,
            )),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
              padding: EdgeInsets.fromLTRB(18, 5, 18, 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                '<  Back',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              )),
        ),
      ],
    );
  }

  Stack profileImage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipOval(
          child: _image.existsSync()
              ? Image.file(_image, width: 150, height: 150, fit: BoxFit.cover)
              : Image.asset('assets/images/logo.png',
                  width: 150, height: 150, fit: BoxFit.cover),
        ),
        Positioned(
            bottom: 0,
            right: 10,
            child: GestureDetector(
              onTap: () {
                popUp().then((value) => getImage(value));
              },
              //create a pencil button to change profile image
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  CupertinoIcons.camera,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            )),
      ],
    );
  }
}
