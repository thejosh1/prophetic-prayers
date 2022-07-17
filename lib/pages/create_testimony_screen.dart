import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/controller/auth_controller.dart';
import 'package:prophetic_prayers/services/testimony_services.dart';

import '../widgets/big_text.dart';

class CreateTestimonyScreen extends StatelessWidget {
  const CreateTestimonyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(),
      body: CreateTestimonyForm(),
    );
  }
}

class CreateTestimonyForm extends StatefulWidget {
  const CreateTestimonyForm({Key? key}) : super(key: key);

  @override
  State<CreateTestimonyForm> createState() => _CreateTestimonyFormState();
}

class _CreateTestimonyFormState extends State<CreateTestimonyForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  var data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            children: [
              SizedBox(height: 20),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration.collapsed(
                          hintText: "Title(optional)",
                      ),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const Divider(),
                    SizedBox(height: 23),
                    TextFormField(
                      decoration: const InputDecoration.collapsed(
                        hintText: "Testimony",
                      ),
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 300),
              GestureDetector(
                onTap: () {
                  TestimonyServices.addItem(
                    title: _titleController.text.trim(),
                    testimonies: _noteController.text.trim(),
                    useruid: AuthController.instance.auth.currentUser!.uid.toString(),
                    prayertype: data[0].toString()
                  );
                  Get.back();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    color: const Color(0xff515BDE),
                    alignment: Alignment.center,
                    child: const Text(
                      'Submit',
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
            ],
          ),
        ),
      ),
    );
  }

// _validator() {
//   if(_emailController){

//   }
// }
}


class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = AuthController.instance.auth.currentUser;
    // TODO: implement build
    return Container(
      height: 100,
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 0.5,
                spreadRadius: 0.5,
                offset: Offset(0, 3),
                color: Colors.transparent
            )
          ]
      ),
      padding: const EdgeInsets.only(left: 24, right: 24, top: 46),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(Icons.arrow_back, size: 24,),
          SizedBox(width: 20,),
          BigText(text: "Testimony")
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(126);
}
