import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class projectStatus extends StatelessWidget {
  int progressState;

  projectStatus({Key? key, required this.progressState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (progressState == 50) {
      return Text(
        'Assigned',
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xff0A0B12),
        ),
      );
    } else if (progressState == 51) {
      return Text(
        'Accepted',
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xff0A0B12),
        ),
      );
    } else if (progressState == 52) {
      return Text(
        'In Progress',
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xff0A0B12),
        ),
      );
    } else if (progressState == 53) {
      return Text(
        'Hold',
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xff0A0B12),
        ),
      );
    } else if (progressState == 54) {
      return Text(
        'Invalid',
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xff0A0B12),
        ),
      );
    } else if (progressState == 55) {
      return Text(
        'Awaiting for Response',
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xff0A0B12),
        ),
      );
    } else if (progressState == 70) {
      return Text(
        'Dev Complete',
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xff0A0B12),
        ),
      );
    } else if (progressState == 71) {
      return Text(
        'Test',
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xff0A0B12),
        ),
      );
    } else if (progressState == 73) {
      return Text(
        'Stage Complete',
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xff0A0B12),
        ),
      );
    } else if (progressState == 80) {
      return Text(
        'Resolved',
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xff0A0B12),
        ),
      );
    } else {
      return Text(
        'Closed',
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xff0A0B12),
        ),
      );
    }
  }
}
