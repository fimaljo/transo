import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:transo/helpers/constents.dart';
import 'package:transo/views/widgets/input_field.dart';

import '../../helpers/image_helper.dart';
import '../../models/transo_details_create_model.dart';
import '../../provider/local_db_provider.dart';
import '../widgets/custome_header.dart';

class CreateTransoProgressScreen extends StatefulWidget {
  const CreateTransoProgressScreen(
      {super.key, required this.dayCount, required this.trasoId, this.id});
  final int dayCount;
  final int trasoId;
  final int? id;
  @override
  State<CreateTransoProgressScreen> createState() =>
      _CreateTransoProgressScreenState();
}

class _CreateTransoProgressScreenState
    extends State<CreateTransoProgressScreen> {
  late final TextEditingController _statusController;

  late TransoProvider _provider;
  String path = "";
  @override
  void initState() {
    super.initState();
    _provider = Provider.of(context, listen: false);

    if (widget.id == null) {
      _statusController = TextEditingController();
    } else {
      TransoCreateDetailsModel obj = _provider.transoDetailsCreateListT
          .firstWhere((element) => element.id == widget.id);

      _statusController = TextEditingController(text: obj.currentStatus);
      setState(() {
        path = obj.imagePath;
      });
    }
  }

  //late ConfettiController _controllerBottomCenter;
  String? _file;
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

  saveData(String path) async {
    await _provider.insertDeatilsData(_statusController.text,
        widget.dayCount.toString(), path, widget.trasoId);
    // await _provider.readData();
    Navigator.pop(context);
  }

  updateData(String path) async {
    await _provider.updateDetailsData(_statusController.text, path, widget.id!);
    // await _provider.readData();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
          child: Column(
            children: [
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: ConfettiWidget(
              //     confettiController: _controllerBottomCenter,
              //     blastDirection: -pi / 2,
              //     emissionFrequency: 0.2,
              //     numberOfParticles: 20,
              //     blastDirectionality: BlastDirectionality.explosive,
              //     gravity: 0.1,
              //   ),
              // ),
              CustomeHeader(
                text: "Day ${widget.dayCount}",
                ontap: () {},
              ),
              Constants.sizeH30,

              Align(
                alignment: Alignment.center,
                child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: 330,
                    width: 250,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(126, 37, 150, 190),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: _file == null
                        ? widget.id == null
                            ? Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style: Constants.poppinsFont.copyWith(
                                            color: Constants.scaffoldColor,
                                            fontSize: 32,
                                            fontWeight: FontWeight.w100),
                                        children: const <TextSpan>[
                                          TextSpan(
                                            text: 'Add Your Progress ',
                                          ),
                                          TextSpan(text: 'Image Here Buddy'),
                                        ],
                                      ),
                                    ),
                                    Constants.sizeH30,
                                    InkWell(
                                      onTap: () {
                                        _selectImage(context);
                                      },
                                      child: Container(
                                        height: 60,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                        child: Center(
                                          child: Container(
                                            height: 40,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              color: Colors.orange,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ))
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  child: Column(
                                    children: [
                                      Image.file(
                                        File(
                                          path,
                                        ),
                                        fit: BoxFit.cover,
                                        height: 230,
                                        width: 250,
                                      ),
                                      Constants.sizeH20,
                                      InkWell(
                                        onTap: () {
                                          _selectImage(context);
                                        },
                                        child: Container(
                                          height: 60,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border:
                                                Border.all(color: Colors.black),
                                          ),
                                          child: Center(
                                            child: Container(
                                              height: 40,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                color: Colors.orange,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              child: Image.file(
                                File(
                                  _file!,
                                ),
                                fit: BoxFit.cover,
                                height: 330,
                                width: 250,
                              ),
                            ),
                          )),
              ),

              Constants.sizeH50,

              InputField(
                nameController: _statusController,
                heading: "Current Status",
                hight: 150,
              ),
              widget.id == null
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(126, 37, 150, 190),
                        fixedSize: Size(size.width * 0.4, 50),
                      ),
                      onPressed: () {
                        saveData(_file ?? "No");

                        _provider.readData();
                        _provider.readDetailsData();
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
                        backgroundColor: Color.fromARGB(126, 37, 150, 190),
                        fixedSize: Size(size.width * 0.4, 50),
                      ),
                      onPressed: () {
                        updateData(_file ?? path);

                        _provider.readData();
                        _provider.readDetailsData();
                      },
                      child: Text(
                        'Update',
                        style: Constants.poppinsFont.copyWith(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
