import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../helpers/constents.dart';
import '../../helpers/image_helper.dart';
import '../../provider/local_db_provider.dart';
import '../widgets/custome_header.dart';
import '../widgets/input_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    super.key,
    required this.id,
    required this.name,
    required this.completedCount,
    required this.imagePath,
  });
  final int? id;
  final String name;
  final String completedCount;
  final String imagePath;

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

    nameController = TextEditingController(text: widget.name);
    countController = TextEditingController(text: widget.completedCount);
  }

  saveProfile(String path, String name, String count) async {
    await _provider.insertProfileData(name, count, path);
    if (!mounted) return;
    Navigator.pop(context);
  }

  updateProfile(String path, String name, String count) async {
    await _provider.updateProfileData(name, count, path);
    if (!mounted) return;
    Navigator.pop(context);
  }

  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Add Your logo'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  String file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  String file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
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
                  backgroundImage: const AssetImage("assets/images/proPic.jpg"),
                  foregroundImage: FileImage(File(_file ?? widget.imagePath)),
                  radius: 60,
                ),
              ),
              TextButton(
                  onPressed: () {
                    _selectImage(context);
                  },
                  child: const Icon(
                    Icons.edit_note_outlined,
                    color: Colors.black,
                  )),
              InputField(
                nameController: nameController,
                heading: "Name",
                height: 50,
                radius: 10,
                validationMessage: "Enter Name",
              ),
              InputField(
                nameController: countController,
                heading: "Completed Count",
                height: 50,
                radius: 10,
                validationMessage: "Enter Completed Count",
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              _provider.transoProfileList.length == 1
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(126, 37, 150, 190),
                        fixedSize: Size(size.width * 0.4, 50),
                      ),
                      onPressed: () {
                        saveProfile(_file ?? "", nameController.text,
                            countController.text);
                        _provider.readProfileData();
                        Navigator.pop(context);
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
                        backgroundColor:
                            const Color.fromARGB(126, 37, 150, 190),
                        fixedSize: Size(size.width * 0.4, 50),
                      ),
                      onPressed: () {
                        updateProfile(_file ?? widget.imagePath,
                            nameController.text, countController.text);
                        _provider.readProfileData();
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Updates',
                        style: Constants.poppinsFont.copyWith(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
