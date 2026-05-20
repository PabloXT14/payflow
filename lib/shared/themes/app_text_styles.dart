import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  AppTextStyles._(); // Private constructor to prevent instantiation

  static final headingLg = GoogleFonts.lexend(
    fontSize: 32,
    fontWeight: FontWeight.w600,
  );

  static final headingMd = GoogleFonts.lexend(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static final textLg = GoogleFonts.inter(
    fontSize: 17,
    fontWeight: FontWeight.w600,
  );

  static final textMd = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  static final textSm = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );
}
