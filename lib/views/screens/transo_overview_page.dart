import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import 'package:transo/helpers/constents.dart';
import 'package:transo/views/screens/create_trano_progress_screen.dart';
import 'package:transo/views/widgets/custome_header.dart';

class TransoOverView extends StatelessWidget {
  const TransoOverView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final array = [];
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    array.add(
      1,
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return CreateTransoProgressScreen(
                dayCount: 1,
              );
            },
          ));
        },
        child: Center(
          child: Icon(Icons.add),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomeHeader(
                text: "OverView",
              ),
              Constants.sizeH30,
              Text(
                "Title",
                style: Constants.poppinsFont.copyWith(
                    color: Constants.scaffoldColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              Constants.sizeH30,
              // Align(
              //   alignment: Alignment.center,
              //   child: Container(
              //     margin: const EdgeInsets.only(right: 10),
              //     height: 250,
              //     width: 200,
              //     decoration: BoxDecoration(
              //       color: const Color.fromARGB(126, 37, 150, 190),
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.all(15.0),
              //       child: Column(
              //         children: [
              //           RichText(
              //             text: TextSpan(
              //               style: Constants.poppinsFont.copyWith(
              //                   color: Constants.scaffoldColor,
              //                   fontSize: 32,
              //                   fontWeight: FontWeight.w100),
              //               children: const <TextSpan>[
              //                 TextSpan(
              //                   text: 'Start Your First Day',
              //                 ),
              //                 TextSpan(text: ' Buddy'),
              //               ],
              //             ),
              //           ),
              //           Constants.sizeH10,
              //           InkWell(
              //             onTap: () {
              //               Navigator.of(context).push(MaterialPageRoute(
              //                 builder: (context) {
              //                   return const CreateTransoProgressScreen(
              //                     dayCount: 1,
              //                   );
              //                 },
              //               ));
              //             },
              //             child: Container(
              //               height: 60,
              //               width: 80,
              //               decoration: BoxDecoration(
              //                 shape: BoxShape.circle,
              //                 border: Border.all(color: Colors.black),
              //               ),
              //               child: Center(
              //                 child: Container(
              //                   height: 40,
              //                   width: 80,
              //                   decoration: BoxDecoration(
              //                     color: Colors.orange,
              //                     shape: BoxShape.circle,
              //                     border: Border.all(color: Colors.black),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 350,
                width: size.width,
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 0.6,
                    aspectRatio: 1.4,
                    initialPage: 0,
                  ),
                  itemCount: 0,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      height: 400,
                      width: 200,
                      color: Colors.transparent,
                      child: FlipCard(
                        direction: FlipDirection
                            .HORIZONTAL, // set the direction of the flip animation
                        front: Container(
                          margin: const EdgeInsets.only(right: 10),
                          height: 250,
                          width: 250,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(126, 37, 150, 190),
                              borderRadius: BorderRadius.circular(20)),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                  top: 30,
                                  left: 10,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Day",
                                          style: Constants.poppinsFont.copyWith(
                                              color: Constants.scaffoldColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w200),
                                        ),
                                        SizedBox(
                                          height: 20,
                                          width: 200,
                                          child: Text(
                                            "1",
                                            style:
                                                Constants.poppinsFont.copyWith(
                                              color: Constants.scaffoldColor,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Target",
                                          style: Constants.poppinsFont.copyWith(
                                              color: Constants.scaffoldColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w200),
                                        ),
                                        SizedBox(
                                          height: 50,
                                          width: 200,
                                          child: Text(
                                            "Target gfdg fgrdgfdghihoisidgh fhsdjgdsghdjs",
                                            style:
                                                Constants.poppinsFont.copyWith(
                                              color: Constants.scaffoldColor,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Current Status",
                                          style: Constants.poppinsFont.copyWith(
                                              color: Constants.scaffoldColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w200),
                                        ),
                                        SizedBox(
                                          height: 60,
                                          width: 200,
                                          child: Text(
                                            "Target gfdg fgrdgfdghihoisidgh fhsdjgdsghdjs",
                                            style:
                                                Constants.poppinsFont.copyWith(
                                              color: Constants.scaffoldColor,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                  Icons.touch_app_outlined),
                                              Text(
                                                "Tap to See Image",
                                                style: Constants.poppinsFont
                                                    .copyWith(
                                                        color: Constants
                                                            .scaffoldColor,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w200),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        back: Container(
                            margin: const EdgeInsets.only(right: 10),
                            height: 250,
                            width: 250,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Text("data back")),
                      ),
                    );
                  },
                ),
              ),
              Constants.sizeH30,

              Wrap(
                children: array
                    .asMap()
                    .entries
                    .map(
                      (e) => Container(
                        margin: const EdgeInsets.only(right: 6, bottom: 6),
                        height: 30,
                        width: 30,
                        decoration: e.key == 2 ||
                                e.key == 4 // specify which boxes to color
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color.fromARGB(180, 2, 179, 8),
                              )
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey[200],
                              ),
                        child: Center(
                          child: Text(e.key.toString()),
                        ),
                      ),
                    )
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
