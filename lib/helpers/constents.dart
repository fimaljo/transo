import 'package:flutter/material.dart';


import 'package:google_fonts/google_fonts.dart';

/// A utility class that holds constants for useful and commonly
/// used values throughout the entire app.
/// This class has no constructor and all variables are `static`.
@immutable
class Constants {
  const Constants._();
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text) {
    if (text == null) return;
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.red,
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static const SizedBox sizeH50 = SizedBox(
    height: 50,
  );
  static const SizedBox sizeH30 = SizedBox(
    height: 30,
  );
  static const SizedBox sizeH20 = SizedBox(
    height: 20,
  );
  static const SizedBox sizeH10 = SizedBox(
    height: 10,
  );
  static const SizedBox sizeW10 = SizedBox(
    width: 10,
  );

  /// The color value for dark grey buttons in the app.
  static const Color buttonGreyColor = Color(0xFF1c1c1c);

  /// The color value for dark grey scaffold in the app.
  static const Color scaffoldColor = Color(0xFF141414);

  /// The color value for light grey scaffold in the app.
  static const Color scaffoldGreyColor = Color(0xFF2b2b2b);

  /// The color value for light grey text in the app.
  static const Color textGreyColor = Color(0xFF949494);

  /// The color value for white text in the app.
  static const Color textWhite80Color = Color(0xFFf2f2f2);

  /// The color value for dark grey [CustomDialog] in the app.
  static const Color barrierColor = Colors.black87;

  /// The color value for light grey [CustomDialog] in the app.
  static const Color barrierColorLight = Color(0xBF000000);

  /// The TextStyle for Lato font in the app.
  static TextStyle latoFont = GoogleFonts.lato().copyWith(color: Colors.black);

  /// The TextStyle for Poppins font in the app.
  static TextStyle poppinsFont = GoogleFonts.poppins().copyWith(
    color: textWhite80Color,
  );
  static TextStyle castoro = GoogleFonts.castoro();

  /// The TextStyle for Roboto font in the app.
  static TextStyle robotoFont = GoogleFonts.roboto();
}
