import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../helpers/constents.dart';
import '../../helpers/image_helper.dart';
import '../../provider/local_db_provider.dart';
import '../widgets/custome_header.dart';
import '../widgets/input_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required this.id});
  final int? id;
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TransoProvider _provider;
  String? _file;
  late final TextEditingController nameController;
  late final TextEditingController countController;
  @override
  void initState() {
    super.initState();
    _provider = Provider.of(context, listen: false);
    if (widget.id == null) {
      nameController = TextEditingController();
      countController = TextEditingController();
    }
    nameController =
        TextEditingController(text: _provider.transoProfileList[0].name);
    countController = TextEditingController(
        text: _provider.transoProfileList[0].completedCount);
    _file = _provider.transoProfileList[0].imagePath;
  }

  saveProfile(String path) async {
    await _provider.insertProfileData(
        nameController.text, countController.text, path);

    Navigator.pop(context);
  }

  updateProfile(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Update Your Profile'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Press to upload Profile Photo'),
                onPressed: () async {
                  String file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                saveProfile(_file ?? "");
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
        child: Column(
          children: [
            CustomeHeader(
              text: "Edit Profile",
              ontap: () {},
            ),
            Constants.sizeH50,
            Hero(
              tag: "profile",
              child: CircleAvatar(
                foregroundImage: FileImage(File(_file == null
                    ? _provider.transoProfileList[0].imagePath
                    : _file!)),
                radius: 60,
              ),
            ),
            InputField(
              nameController: nameController,
              heading: "Name",
              hight: 50,
              radius: 10,
            ),
            InputField(
              nameController: countController,
              heading: "Completed Count",
              hight: 50,
              radius: 10,
            ),
            widget.id == null
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(126, 37, 150, 190),
                      fixedSize: Size(size.width * 0.4, 50),
                    ),
                    onPressed: () {
                      saveProfile(_file!);
                    },
                    child: Text(
                      'Create',
                      style: Constants.poppinsFont.copyWith(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(126, 37, 150, 190),
                      fixedSize: Size(size.width * 0.4, 50),
                    ),
                    onPressed: () {
                     // updateData();
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Update',
                      style: Constants.poppinsFont.copyWith(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
