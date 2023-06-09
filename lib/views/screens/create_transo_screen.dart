import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:transo/models/transo_create_model.dart';
import 'package:transo/provider/local_db_provider.dart';
import 'package:transo/views/widgets/input_field.dart';

import '../../helpers/constents.dart';
import '../widgets/custome_header.dart';

class CreateTransoScreen extends StatefulWidget {
  const CreateTransoScreen({super.key, this.id});
  final int? id;
  @override
  State<CreateTransoScreen> createState() => _CreateTransoScreenState();
}

class _CreateTransoScreenState extends State<CreateTransoScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _targetController;

  late final TextEditingController _statusController;
  late final TextEditingController _totalDaysController;
  late TransoProvider _provider;

  // final _crudStorage = LocalDB("db");
  @override
  void initState() {
    super.initState();
    _provider = Provider.of(context, listen: false);

    if (widget.id == null) {
      _titleController = TextEditingController();
      _targetController = TextEditingController();
      _statusController = TextEditingController();
      _totalDaysController = TextEditingController();
    } else {
      TransformationModel obj = _provider.transoCreateList
          .firstWhere((element) => element.id == widget.id);
      _titleController = TextEditingController(text: obj.title);
      _targetController = TextEditingController(text: obj.target);
      _statusController = TextEditingController(text: obj.currentStatus);
      _totalDaysController = TextEditingController(text: obj.totalDays);
    }
  }

  saveData() async {
    await _provider.insertData(_titleController.text, _targetController.text,
        _statusController.text, _totalDaysController.text);
    await _provider.readData();
    if (!mounted) return;
    Navigator.pop(context);
  }

  updateData() async {
    await _provider.updateData(_titleController.text, _targetController.text,
        _statusController.text, _totalDaysController.text, widget.id!);
    await _provider.readData();
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _targetController.dispose();
    _statusController.dispose();
    _totalDaysController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  // Database? _db;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomeHeader(
                  text: "Create",
                  ontap: () {},
                ),
                Constants.sizeH30,
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 15, top: 30),
                  child: Column(
                    children: [
                      InputField(
                        nameController: _titleController,
                        heading: "Title",
                        height: 50,
                        radius: 10,
                        validationMessage: "Enter title",
                      ),
                      InputField(
                        nameController: _targetController,
                        heading: "Vision or Target",
                        height: 150,
                        validationMessage: "Enter Target",
                      ),
                      InputField(
                        nameController: _statusController,
                        heading: "Current Status",
                        height: 150,
                        validationMessage: "Enter Current Status",
                      ),
                      InputField(
                        nameController: _totalDaysController,
                        heading: "Total Days",
                        height: 50,
                        radius: 10,
                        validationMessage: "Enter Total Days",
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                      widget.id == null
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(126, 37, 150, 190),
                                fixedSize: Size(size.width * 0.4, 50),
                              ),
                              onPressed: () {
                                if (_titleController.text.isNotEmpty &&
                                    _statusController.text.isNotEmpty &&
                                    _targetController.text.isNotEmpty &&
                                    _totalDaysController.text.isNotEmpty) {
                                  saveData();
                                } else {
                                  Constants.showSnackBar("Fill All Data");
                                }
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
                                if (_titleController.text.isNotEmpty &&
                                    _statusController.text.isNotEmpty &&
                                    _targetController.text.isNotEmpty &&
                                    _totalDaysController.text.isNotEmpty) {
                                  updateData();
                                  Navigator.pop(context);
                                } else {
                                  Constants.showSnackBar("Fill All Data");
                                }
                              },
                              child: Text(
                                'Update',
                                style: Constants.poppinsFont.copyWith(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                      Constants.sizeH30,
                    ],
                  ),
                ),
              ],
            ).animate().move(),
          ),
        ),
      ),
    );
  }
}
