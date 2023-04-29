import 'package:flutter/material.dart';
import 'package:transo/helpers/constents.dart';

class CustomeHeader extends StatelessWidget {
  const CustomeHeader(
      {super.key,
      required this.text,
      required this.ontap,
      this.icon = Icons.more_horiz});
  final String text;
  final VoidCallback ontap;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(8)),
            child: const Center(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Text(
          text,
          style: Constants.poppinsFont.copyWith(
              color: Constants.scaffoldColor,
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: const Color.fromARGB(41, 37, 149, 190),
              borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: IconButton(onPressed: ontap, icon: Icon(icon)),
          ),
        ),
      ],
    );
  }
}
