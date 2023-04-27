import 'package:flutter/material.dart';
import 'package:transo/helpers/constents.dart';

class InputField extends StatelessWidget {
  const InputField(
      {super.key,
      required this.heading,
      required this.hight,
      required this.nameController});
  final String heading;
  final double hight;
  final TextEditingController nameController;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: Constants.poppinsFont.copyWith(
                color: Constants.scaffoldColor,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: hight,
            width: size.width * 0.8,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(29)),
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              // validator: (value) =>
              //     value != null && value.length < 3 ? 'Enter Data' : null,
            ),
          ),
        ],
      ),
    );
  }
}
