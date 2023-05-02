import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transo/helpers/constents.dart';

class InputField extends StatefulWidget {
  const InputField({
    Key? key,
    required this.heading,
    required this.height,
    required this.nameController,
    this.radius = 20,
    required this.validationMessage,
    this.keyboardType,
    this.inputFormatters,
  }) : super(key: key);

  final String heading;
  final double height;
  final TextEditingController nameController;
  final double radius;
  final String validationMessage;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _isValidationError = false;

  void _onChanged(String? value) {
    setState(() {
      _isValidationError = value?.isEmpty ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.heading,
            style: Constants.poppinsFont.copyWith(
              color: Constants.scaffoldColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Constants.sizeH10,
          Container(
            height: widget.height,
            width: size.width * 0.8,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(widget.radius),
            ),
            child: TextFormField(
              controller: widget.nameController,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              keyboardType: widget.keyboardType,
              inputFormatters: widget.inputFormatters,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  value != null && value.isEmpty ? null : null,
              onChanged: _onChanged,
            ),
          ),
          SizedBox(height: _isValidationError ? 10 : 0),
          if (_isValidationError)
            Text(
              widget.validationMessage,
              style: const TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }
}
