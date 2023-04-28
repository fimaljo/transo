import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:transo/helpers/constents.dart';
import 'package:transo/views/screens/create_trano_progress_screen.dart';
import 'package:transo/views/screens/create_transo_screen.dart';
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

  @override
  void initState() {
    _provider = Provider.of(context, listen: false);

    // _provider.getDetails(widget.data.id);

    // _provider.readJoinedDetailsData(widget.data.id, _provider.transoDetailsCreateList.);

    super.initState();
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
                    // _provider.readData();
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
      floatingActionButton: FloatingActionButton(
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
              ),
              Constants.sizeH30,
              Text(
                widget.data.title,
                style: Constants.poppinsFont.copyWith(
                    color: Constants.scaffoldColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              Constants.sizeH30,
              data.transoDetailsCreateListT.isEmpty
                  ? Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        height: 250,
                        width: 200,
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
                                      text: 'Start Your First Day',
                                    ),
                                    TextSpan(text: ' Buddy'),
                                  ],
                                ),
                              ),
                              Constants.sizeH10,
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
                                    dayCount:
                                        data.transoDetailsCreateListT.length +
                                            1,
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
                                front: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  height: 250,
                                  width: 250,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          126, 37, 150, 190),
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
                                                  style: Constants.poppinsFont
                                                      .copyWith(
                                                          color: Constants
                                                              .scaffoldColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w200),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                  width: 200,
                                                  child: Text(
                                                    datas.day,
                                                    style: Constants.poppinsFont
                                                        .copyWith(
                                                      color: Constants
                                                          .scaffoldColor,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "Target",
                                                  style: Constants.poppinsFont
                                                      .copyWith(
                                                          color: Constants
                                                              .scaffoldColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w200),
                                                ),
                                                SizedBox(
                                                  height: 50,
                                                  width: 200,
                                                  child: Text(
                                                    widget.data.target,
                                                    style: Constants.poppinsFont
                                                        .copyWith(
                                                      color: Constants
                                                          .scaffoldColor,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "Current Status",
                                                  style: Constants.poppinsFont
                                                      .copyWith(
                                                          color: Constants
                                                              .scaffoldColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w200),
                                                ),
                                                SizedBox(
                                                  height: 60,
                                                  width: 200,
                                                  child: Text(
                                                    datas.currentStatus,
                                                    style: Constants.poppinsFont
                                                        .copyWith(
                                                      color: Constants
                                                          .scaffoldColor,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0),
                                                  child: Row(
                                                    children: [
                                                      const Icon(Icons
                                                          .touch_app_outlined),
                                                      Text(
                                                        "Tap to See Image",
                                                        style: Constants
                                                            .poppinsFont
                                                            .copyWith(
                                                                color: Constants
                                                                    .scaffoldColor,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200),
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
                            aspectRatio: 1.4,
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
                                      color: Color.fromARGB(180, 2, 179, 8),
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
              ),
              Constants.sizeH30,
              Text(
                "Your Transformations",
                style: Constants.poppinsFont.copyWith(
                    color: Constants.scaffoldColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 60,
                width: 200,
                child: Text(
                  widget.data.currentStatus,
                  style: Constants.poppinsFont.copyWith(
                    color: Constants.scaffoldColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
