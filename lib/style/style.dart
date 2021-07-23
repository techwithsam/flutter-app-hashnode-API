import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTextStyle {
  final appbarStyle = GoogleFonts.aBeeZee(
    color: AppColor().mainColor,
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );

  final tabsStyle = GoogleFonts.alice(
    fontWeight: FontWeight.w700,
  );

  final titleStyle = GoogleFonts.poppins(
    fontSize: 18, 
    fontWeight: FontWeight.w600,
  );

  final errStyle = GoogleFonts.righteous(
    color: AppColor().redCol,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );
}
