import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:transo/provider/local_db_provider.dart';
import 'package:transo/views/widgets/input_field.dart';

import '../../helpers/constents.dart';
import '../../helpers/sql_helper.dart';
import '../widgets/custome_header.dart';

class CreateTransoScreen extends StatefulWidget {
  const CreateTransoScreen({super.key});

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
    _titleController = TextEditingController();
    _targetController = TextEditingController();
    _statusController = TextEditingController();
    _totalDaysController = TextEditingController();
    _provider = Provider.of(context, listen: false);
  }

  saveData() async {
    _provider.insertData(_titleController.text, _targetController.text,
        _statusController.text, _totalDaysController.text);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _targetController.dispose();
    _statusController.dispose();
    _totalDaysController.dispose();
    super.dispose();
  }

  // Database? _db;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomeHeader(
                text: "Create",
              ),
              Constants.sizeH30,
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 15, top: 30),
                child: Column(
                  children: [
                    InputField(
                      nameController: _titleController,
                      heading: "Title",
                      hight: 50,
                    ),
                    InputField(
                      nameController: _targetController,
                      heading: "Vision or Target",
                      hight: 150,
                    ),
                    InputField(
                      nameController: _statusController,
                      heading: "Current Status",
                      hight: 150,
                    ),
                    InputField(
                      nameController: _totalDaysController,
                      heading: "Total Days",
                      hight: 50,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(126, 37, 150, 190),
                        fixedSize: Size(size.width * 0.4, 50),
                      ),
                      onPressed: () {
                        saveData();
                      },
                      child: Text(
                        'Create',
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
          ),
        ),
      ),
    );
  }
}
