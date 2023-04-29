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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TransoProvider provider;
//  late final LocalDB _crudStorage;
  @override
  void initState() {
    provider = Provider.of<TransoProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.readData();
      provider.readDetailsData();
      initialize();
    });
    super.initState();
  }

  void initialize() async {
    await Future.delayed(Duration(seconds: 1));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final providerForList = Provider.of<TransoProvider>(context, listen: true);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomeAppBar()
                  .animate(delay: Duration(milliseconds: 220))
                  .slideY(),
              Constants.sizeH30,
              textWish().animate(delay: Duration(milliseconds: 300)).slideX(),
              Text(
                "Ready for a Transoformation ?",
                style: Constants.poppinsFont.copyWith(
                    color: const Color.fromARGB(126, 20, 20, 20),
                    fontSize: 16,
                    fontWeight: FontWeight.w100),
              ).animate(delay: Duration(milliseconds: 400)).slideX(),
              CreateTransfoWidget(size: size)
                  .animate(delay: Duration(milliseconds: 500))
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
                                // width: 50,
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
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: providerForList.transoCreateList.length,
                          itemBuilder: (context, index) {
                            Color color;
                            String image;
                            if (index % 2 == 0) {
                              color = Color.fromARGB(115, 255, 153, 0);
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

                            return TransfoCard(
                              color: color,
                              title: datas.title,
                              totalDays: int.parse(datas.totalDays),
                              datas: datas,
                              assetImage: image,
                            ).animate(delay: Duration(seconds: 1)).moveY();
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

  RichText textWish() {
    return RichText(
      text: TextSpan(
        style: Constants.poppinsFont.copyWith(
            color: Constants.scaffoldColor,
            fontSize: 36,
            fontWeight: FontWeight.w100),
        children: const <TextSpan>[
          TextSpan(
            text: 'Hello',
          ),
          TextSpan(text: ' Buddy'),
        ],
      ),
    );
  }
}

class TransfoCard extends StatelessWidget {
  const TransfoCard({
    super.key,
    required this.title,
    required this.totalDays,
    required this.datas,
    required this.color,
    required this.assetImage,
  });
  final String title;
  final int totalDays;
  final TransformationModel datas;
  final Color color;
  final String assetImage;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransoProvider>(context, listen: true);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return TransoOverView(
              data: datas,
              totalDayCount: totalDays,
            );
          },
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        height: 100,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(
            color: const Color.fromARGB(53, 0, 0, 0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            right: 15.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 90,
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: color),
                  child: Center(
                    child: Image.asset(
                      assetImage,
                      height: 50,
                    ),
                  ),
                ),
              ),
              Text(
                title,
                style: Constants.poppinsFont.copyWith(
                    color: Constants.scaffoldColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "$totalDays Days",
                style: Constants.poppinsFont.copyWith(
                    color: Constants.scaffoldColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () {
                    provider.delete(datas.id);
                    provider.readData();
                    provider.readDetailsData();
                  },
                  icon: Icon(Icons.delete_outlined))
            ],
          ),
        ),
      ),
    );
  }
}

class CreateTransfoWidget extends StatelessWidget {
  const CreateTransfoWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return const CreateTransoScreen();
          },
        ));
      },
      child: Padding(
        padding:
            const EdgeInsets.only(left: 8.0, right: 8.0, top: 20, bottom: 20),
        child: Container(
          height: 100,
          width: size.width / 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color.fromARGB(126, 37, 150, 190),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Center(
                    child: Image.asset(
                      "assets/icons/target (1).png",
                      height: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: Constants.poppinsFont.copyWith(
                        color: Constants.scaffoldColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w100),
                    children: const [
                      TextSpan(
                        text: 'Create\n',
                      ),
                      TextSpan(text: 'New  Transformation  Here 🔥'),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(41, 37, 149, 190),
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Image.asset(
                      "assets/icons/right-arrow.png",
                      height: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomeAppBar extends StatelessWidget {
  const CustomeAppBar({
    super.key,
  });

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
              builder: (context) => ProfileScreen(),
            ));
          },
          child: Hero(
            tag: "profile",
            child: const CircleAvatar(
              foregroundImage: NetworkImage(
                  "https://pbs.twimg.com/media/FjU2lkcWYAgNG6d.jpg"),
              radius: 30,
            ),
          ),
        )
      ],
    );
  }
}
