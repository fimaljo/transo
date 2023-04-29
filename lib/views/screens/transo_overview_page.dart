import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:confetti/confetti.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import 'package:transo/helpers/constents.dart';
import 'package:transo/views/screens/create_trano_progress_screen.dart';
import 'package:transo/views/screens/create_transo_screen.dart';
import 'package:transo/views/screens/progress_slide_show.dart';
import 'package:transo/views/widgets/custome_header.dart';

import '../../models/transo_create_model.dart';
import '../../models/transo_details_create_model.dart';
import '../../provider/local_db_provider.dart';

class TransoOverView extends StatefulWidget {
  const TransoOverView(
      {super.key, required this.data, required this.totalDayCount});
  final TransformationModel data;
  final int totalDayCount;
  @override
  State<TransoOverView> createState() => _TransoOverViewState();
}

class _TransoOverViewState extends State<TransoOverView> {
  late TransoProvider _provider;
  int _selectedButtonIndex = 0;
  Timer? _timer; // add the timer variable
  final List<String> _buttonTextList = [
    'Tap to see the image',
    'Double tap to delete',
    'Long press to delete',
  ];
  late ConfettiController _controllerBottomCenter;
  @override
  void initState() {
    _provider = Provider.of(context, listen: false);
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 3));

    // Start a timer to automatically switch to the next button
    if (mounted) {
      _timer = Timer.periodic(const Duration(seconds: 2), (_) {
        setState(() {
          _selectedButtonIndex =
              (_selectedButtonIndex + 1) % _buttonTextList.length;
        });
      });
    }
    widget.totalDayCount == _provider.transoDetailsCreateListT.length
        ? setState(() {
            _controllerBottomCenter.play();
          })
        : null;
    super.initState();
  }

  @override
  void dispose() {
    _controllerBottomCenter.dispose();
    _timer?.cancel(); // cancel the timer if it's not null
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final data = Provider.of<TransoProvider>(context, listen: true);

    final array = [];
    for (var i = 0; i < widget.totalDayCount; i++) {
      array.add(i);
    }

    data.getDetails(widget.data.id);
    _selectDelete(BuildContext parentContext, int id) async {
      return showDialog(
        context: parentContext,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Delete The Progress ?'),
            children: <Widget>[
              SimpleDialogOption(
                  padding: const EdgeInsets.all(20),
                  child: const Text('Yes'),
                  onPressed: () {
                    data.deleteDetail(id);
                    _provider.readDetailsData();
                    Navigator.of(context).pop();
                  }),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        },
      );
    }

    return Scaffold(
      floatingActionButton:
          widget.totalDayCount != _provider.transoDetailsCreateListT.length
              ? FloatingActionButton(
                  backgroundColor: Colors.orange,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return CreateTransoProgressScreen(
                          dayCount: data.transoDetailsCreateListT.length + 1,
                          trasoId: widget.data.id,
                        );
                      },
                    ));
                  },
                  child: const Center(
                    child: Icon(Icons.add),
                  ),
                ).animate(delay: const Duration(seconds: 1)).moveY()
              : FloatingActionButton(
                  backgroundColor: const Color.fromARGB(126, 37, 150, 190),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return ProgressSlideShow();
                      },
                    ));
                  },
                  child: const Center(
                    child: Icon(Icons.play_arrow_outlined),
                  ),
                ).animate(delay: const Duration(seconds: 1)).moveY(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: ConfettiWidget(
                  confettiController: _controllerBottomCenter,
                  blastDirection: -pi / 2,
                  emissionFrequency: 0.2,
                  numberOfParticles: 20,
                  blastDirectionality: BlastDirectionality.explosive,
                  gravity: 0.1,
                ),
              ),
              CustomeHeader(
                text: "OverView",
                ontap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return CreateTransoScreen(
                        id: widget.data.id,
                      );
                    },
                  ));
                },
                icon: Icons.edit_note_outlined,
              ).animate(delay: const Duration(seconds: 1)).moveY(),
              Constants.sizeH30,
              Text(
                widget.data.title,
                style: Constants.poppinsFont.copyWith(
                    color: Constants.scaffoldColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ).animate(delay: const Duration(seconds: 1)).moveY(),
              Constants.sizeH30,
              data.transoDetailsCreateListT.isEmpty
                  ? Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        height: 330,
                        width: 220,
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
                                      fontSize: 36,
                                      fontWeight: FontWeight.w100),
                                  children: const <TextSpan>[
                                    TextSpan(
                                      text: 'Start Your First Day',
                                    ),
                                    TextSpan(text: ' Buddy'),
                                  ],
                                ),
                              ),
                              Constants.sizeH50,
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return CreateTransoProgressScreen(
                                        dayCount: data.transoDetailsCreateListT
                                                .length +
                                            1,
                                        trasoId: widget.data.id,
                                      );
                                    },
                                  ));
                                },
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
                    )
                  : SizedBox(
                      height: 350,
                      width: size.width,
                      child: CarouselSlider.builder(
                        itemCount: data.transoDetailsCreateListT.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          final TransoCreateDetailsModel datas =
                              data.transoDetailsCreateListT[itemIndex];
                          return InkWell(
                            onDoubleTap: () {
                              _selectDelete(context, datas.id);
                            },
                            onLongPress: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return CreateTransoProgressScreen(
                                    dayCount: itemIndex + 1,
                                    trasoId: widget.data.id,
                                    id: datas.id,
                                  );
                                },
                              ));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              height: 400,
                              width: 200,
                              color: Colors.transparent,
                              child: FlipCard(
                                direction: FlipDirection.HORIZONTAL,
                                front: Wrap(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      height: 250,
                                      width: 250,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              126, 37, 150, 190),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 30.0, left: 20, right: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Day",
                                                  style: Constants.poppinsFont
                                                      .copyWith(
                                                          color: Constants
                                                              .scaffoldColor,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                                Constants.sizeW10,
                                                Text(
                                                  datas.day,
                                                  style: Constants.poppinsFont
                                                      .copyWith(
                                                          color: Constants
                                                              .scaffoldColor,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Constants.sizeH10,
                                            Text(
                                              "Target",
                                              style: Constants.poppinsFont
                                                  .copyWith(
                                                      color: Constants
                                                          .scaffoldColor,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 50,
                                              width: 200,
                                              child: Text(
                                                widget.data.target,
                                                maxLines: 2,
                                                style: Constants.poppinsFont
                                                    .copyWith(
                                                  color:
                                                      Constants.scaffoldColor,
                                                  fontSize: 13,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "Daily Status",
                                              style: Constants.poppinsFont
                                                  .copyWith(
                                                      color: Constants
                                                          .scaffoldColor,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 50,
                                              width: 200,
                                              child: Text(
                                                datas.currentStatus,
                                                maxLines: 2,
                                                style: Constants.poppinsFont
                                                    .copyWith(
                                                  color:
                                                      Constants.scaffoldColor,
                                                  fontSize: 13,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            AnimatedSwitcher(
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .touch_app_outlined,
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        _buttonTextList[
                                                            _selectedButtonIndex],
                                                        key: ValueKey<int>(
                                                            _selectedButtonIndex),
                                                        style: Constants
                                                            .poppinsFont
                                                            .copyWith(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    )
                                        .animate(
                                            delay: const Duration(seconds: 1))
                                        .moveY(),
                                  ],
                                ),
                                back: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  height: 250,
                                  width: 250,
                                  decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SizedBox(
                                      child: Image.file(
                                        File(
                                          datas.imagePath,
                                        ),
                                        fit: BoxFit.cover,
                                        height: 330,
                                        width: 250,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                            autoPlay: false,
                            enlargeCenterPage: true,
                            viewportFraction: 0.6,
                            aspectRatio: 1.3,
                            reverse: false,
                            enableInfiniteScroll: false
                            // initialPage: 0,
                            ),
                      ),
                    ),
              Constants.sizeH30,
              Align(
                alignment: Alignment.bottomCenter,
                child: Wrap(
                  children: array.isNotEmpty
                      ? array
                          .asMap()
                          .entries
                          .map(
                            (e) => Container(
                              margin:
                                  const EdgeInsets.only(right: 6, bottom: 6),
                              height: 30,
                              width: 30,
                              decoration: e.key <=
                                      data.transoDetailsCreateListT.length - 1
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color:
                                          const Color.fromARGB(180, 2, 179, 8),
                                    )
                                  : BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey[200],
                                    ),
                              child: Center(
                                child: Text((e.key + 1).toString()),
                              ),
                            ),
                          )
                          .toList()
                      : [],
                ),
              ).animate(delay: const Duration(seconds: 1)).moveY(),
              Constants.sizeH30,
              Text(
                "Current Status",
                style: Constants.poppinsFont.copyWith(
                    color: Constants.scaffoldColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ).animate(delay: const Duration(seconds: 1)).moveY(),
              SizedBox(
                height: 60,
                width: size.width,
                child: Text(
                  widget.data.currentStatus,
                  style: Constants.poppinsFont.copyWith(
                    color: Constants.scaffoldColor,
                    fontSize: 12,
                  ),
                ),
              ).animate(delay: const Duration(seconds: 1)).moveY(),
            ],
          ),
        ),
      ),
    ).animate(delay: const Duration(seconds: 1)).moveY();
  }
}
