import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prophetic_prayers/controller/auth_controller.dart';
import 'package:prophetic_prayers/pages/auth_pages/login.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

  Future<void>showInformationDialogue(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text("Choose photo"),
            actions: [
              TextButton(
                  onPressed: () async{
                   upload(true);
                   setState(() {});

                   Navigator.of(context, rootNavigator: true).pop(
                   );



                 },
                 child: const Text("browse gallery")
              ),
              TextButton(
                  onPressed: () async{
                    upload(false);
                    setState(() {});
                    Navigator.of(context, rootNavigator: true).pop(
                      // Get.snackbar(
                      //     "success",
                      //     "picture has been added successfully click the signup button to complete your signup",
                      //     titleText: const Text("success", style: TextStyle(color: Colors.white),),
                      //     messageText: const Text("picture has been added successfully click the signup button to complete your signup",
                      //         style: TextStyle(color: Colors.white)),
                      //     backgroundColor: const Color(0xff515BDE),
                      //     colorText: Colors.white
                      // )
                    );

                  },
                  child: const Text("Take selfie")
              )
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


    return Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
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
                      if(value!.isEmpty || !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)) {
                        return "please password should contain 1 Upper case,\n 1 lowercase,\n 1 Numeric Number,\n 1 Special Character";
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
                      if(value!.isEmpty || !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)) {
                        return "please password should contain 1 Upper case,\n 1 lowercase,\n 1 Numeric Number,\n 1 Special Character";
                      } else if(value != _passwordController.text) {
                        return "passwords does not match";
                      }
                      else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: Dimensions.Height20+3),
                  GestureDetector(
                    onTap: (() {
                      showInformationDialogue(context);
                      setState(() {});
                    }),
                    child: Row(
                      children: [
                        const Spacer(),
                        Row(
                          children: [
                            const Icon(Icons.library_add, color: Color(0xffBEC2CE),),
                            SizedBox(width: Dimensions.Width3+2,),
                            Text(
                              "add Image",
                              style: TextStyle(
                                  color: const Color(0xffBEC2CE),
                                  fontSize: Dimensions.Width16
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.Height20+3,
                  ),
                  GestureDetector(
                    onTap: () async{
                      if(image != null) {
                        await uploadPfp().then((value) {});
                        value = await getDownload();
                        if(formKey.currentState!.validate()) {
                          AuthController.instance.edit(_emailController.value.text.trim(),
                              _nameController.text.trim(),
                              value
                          );
                          AuthController.instance.Logout();
                        }
                      } else if(image == null) {
                        Get.snackbar("Profile Picture", "Profile Picture not set",
                            backgroundColor: Colors.black,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.TOP,
                            titleText: const Text("Profile Picture not set"),
                            messageText: const Text(
                              "You need to choose a profile picture", style: TextStyle(color: Colors.white),
                            )
                        );
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.Width16-4),
                      child: Container(
                        width: double.infinity,
                        height: Dimensions.Height40+10,
                        color: const Color(0xff515BDE),
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
  }

  XFile? photo;
  Future<void> upload(bool gallery) async {
    final picker = ImagePicker();
    if (gallery) {
      photo =
      await picker.pickImage(source: ImageSource.gallery);

      setState(() {});
    } else {
      photo =
      await picker.pickImage(source: ImageSource.camera, );
      setState(() {});
    }
  }
  
  Future<void> uploadPfp() async {
    File uploadFile =File(photo!.path);

    try {
      await storage.ref("avatar/${uploadFile.path}").putFile(
        uploadFile != null ? uploadFile : File("images/app_logo.png"));
    } on FirebaseException catch(e) {
      print(e);
    }
    catch(e) {
      print(e);
    }
  }
  Future<String> getDownload() async {
    File uploadedFile = File(photo!.path);
    return storage.ref("avatar/${uploadedFile.path}").getDownloadURL();
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
