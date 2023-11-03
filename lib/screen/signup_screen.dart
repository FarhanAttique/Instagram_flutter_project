import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta/resources/auth.dart';
import 'package:insta/responsive/mobile_screen_layout.dart';
import 'package:insta/responsive/responsive_layout_screen.dart';
import 'package:insta/responsive/web_screen_layout.dart';
import 'package:insta/screen/login_screen.dart';
import 'package:insta/utils/colors.dart';
import 'package:insta/utils/imgpicker.dart';
import 'package:insta/widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _bio = TextEditingController();
  final TextEditingController _username = TextEditingController();
  Uint8List? _image;
  bool _isloading = false;
  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _username.dispose();
    _bio.dispose();
    _password.dispose();
  }

  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() { 
      _image = im;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(children: [
            Flexible(
              child: Container(),
              flex: 2,
            ),
            SvgPicture.asset(
              'assets/ic_instagram.svg',
              color: primaryColor,
              height: 64,
            ),
            const SizedBox(
              height: 44,
            ),
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage:
                            MemoryImage(_image!), // Adjust the path
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage:
                            AssetImage('/Nitrate.jpg'), // Adjust the path
                      ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: Icon(
                      Icons.add_a_photo,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 14,
            ),
            // username
            TextFieldInput(
              hinttext: "Enter your Username",
              textInputType: TextInputType.text,
              textEditingController: _username,
            ),
            const SizedBox(
              height: 14,
            ),
            // email
            TextFieldInput(
              hinttext: "Enter your Email",
              textInputType: TextInputType.emailAddress,
              textEditingController: _email,
            ),

            const SizedBox(
              height: 14,
            ),

            // pass
            TextFieldInput(
              hinttext: "Enter your Password",
              textInputType: TextInputType.text,
              textEditingController: _password,
              isPass: true,
            ),

            const SizedBox(
              height: 14,
            ),

            TextFieldInput(
              hinttext: "Enter your Bio",
              textInputType: TextInputType.text,
              textEditingController: _bio,
            ),

            const SizedBox(
              height: 14,
            ),
            // button
            InkWell(
              onTap: () async {
                setState(() {
                  _isloading = true;
                });
                String res = await AuthMethods().signUpUser(
                    username: _username.text,
                    email: _email.text,
                    password: _password.text,
                    bio: _bio.text,
                    file: _image!);
                setState(() {
                  _isloading = false;
                });

                if (res != "success") {
                  showSnackBar(res, context);   
                } else {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const ResponsiveLayout(
                        mobileScreenLayout: MobileScreenLayout(),
                        webScreenLayout: WebScreenLayout(),
                      ),
                    ),
                  );
                }
              },
              child: Container(
                child: _isloading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text("Sign up"),
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  color: blueColor,
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            // sign
            Flexible(
              child: Container(),
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: const Text("Don't have an account?"),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                GestureDetector(
                  onTap: navigateToLogin,
                  child: Container(
                    child: const Text(
                      "Login.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
