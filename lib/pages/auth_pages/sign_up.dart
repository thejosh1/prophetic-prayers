import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prophetic_prayers/controller/auth_controllers/auth_controller.dart';
import 'package:prophetic_prayers/pages/auth_pages/login.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../main.dart';
import '../../utils/dimensions.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(),
      body: SignUpForm(),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  FirebaseStorage storage = FirebaseStorage.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  var image;
  var value;

  @override
  void initState() {
    _isObscure;
  }

  @override
  void dispose() {
    super.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return GetBuilder<AuthController>(builder: (authController) {
      return Scaffold(
          key: _scaffoldKey,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: Dimensions.Width20+2),
              color: Colors.white,
              child: Form(
                key: formKey,
                child:  Column(
                    children: [
                      SizedBox(height: Dimensions.Height40),
                      TextFormField(
                        style: const TextStyle(),
                        controller: _nameController,
                        decoration: InputDecoration(
                            hintText: 'Name',
                            hintStyle: TextStyle(
                              color: const Color(0xffBEC2CE),
                              fontSize: Dimensions.Width16,
                            ),
                            prefixIcon: const Icon(
                              Icons.person_add_outlined,
                              color: Color(0xffBEC2CE),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: Dimensions.Width2-1,
                                  color: const Color(0xffBEC2CE)
                              ),
                            )
                        ),
                        validator: (value) {
                          if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                            return "please enter a correct name";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: Dimensions.Height40),
                      TextFormField(
                        style: const TextStyle(),
                        controller: _emailController,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(
                              color: const Color(0xffBEC2CE),
                              fontSize: Dimensions.Width16,
                            ),
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: Color(0xffBEC2CE),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: Dimensions.Width2-1,
                                  color: const Color(0xffBEC2CE)
                              ),
                            )
                        ),
                        validator: (value) {
                          if(value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(value)) {
                            return "please enter a correct email";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: Dimensions.Height40),
                      TextFormField(
                        style: const TextStyle(),
                        obscureText: _isObscure,
                        controller: _passwordController,
                        decoration: InputDecoration(
                            hintText: 'password',
                            hintStyle: TextStyle(
                              color: const Color(0xffBEC2CE),
                              fontSize: Dimensions.Width16,
                            ),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Color(0xffBEC2CE),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                  _isObscure ? Icons.visibility_off:Icons.visibility,
                                  color: const Color(0xffBEC2CE)
                              ), onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: Dimensions.Width2-1,
                                  color: const Color(0xffBEC2CE)
                              ),
                            )
                        ),
                        validator: (value) {
                          if(value!.isEmpty || value.length < 6) {
                            return "password is too short";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: Dimensions.Height20+3),
                      TextFormField(
                        style: const TextStyle(),
                        obscureText: _isObscure,
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                            hintText: 'confirm password',
                            hintStyle: const TextStyle(
                              color: Color(0xffBEC2CE),
                              fontSize: 16,
                            ),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Color(0xffBEC2CE),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                  _isObscure ? Icons.visibility_off:Icons.visibility,
                                  color: const Color(0xffBEC2CE)
                              ), onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: Dimensions.Width2-1,
                                  color: const Color(0xffBEC2CE)
                              ),
                            )
                        ),
                        validator: (value) {
                          if(value!.isEmpty || value.length < 6) {
                            return "password is too short";
                          } else if(value != _passwordController.text) {
                            return "passwords do not match";
                          }
                          else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: Dimensions.Height20+20),
                      GestureDetector(
                        onTap: () async{
                          if(formKey.currentState!.validate()) {
                            showDialog(
                                context: navigatorKey.currentContext!,
                                barrierDismissible: false,
                                builder: (context) => const Center(child: CircularProgressIndicator(),)
                            );
                            authController.register(
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                              _nameController.text.trim(),
                            );
                          }
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(Dimensions.Width16-4),
                          child: Container(
                            width: double.infinity,
                            height: Dimensions.Height40+10,
                            color: Colors.orange,
                            alignment: Alignment.center,
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.Width16+2,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.Height40-10),
                      GestureDetector(
                        onTap: ((){
                          Get.offAll(() => const LoginScreen());
                        }),
                        child: const Text(
                          'Have an account? Login',
                          style: TextStyle(
                            color: Color(0xffBEC2CE),
                          ),
                        ),
                      )
                    ]
                ),
              ),
            ),
          )
      );
    });
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffF7F8FA),
      padding: EdgeInsets.only(left: Dimensions.Width20+4, right: Dimensions.Width20+4, top: Dimensions.Height40+6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(Icons.arrow_back_outlined),
            ],
          ),
          SizedBox(height: Dimensions.Height20+1),
          Text(
            'Sign Up',
            style: TextStyle(
              fontSize: Dimensions.Width30+4,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Dimensions.Height100+26);
}
