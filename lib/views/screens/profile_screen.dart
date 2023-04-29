import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:transo/helpers/constents.dart';
import 'package:transo/views/widgets/custome_header.dart';

import '../../provider/local_db_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providerForList = Provider.of<TransoProvider>(context, listen: false);
    final int activeDaysLength = providerForList.transoDetailsCreateList.length;
    final int count = activeDaysLength - 1;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomeHeader(
              text: "Profile",
              ontap: () {},
            ),
            Constants.sizeH50,
            Constants.sizeH50,
            const Hero(
              tag: "profile",
              child: const CircleAvatar(
                foregroundImage: NetworkImage(
                    "https://pbs.twimg.com/media/FjU2lkcWYAgNG6d.jpg"),
                radius: 60,
              ),
            ),
            Constants.sizeH10,
            Text(
              "Buddy",
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
                    ).animate(delay: Duration(milliseconds: 200)).slideX(),
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(41, 37, 149, 190),
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text(
                          providerForList.transoCreateList.length.toString(),
                          style: Constants.poppinsFont.copyWith(
                              color: Colors.black,
                              fontSize: 50,
                              fontWeight: FontWeight.bold),
                        ).animate(delay: Duration(milliseconds: 200)).slideX(),
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
                    ).animate(delay: Duration(milliseconds: 200)).slideX(),
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text(
                          "0",
                          style: Constants.poppinsFont.copyWith(
                              color: Colors.black,
                              fontSize: 50,
                              fontWeight: FontWeight.bold),
                        ).animate(delay: Duration(milliseconds: 200)).slideX(),
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
                ).animate(delay: Duration(milliseconds: 200)).slideX(),
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
                    ).animate(delay: Duration(milliseconds: 200)).slideX(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
