import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:transo/helpers/constents.dart';
import 'package:transo/views/screens/edit_profile_screen.dart';
import 'package:transo/views/widgets/custome_header.dart';

import '../../helpers/image_helper.dart';
import '../../provider/local_db_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransoProvider>(context, listen: false);

    final int activeDaysLength = provider.transoDetailsCreateList.length;
    final int count = activeDaysLength;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
          child: Column(
            children: provider.transoProfileList
                .map(
                  (e) => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomeHeader(
                        text: "Profile",
                        ontap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditProfile(
                                id: e.id,
                              ),
                            ),
                          );
                        },
                        icon: Icons.edit_note_outlined,
                      ),
                      Constants.sizeH50,
                      Hero(
                        tag: "profile",
                        child: CircleAvatar(
                          foregroundImage: FileImage(File(e.imagePath)),
                          // NetworkImage(
                          //     "https://pbs.twimg.com/media/FjU2lkcWYAgNG6d.jpg")

                          radius: 60,
                        ),
                      ),
                      Constants.sizeH10,
                      Text(
                        e.name,
                        style: Constants.poppinsFont.copyWith(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w100),
                      ).animate(delay: Duration(milliseconds: 200)).slideX(),
                      Constants.sizeH50,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Total Transo",
                                style: Constants.poppinsFont.copyWith(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w100),
                              )
                                  .animate(delay: Duration(milliseconds: 200))
                                  .slideX(),
                              Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(41, 37, 149, 190),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: Text(
                                    provider.transoCreateList.length.toString(),
                                    style: Constants.poppinsFont.copyWith(
                                        color: Colors.black,
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold),
                                  )
                                      .animate(
                                          delay: Duration(milliseconds: 200))
                                      .slideX(),
                                ),
                              ),
                            ],
                          ),
                          Constants.sizeW10,
                          Column(
                            children: [
                              Text(
                                "Completed",
                                style: Constants.poppinsFont.copyWith(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w100),
                              )
                                  .animate(delay: Duration(milliseconds: 200))
                                  .slideX(),
                              Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: Text(
                                    e.completedCount,
                                    style: Constants.poppinsFont.copyWith(
                                        color: Colors.black,
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold),
                                  )
                                      .animate(
                                          delay: Duration(milliseconds: 200))
                                      .slideX(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Constants.sizeH30,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Active Day Count",
                            style: Constants.poppinsFont.copyWith(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w100),
                          )
                              .animate(delay: Duration(milliseconds: 200))
                              .slideX(),
                          Container(
                            height: 150,
                            width: 310,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(126, 37, 150, 190),
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Text(
                                count.toString(),
                                style: Constants.poppinsFont.copyWith(
                                    color: Colors.black,
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold),
                              )
                                  .animate(delay: Duration(milliseconds: 200))
                                  .slideX(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
