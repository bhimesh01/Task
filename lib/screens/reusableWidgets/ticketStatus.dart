import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ticketStatus extends StatelessWidget {
  int severityState;

  ticketStatus({Key? key, required this.severityState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (severityState == 51) {
      return SvgPicture.asset(
        'assets/svg/green low severity.svg',
        width: 15,
        height: 15,
      );
    } else if (severityState == 60) {
      return SvgPicture.asset(
        'assets/svg/yellow major severity.svg',
        width: 15,
        height: 15,
      );
    } else if (severityState == 90) {
      return SvgPicture.asset(
        'assets/svg/red critical severity.svg',
        width: 15,
        height: 15,
      );
    } else {
      return SvgPicture.asset(
        'assets/svg/blue medium severity.svg',
        width: 15,
        height: 15,
      );
    }
  }
}
