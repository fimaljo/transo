
import 'package:flutter/material.dart';

import '../../helpers/constents.dart';
import '../screens/create_transo_screen.dart';

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