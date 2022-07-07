import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prophetic_prayers/controller/auth_controller.dart';
import 'package:prophetic_prayers/pages/auth_pages/login.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  final TextEditingController _phonenumberController = TextEditingController();

  Future<void>showInformationDialogue(BuildContext context) async {
    String? value;
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
                     Get.snackbar(
                       "success",
                       "picture has been added successfully click the signup button to complete your signup",
                       backgroundColor: Color(0xff515BDE),
                       colorText: Colors.white
                     )
                   );

                    },
                  child: const Text("browse gallery")
              ),
              TextButton(
                  onPressed: () async{
                    upload(false);
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: const Text("Take selfie")
              )
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 22),
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 40),
            TextField(
              controller: _nameController,
              style: const TextStyle(),
              decoration: const InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Color(0xffBEC2CE),
                  ),
                ),
                hintText: 'Name',
                hintStyle: TextStyle(
                  color: Color(0xffBEC2CE),
                  fontSize: 16,
                ),
                prefixIcon: Icon(
                  Icons.person_add_outlined,
                  color: Color(0xffBEC2CE),
                ),
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              style: const TextStyle(),
              controller: _emailController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Color(0xffBEC2CE),
                  ),
                ),
                hintText: 'Email',
                hintStyle: TextStyle(
                  color: Color(0xffBEC2CE),
                  fontSize: 16,
                ),
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: Color(0xffBEC2CE),
                ),
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              style: const TextStyle(),
              controller: _phonenumberController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Color(0xffBEC2CE),
                  ),
                ),
                hintText: 'Phone Number',
                hintStyle: TextStyle(
                  color: Color(0xffBEC2CE),
                  fontSize: 16,
                ),
                prefixIcon: Icon(
                  Icons.phone_iphone_outlined,
                  color: Color(0xffBEC2CE),
                ),
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _passwordController,
              style: const TextStyle(),
              obscureText: true,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Color(0xffBEC2CE),
                  ),
                ),
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: Color(0xffBEC2CE),
                  fontSize: 16,
                ),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Color(0xffBEC2CE),
                ),
              ),
            ),
            const SizedBox(height: 23),
            GestureDetector(
              onTap: (() {
               showInformationDialogue(context);
               setState(() {});
              }),
              child: Row(
                children: [
                  const Spacer(),
                  Row(
                    children: const [
                      Icon(Icons.library_add, color: Color(0xffBEC2CE),),
                      SizedBox(width: 5,),
                      Text(
                        "add Image",
                        style: TextStyle(
                          color: Color(0xffBEC2CE),
                          fontSize: 16
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 23,
            ),
            GestureDetector(
              onTap: () async{
                await uploadPfp().then((value) {});
                String value = await getDownload();
                AuthController.instance.register(
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                    _nameController.text.trim(),
                    _phonenumberController.text.trim(),
                    value,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  color: const Color(0xff515BDE),
                  alignment: Alignment.center,
                  child: const Text(
                    'SignUp',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            const Text(
              'Forgot password?',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xffBEC2CE),
              ),
            ),
            const SizedBox(height: 30),
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
          ],
        ),
      ),
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
        uploadFile != null ? uploadFile : File("images/adrianna-geo.png"));
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
      padding: const EdgeInsets.only(left: 24, right: 24, top: 46),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(Icons.arrow_back_outlined),
            ],
          ),
          const SizedBox(height: 21),
          const Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(126);
}
