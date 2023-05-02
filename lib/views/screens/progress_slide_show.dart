import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/transo_details_create_model.dart';
import '../../provider/local_db_provider.dart';

class ProgressSlideShow extends StatelessWidget {
  const ProgressSlideShow({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final data = Provider.of<TransoProvider>(context, listen: true);
    double aspectRatio = size.width / size.height;
    return CarouselSlider.builder(
      itemCount: data.transoDetailsCreateListT.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        final TransoCreateDetailsModel datas =
            data.transoDetailsCreateListT[itemIndex];
        return SizedBox(
            height: size.height,
            width: size.width,
            child: Image.file(
              File(datas.imagePath),
              fit: BoxFit.cover,
            ));
      },
      options: CarouselOptions(
          autoPlayInterval: const Duration(milliseconds: 1000),
          aspectRatio: aspectRatio,
          autoPlay: true,
          reverse: false,
          enableInfiniteScroll: false),
    );
  }
}
