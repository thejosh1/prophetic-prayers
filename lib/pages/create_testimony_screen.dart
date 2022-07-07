import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/controller/auth_controller.dart';
import 'package:prophetic_prayers/services/testimony_services.dart';

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
                        fontSize: 18.0,
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
    return Container(
      color: const Color(0xffF7F8FA),
      padding: const EdgeInsets.only(left: 24, right: 24, top: 46),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(onTap: (){
                FocusManager.instance.primaryFocus?.unfocus();
                Get.back();
              },child: const Icon(Icons.arrow_back_outlined)),
              const Icon(Icons.more_vert),
            ],
          ),
          const SizedBox(height: 21),
          const Text(
            'Testimony',
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
