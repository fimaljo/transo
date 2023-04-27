import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:transo/helpers/constents.dart';
import 'package:transo/views/widgets/input_field.dart';

import '../widgets/custome_header.dart';

class CreateTransoProgressScreen extends StatelessWidget {
  const CreateTransoProgressScreen({super.key, required this.dayCount});
  final int dayCount;

  //late ConfettiController _controllerBottomCenter;
  // @override
  // void initState() {
  //   super.initState();

  //   _controllerBottomCenter =
  //       ConfettiController(duration: const Duration(seconds: 1));
  //   _controllerBottomCenter.play();
  // }

  // @override
  // void dispose() {
  //   _controllerBottomCenter.dispose();
  //   super.dispose();
  // }

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
                text: "Day $dayCount",
              ),
              Constants.sizeH30,

              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  height: 350,
                  width: 250,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(126, 37, 150, 190),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
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
                          onTap: () {},
                          child: Container(
                            height: 60,
                            width: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black),
                            ),
                            child: Center(
                              child: Container(
                                height: 40,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Constants.sizeH50,
              // const InputField(
              //   heading: "Current Status",
              //   hight: 150,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
