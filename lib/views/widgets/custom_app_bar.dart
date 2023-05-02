
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:transo/provider/local_db_provider.dart';

import '../screens/profile_screen.dart';

class CustomeAppBar extends StatelessWidget {
  const CustomeAppBar({
    super.key,
    required this.provider,
    required this.imagePath,
  });
  final TransoProvider provider;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: const Color.fromARGB(41, 37, 149, 190),
              borderRadius: BorderRadius.circular(8)),
          child: const Center(
            child: Icon(Icons.more_horiz),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ProfileScreen(),
            ));
          },
          child: provider.transoProfileList.length != 1
              ? Hero(
                  tag: "profile",
                  child: CircleAvatar(
                    foregroundImage: FileImage(File(imagePath)),
                    radius: 30,
                  ),
                )
              : const Hero(
                  tag: "profile",
                  child: CircleAvatar(
                    foregroundImage: AssetImage("assets/images/proPic.jpg"),
                    radius: 30,
                  ),
                ),
        )
      ],
    );
  }
}