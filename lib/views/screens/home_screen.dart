import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:transo/helpers/constents.dart';
import 'package:transo/models/transo_create_model.dart';
import 'package:transo/provider/local_db_provider.dart';
import 'package:transo/views/screens/create_transo_screen.dart';
import 'package:transo/views/screens/profile_screen.dart';
import 'package:transo/views/screens/transo_overview_page.dart';

import '../widgets/creat_transo_button.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/transo_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TransoProvider provider;
  @override
  void initState() {
    provider = Provider.of<TransoProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.readData();
      provider.readDetailsData();
      provider.readProfileData();
      provider.addIntialDatasToProfile();

      initialize();
    });
    super.initState();
  }

  void initialize() async {
    await Future.delayed(const Duration(milliseconds: 500));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final providerForList = Provider.of<TransoProvider>(context, listen: true);

    List<String> names =
        provider.transoProfileList.map((profile) => profile.name).toList();
    List<String> imagePaths =
        provider.transoProfileList.map((profile) => profile.imagePath).toList();
    if (provider.transoProfileList.isEmpty) {
      return const Text('Buddy');
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomeAppBar(provider: provider, imagePath: imagePaths.last)
                  .animate(delay: const Duration(milliseconds: 220))
                  .slideY(),
              Constants.sizeH30,
              textWish(names.last)
                  .animate(delay: const Duration(milliseconds: 300))
                  .slideX(),
              Text(
                "Ready for a Transoformation ?",
                style: Constants.poppinsFont.copyWith(
                    color: const Color.fromARGB(126, 20, 20, 20),
                    fontSize: 16,
                    fontWeight: FontWeight.w100),
              ).animate(delay: const Duration(milliseconds: 400)).slideX(),
              CreateTransfoWidget(size: size)
                  .animate(delay: const Duration(milliseconds: 500))
                  .slideY(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Your Transformations",
                    style: Constants.poppinsFont.copyWith(
                        color: Constants.scaffoldColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ).animate().move(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.keyboard_arrow_right))
                ],
              ),
              SizedBox(
                height: size.height / 1,
                width: size.width,
                child: Consumer<TransoProvider>(
                  builder: (context, value, child) => value
                          .transoCreateList.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/cloud.png",
                                height: 200,
                               
                              ),
                              Text(
                                "Create Your Transformation",
                                style: Constants.poppinsFont.copyWith(
                                    color: Constants.scaffoldColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: providerForList.transoCreateList.length,
                          itemBuilder: (context, index) {
                            Color color;
                            String image;
                            if (index % 2 == 0) {
                              color = const Color.fromARGB(115, 255, 153, 0);
                            } else {
                              color = const Color.fromARGB(41, 37, 149, 190);
                            }
                            if (index % 2 == 0) {
                              image = "assets/icons/goal (1).png";
                            } else {
                              image = "assets/icons/difficulties.png";
                            }
                            TransformationModel datas =
                                providerForList.transoCreateList[index];

                            return TransoCard(
                              color: color,
                              title: datas.title,
                              totalDays: int.parse(datas.totalDays),
                              datas: datas,
                              assetImage: image,
                            ).animate(delay: const Duration(seconds: 1)).moveY();
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  RichText textWish(String name) {
    return RichText(
      text: TextSpan(
        style: Constants.poppinsFont.copyWith(
            color: Constants.scaffoldColor,
            fontSize: 36,
            fontWeight: FontWeight.w300),
        children: <TextSpan>[
          const TextSpan(
            text: 'Hello',
          ),
          TextSpan(text: ' $name'),
        ],
      ),
    );
  }
}




