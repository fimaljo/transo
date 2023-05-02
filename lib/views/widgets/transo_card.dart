import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/constents.dart';
import '../../models/transo_create_model.dart';
import '../../provider/local_db_provider.dart';
import '../screens/transo_overview_page.dart';

class TransoCard extends StatelessWidget {
  const TransoCard({
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
              SizedBox(
                width: 100,
                height: 20,
                child: Text(
                  title,
                  style: Constants.poppinsFont.copyWith(
                      color: Constants.scaffoldColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                ),
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
                  icon: const Icon(Icons.delete_outlined))
            ],
          ),
        ),
      ),
    );
  }
}