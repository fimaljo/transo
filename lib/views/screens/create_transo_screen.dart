import 'package:flutter/material.dart';
import 'package:transo/views/widgets/input_field.dart';

import '../../helpers/constents.dart';
import '../widgets/custome_header.dart';

class CreateTransoScreen extends StatelessWidget {
  const CreateTransoScreen({super.key});

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
                      heading: "Title",
                      hight: 50,
                    ),
                    InputField(
                      heading: "Vision or Target",
                      hight: 150,
                    ),
                    InputField(
                      heading: "Current Status",
                      hight: 150,
                    ),
                    InputField(
                      heading: "Total Days",
                      hight: 50,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(126, 37, 150, 190),
                        fixedSize: Size(size.width * 0.4, 50),
                      ),
                      onPressed: () {
                        // Navigator.pushNamed(context, '${actions.url}');
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
