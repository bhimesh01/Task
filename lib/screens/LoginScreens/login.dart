import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/models/userModel.dart';
import 'package:task/screens/createTicket/createTicketMandatory.dart';
import 'package:task/screens/dashboard/dashboard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'dart:convert';

UserModel model =
    UserModel(userID: 1, username: 'username', email: 'email', statusCode: 400);

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

void show(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$message',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 3.0,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xff4750D5)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: const BorderSide(
                                        color: Color(0xff4750D5)),
                                  ))),
                              child: const Text('Okay'),
                              onPressed: () => Navigator.of(context).pop())),
                    ],
                  )
                ],
              ),
            ),
          ));
}

class LoginState extends State<Login> {
  bool suffixState = false;
  int statusCode = 0;
  bool showPass = false;
  FocusNode? focusNode;
  bool shouldLogin = false;
  int userStatusCode = 0;
  bool shouldReturn = false;
  var decodedJWT;
  var urlLogin = Uri.parse("http://194.163.145.243:9007/api/signin/");
  var urlCheckUsername =
      Uri.parse("http://194.163.145.243:9007/api/signin/username");
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    focusNode = new FocusNode();

    focusNode!.addListener(() {
      if (!focusNode!.hasFocus) {
        setState(() {
          userStatusCode = 0;
        });
        setState(() {
          userStatusCode = validateUserName(userName: userNameController.text);
        });
      } else {
        setState(() {
          userStatusCode = 0;
        });
      }
    });

    setState(() {
      showPass = false;
    });
  }

  validateUserName({required String userName}) {
    String json = jsonEncode({
      'username': userName,
    });

    var feedback = http.post(
      urlCheckUsername,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: json,
    );

    feedback.then((value) => {
          if (value.statusCode == 404)
            {
              setState(() {
                suffixState = false;
              }),
            }
          else
            {
              setState(() {
                userStatusCode = value.statusCode;
              }),
            },
          if (userStatusCode == 500)
            {
              Fluttertoast.showToast(
                  msg: 'Server down, please try again later.'),
            }
        });
    // Fluttertoast.showToast(msg: '$userStatusCode');
    return userStatusCode;
  }

  storePrefs(bool shouldLogin, String email, int userId, String username,
      int statusCode, int exp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("shouldLogin", shouldLogin);
    await prefs.setString("email", email);
    await prefs.setInt("statusCode", statusCode);
    await prefs.setString("username", username);
    await prefs.setInt("userId", userId);
    await prefs.setInt("expiry", exp);
  }

  validateUserNameAndPassword(
      {required String userName,
      required String password,
      required BuildContext context}) {
    String encryptedPass = md5.convert(utf8.encode(password)).toString();
    String json = jsonEncode({
      'username': userName,
      'password': encryptedPass,
    });

    var feedback = http.post(
      urlLogin,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: json,
    );

    feedback.then((data) {
      var feedbackBody = data.body;

      if (feedbackBody[0] == '{') {
        Map<String, dynamic> jsonReturned = jsonDecode(feedbackBody);
        int status = jsonReturned['status'];
        if (status == 405) {
          Fluttertoast.showToast(msg: 'Server down, please try again later.');
        }
        if (status == 400) {
          Fluttertoast.showToast(msg: 'Wrong Password');
          setState(() {
            statusCode = 400;
          });
        }
      } else {
        decodedJWT = Jwt.parseJwt(feedbackBody);
        print(decodedJWT);
        print(decodedJWT['exp']);
        if (shouldLogin == true) {
          storePrefs(
              true,
              decodedJWT[
                  'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress'],
              int.parse(decodedJWT[
                  'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/sid']),
              decodedJWT[
                  'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name'],
              200,
              decodedJWT['exp']);
        } else {
          storePrefs(false, 'email', -1, 'username', -100, -100);
        }
        setState(() {
          statusCode = 200;
          model = UserModel(
              email: decodedJWT[
                  'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress'],
              userID: int.parse(decodedJWT[
                  'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/sid']),
              username: decodedJWT[
                  'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name'],
              statusCode: 200);
        });

        Fluttertoast.showToast(
            msg: 'Login Successful!, Welcome ${model.username}');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Dashboard(showAnimation: true,fromLogin: true,),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.only(top: 40),
                  ),
                  Image.asset(
                    "assets/images/loadingImage.png",
                    height: 140,
                    width: 144,
                  ),
                  const SizedBox(height: 20),
                  Text("TASK",
                      style: GoogleFonts.montserrat(
                        fontSize: 34,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff1D1E30),
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Hello!",
                    style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff6C6F93)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 75,
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: TextFormField(
                      focusNode: focusNode,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: ((value) {
                        if (userStatusCode == 200) {
                          Future.delayed(Duration.zero, () {
                            setState(() {
                              suffixState = true;
                            });
                          });
                          return null;
                        } else {
                          Future.delayed(Duration.zero, () {
                            setState(() {
                              suffixState = false;
                              userStatusCode = 0;
                            });
                          });
                        }
                      }),
                      controller: userNameController,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: const Color(0xff6C6F93),
                      ),
                      decoration: InputDecoration(
                        suffixIcon: suffixState
                            ? Padding(
                                child: Image.asset(
                                  'assets/icons/validatorTick.png',
                                  height: 10,
                                  width: 10,
                                ),
                                padding: const EdgeInsets.only(right: 20),
                              )
                            : null,
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 1)),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Username",
                        hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: const Color(0xff6C6F93),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 75,
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.always,
                      validator: ((value) {
                        print(statusCode);
                        if (statusCode == 400) {
                          return '\u26A0 Incorrect Password';
                        }
                        return null;
                      }),
                      controller: passwordController,
                      obscureText: !showPass,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: const Color(0xff6C6F93),
                      ),
                      decoration: InputDecoration(
                        suffixIcon: !showPass
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    showPass = true;
                                  });
                                },
                                icon: Image.asset('assets/icons/view.png'))
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    showPass = false;
                                  });
                                },
                                icon: Image.asset('assets/icons/hide.png'),
                              ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 1)),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Password",
                        hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: const Color(0xff6C6F93),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 8),
                    child: Row(
                      children: [
                        Checkbox(
                          onChanged: (bool? value) {
                            setState(() {
                              shouldLogin = value!;
                            });
                            print(shouldLogin);
                          },
                          value: shouldLogin,
                        ),
                        Text('Keep me Logged in!'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width / 1.5,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 65,
                        ),
                        backgroundColor: const Color(0xff4750d5),
                      ),
                      onPressed: () => {
                        //toDo login implementation
                        if (userNameController.text.isEmpty &&
                            passwordController.text.isEmpty)
                          {
                            show(
                                context, 'Username and Password are mandatory'),
                          }
                        else
                          {
                            if (userStatusCode != 200)
                              {
                                show(context,
                                    'Cannot login with invalid Username'),
                              }
                            else
                              {
                                validateUserNameAndPassword(
                                    context: context,
                                    userName: userNameController.text,
                                    password: passwordController.text),
                              }
                          },
                      },
                      child: Text(
                        "Login",
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Text(
                    "@copyright",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff858585),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
