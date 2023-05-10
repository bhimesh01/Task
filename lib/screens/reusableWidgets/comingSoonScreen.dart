import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class comingSoonScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    var devWidth = MediaQuery.of(context).size.width;
    var devHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.white10,
      //   leading: IconButton(
      //     icon: Icon(
      //       Icons.arrow_back_ios,
      //       color: Color(0xff4750D5),
      //     ),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      // ),
      body: Column(
        children: [
          Spacer(),
          Stack(
            children: [
              Padding(
                child: Container(
                  width: devWidth / 2,
                  child: Text(
                    'Coming Soon...',
                    style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff6C6F93)),
                  ),
                ),
                padding: EdgeInsets.only(
                  left: devWidth / 15,
                  top: devHeight / 15,
                ),
              ),
              SvgPicture.asset(
                'assets/svg/waves.svg',
                width: devWidth,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
