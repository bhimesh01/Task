import 'dart:async';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'comingSoonScreen.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task/models/userModel.dart';
import 'package:task/screens/LoginScreens/login.dart';
import 'package:task/screens/reusableWidgets/comingSoonScreen.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

void clearPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

class _MenuState extends State<Menu> {
  @override
  final controller = ScrollController();
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    TextStyle containerTextStyle = TextStyle(
      color: Color.fromARGB(255, 1, 6, 76),
      fontSize: 20,
    );
    return Scaffold(
        backgroundColor: Color(0xffE5E5E5),
        // appBar: ScrollAppBar(
        //   controller: controller,
        //   backgroundColor: Color(0xff4750D5),
        //   elevation: 0,
        //   automaticallyImplyLeading: false,
        //   toolbarHeight: kToolbarHeight * 0.5,
        //   leading: IconButton(
        //       color: Colors.white,
        //       onPressed: () {
        //         // Navigator.push(
        //         //   context,
        //         //   MaterialPageRoute(builder: (context) => MyApp()),
        //         //);
        //       },
        //       icon: Icon(Icons.arrow_back_ios_new_outlined)),
        // ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                elevation: 0,
                backgroundColor: Color(0xff4750D5),
                leading: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back_ios_new_outlined)),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Padding(
                //   padding: EdgeInsets.only(
                //     left: 0,
                //     top: kToolbarHeight * 0.5,
                //   ),
                //   child: Container(
                //     color: Color(0xff4750D5),
                //     alignment: Alignment.centerLeft,
                //     child: Padding(
                //       padding: EdgeInsets.only(
                //         left: 10,
                //       ),
                //       child: IconButton(
                //           color: Colors.white,
                //           onPressed: () {
                //             // Navigator.push(
                //             //   context,
                //             //   MaterialPageRoute(builder: (context) => MyApp()),
                //             //);
                //           },
                //           icon: Icon(Icons.arrow_back_ios_new_outlined)),
                //     ),
                //   ),
                // ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.25,
                  child: Stack(
                    children: [
                      ClipPath(
                        clipper: Customshape(),
                        child: Container(
                          color: Color(0xff4750D5),
                          height: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 0, bottom: 10),
                        child: Center(
                          child: Column(
                            children: [
                              CircleAvatar(
                                child: Text('${model.username}'[0]),
                                radius: 40,
                              ),
                              Text(
                                '${model.username}',
                                style: TextStyle(
                                  color: Color(0xff4750D5),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter',
                                ),
                              ),
                              Text(
                                '${model.email}',
                                style: TextStyle(
                                  color: Color(0xff4750D5),
                                  fontSize: 15,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.04,
                    left: MediaQuery.of(context).size.height * 0.04,
                  ),
                  child: Column(
                    children: ListTile.divideTiles(
                      context: context,
                      tiles: [
                        ListTile(
                          leading: Icon(
                            Icons.folder_outlined,
                            color: Color(0xff4750D5),
                          ),
                          title: Text(
                            'Projects',
                            style: TextStyle(
                              color: Color(0xff191E6C),
                              fontSize: 15,
                              fontFamily: 'Inter',
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => comingSoonScreen()),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.summarize_outlined,
                            color: Color(0xff4750D5),
                          ),
                          title: Text('Summary',
                              style: TextStyle(
                                color: Color(0xff191E6C),
                                fontSize: 15,
                                fontFamily: 'Inter',
                              )),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => comingSoonScreen()),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.timer_outlined,
                            color: Color(0xff4750D5),
                          ),
                          title: Text(
                            'Time Tracking',
                            style: TextStyle(
                              color: Color(0xff191E6C),
                              fontSize: 15,
                              fontFamily: 'Inter',
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => comingSoonScreen()),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.link_outlined,
                            color: Color(0xff4750D5),
                          ),
                          title: Text(
                            'Repository',
                            style: TextStyle(
                              color: Color(0xff191E6C),
                              fontSize: 15,
                              fontFamily: 'Inter',
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => comingSoonScreen()),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.supervised_user_circle,
                            color: Color(0xff4750D5),
                          ),
                          title: Text('Account',
                              style: TextStyle(
                                color: Color(0xff191E6C),
                                fontSize: 15,
                                fontFamily: 'Inter',
                              )),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => comingSoonScreen()),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.headphones_outlined,
                            color: Color(0xff4750D5),
                          ),
                          title: Text('Support',
                              style: TextStyle(
                                color: Color(0xff191E6C),
                                fontSize: 15,
                                fontFamily: 'Inter',
                              )),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => comingSoonScreen()),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.power_settings_new_outlined,
                            color: Color(0xff4750D5),
                          ),
                          title: Text(
                            'Log out',
                            style: TextStyle(
                              color: Color(0xff191E6C),
                              fontSize: 15,
                              fontFamily: 'Inter',
                            ),
                          ),
                          onTap: () {
                            clearPrefs();
                            Fluttertoast.showToast(msg: 'Log Out successful');
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                                (route) => false);
                          },
                        ),
                      ],
                    ).toList(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.05,
                    bottom: MediaQuery.of(context).size.width * 0.1,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Image.asset(
                          "assets/images/loadingImage.png",
                          fit: BoxFit.fitWidth,
                          width: MediaQuery.of(context).size.width / 4,
                          alignment: Alignment.bottomCenter,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text(
                        "TASK",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 35,
                          color: Color(0xff6C6F93),
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.width * 0),
                  child: Center(
                      child: Text(
                    '@copyrights',
                    style: TextStyle(
                      color: Color(0xff6C6F93),
                      fontFamily: 'Inter',
                    ),
                  )),
                ),
              ],
            ),
          ),
        ));
  }
}

// class TopBar extends StatelessWidget {
//   const TopBar({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Row(
//         children: [
//           IconButton(
//               color: Colors.black,
//               onPressed: () {
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(builder: (context) => MyApp()),
//                 //);
//               },
//               icon: Icon(Icons.arrow_back_ios_new_outlined))
//         ],
//       ),
//     );
//   }
// }

class CustomClipPath {
  @override
  getClip(Size size) {
    double w = size.width;
    double h = size.height;
    final path = Path();
    path.moveTo(0, 100);
    path.lineTo(0, h);
    path.quadraticBezierTo(
      w * 2,
      h - 100,
      w,
      h,
    );
    path.lineTo(w, h);
    return path;
  }
}

class Customshape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;

    var path = Path();
    path.lineTo(0, height - 50);
    path.quadraticBezierTo(
      width / 6,
      height / 80,
      width,
      height,
    );
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}









// class Menu extends StatefulWidget {
//   const Menu({Key? key}) : super(key: key);

//   @override
//   State<Menu> createState() => _MenuState();
// }

// class _MenuState extends State<Menu> {
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     TextStyle containerTextStyle = TextStyle(
//       color: Color.fromARGB(255, 1, 6, 76),
//       fontSize: 20,
//     );
//     return Scaffold(
//       backgroundColor: Color(0xffE5E5E5),
//       // appBar: AppBar(
//       //   backgroundColor: Color(0xff4750D5),
//       //   elevation: 0,
//       //   automaticallyImplyLeading: false,
//       //   leading: IconButton(
//       //       color: Colors.white,
//       //       onPressed: () {
//       //         // Navigator.push(
//       //         //   context,
//       //         //   MaterialPageRoute(builder: (context) => MyApp()),
//       //         //);
//       //       },
//       //       icon: Icon(Icons.arrow_back_ios_new_outlined)),
//       // ),
//       body: Center(
//         child: Column(children: [
//           Container(
//             height: MediaQuery.of(context).size.height * 0.2,
//             child: Stack(
//               children: [
//                 ClipPath(
//                   clipper: Customshape(),
//                   child: Container(
//                     color: Color(0xff4750D5),
//                     height: MediaQuery.of(context).size.height / 2,
//                   ),
//                 ),
//                 Align(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Padding(
//                           padding: EdgeInsets.only(
//                             top: MediaQuery.of(context).size.height * 0.06,
//                           ),
//                           child: ProfilePicture(
//                               name: '${model.username}',
//                               radius: MediaQuery.of(context).size.height * 0.05,
//                               fontsize: 30)),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: MediaQuery.of(context).size.width * 0.001),
//                         child: Text(
//                           model.username,
//                           style: TextStyle(
//                             color: Color(0xff4750D5),
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Inter',
//                           ),
//                         ),
//                       ),
//                       Text(
//                         model.email,
//                         style: TextStyle(
//                           color: Color(0xff4750D5),
//                           fontSize: 15,
//                           fontFamily: 'Inter',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(
//               top: MediaQuery.of(context).size.height * 0.09,
//               left: MediaQuery.of(context).size.height * 0.04,
//             ),
//             child: Column(
//               children: ListTile.divideTiles(
//                 context: context,
//                 tiles: [
//                   ListTile(
//                     leading: Icon(
//                       Icons.folder_outlined,
//                       color: Color(0xff4750D5),
//                     ),
//                     title: Text(
//                       'Projects',
//                       style: TextStyle(
//                         color: Color(0xff191E6C),
//                         fontSize: 15,
//                         fontFamily: 'Inter',
//                       ),
//                     ),
//                     onTap: () {},
//                   ),
//                   ListTile(
//                     leading: Icon(
//                       Icons.summarize_outlined,
//                       color: Color(0xff4750D5),
//                     ),
//                     title: Text('Summary',
//                         style: TextStyle(
//                           color: Color(0xff191E6C),
//                           fontSize: 15,
//                           fontFamily: 'Inter',
//                         )),
//                     onTap: () {},
//                   ),
//                   ListTile(
//                     leading: Icon(
//                       Icons.timer_outlined,
//                       color: Color(0xff4750D5),
//                     ),
//                     title: Text(
//                       'Time Tracking',
//                       style: TextStyle(
//                         color: Color(0xff191E6C),
//                         fontSize: 15,
//                         fontFamily: 'Inter',
//                       ),
//                     ),
//                     onTap: () {},
//                   ),
//                   ListTile(
//                     leading: Icon(
//                       Icons.link_outlined,
//                       color: Color(0xff4750D5),
//                     ),
//                     title: Text(
//                       'Repository',
//                       style: TextStyle(
//                         color: Color(0xff191E6C),
//                         fontSize: 15,
//                         fontFamily: 'Inter',
//                       ),
//                     ),
//                     onTap: () {},
//                   ),
//                   ListTile(
//                     leading: Icon(
//                       Icons.supervised_user_circle,
//                       color: Color(0xff4750D5),
//                     ),
//                     title: Text('Account',
//                         style: TextStyle(
//                           color: Color(0xff191E6C),
//                           fontSize: 15,
//                           fontFamily: 'Inter',
//                         )),
//                     onTap: () {},
//                   ),
//                   ListTile(
//                     leading: Icon(
//                       Icons.headphones_outlined,
//                       color: Color(0xff4750D5),
//                     ),
//                     title: Text('Support',
//                         style: TextStyle(
//                           color: Color(0xff191E6C),
//                           fontSize: 15,
//                           fontFamily: 'Inter',
//                         )),
//                     onTap: () {},
//                   ),
//                   ListTile(
//                     leading: Icon(
//                       Icons.power_settings_new_outlined,
//                       color: Color(0xff4750D5),
//                     ),
//                     title: Text(
//                       'Log out',
//                       style: TextStyle(
//                         color: Color(0xff191E6C),
//                         fontSize: 15,
//                         fontFamily: 'Inter',
//                       ),
//                     ),
//                     onTap: () {
//                       Fluttertoast.showToast(msg: 'Log Out successful');
//                       Navigator.of(context).pushAndRemoveUntil(
//                           MaterialPageRoute(builder: (context) => Login()),
//                           (route) => false);
//                     },
//                   ),
//                   ListTile(
//                     title: Text(
//                       '   ',
//                     ),
//                   ),
//                 ],
//               ).toList(),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(
//               top: MediaQuery.of(context).size.height * 0,
//               bottom: MediaQuery.of(context).size.height / 95,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Positioned.fill(
//                   child: Image.asset(
//                     "assets/images/loadingImage.png",
//                     fit: BoxFit.fitWidth,
//                     width: MediaQuery.of(context).size.width / 4,
//                     alignment: Alignment.bottomCenter,
//                   ),
//                 ),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.height * 0.01,
//                 ),
//                 Text(
//                   "TASK",
//                   textAlign: TextAlign.right,
//                   style: TextStyle(
//                     fontSize: 35,
//                     color: Color(0xff6C6F93),
//                     fontFamily: 'Montserrat',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Center(
//             child: Padding(
//                 padding: EdgeInsets.only(
//                   top: MediaQuery.of(context).size.height * 0.43,
//                   bottom: 1,
//                 ),
//                 child: Text(
//                   '@copyrights',
//                   style: TextStyle(
//                     color: Color(0xff6C6F93),
//                     fontFamily: 'Inter',
//                   ),
//                 )),
//           ),
//         ]),
//       ),
//     );
//   }
// }

// class TopBar extends StatelessWidget {
//   const TopBar({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Row(
//         children: [
//           IconButton(
//               color: Colors.black,
//               onPressed: () {
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(builder: (context) => MyApp()),
//                 //);
//               },
//               icon: Icon(Icons.arrow_back_ios_new_outlined))
//         ],
//       ),
//     );
//   }
// }

// class CustomClipPath {
//   @override
//   getClip(Size size) {
//     double w = size.width;
//     double h = size.height;
//     final path = Path();
//     path.moveTo(0, 100);
//     path.lineTo(0, h);
//     path.quadraticBezierTo(
//       w * 2,
//       h - 100,
//       w,
//       h,
//     );
//     path.lineTo(w, h);
//     return path;
//   }
// }

// class Customshape extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     double height = size.height;
//     double width = size.width;

//     var path = Path();
//     path.lineTo(0, height - 50);
//     path.quadraticBezierTo(
//       width / 6,
//       height / 80,
//       width,
//       height,
//     );
//     path.lineTo(width, 0);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }
