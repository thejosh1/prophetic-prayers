import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          children: [
            SizedBox(height: 100),
            TextField(
              controller: _titleController,
              style: TextStyle(),
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Color(0xffBEC2CE),
                  ),
                ),
                hintText: 'Title(optional)',
                hintStyle: TextStyle(
                  color: Color(0xffBEC2CE),
                  fontSize: 16,
                ),
                prefixIcon: Icon(
                  Icons.title_outlined,
                  color: Color(0xffBEC2CE),
                ),
              ),
            ),
            SizedBox(height: 40),
            LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Color(0xFFBEC2CE))
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: TextField(
                      expands: true,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: TextStyle(),
                      controller: _noteController,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Write your Testimony here',
                        hintStyle: TextStyle(
                          color: Color(0xffBEC2CE),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              }
            ),
            SizedBox(height: 43),
            GestureDetector(
              onTap: () {},
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
                Get.back();
              },child: const Icon(Icons.arrow_back_outlined)),
              const Icon(Icons.more_vert),
            ],
          ),
          const SizedBox(height: 21),
          const Text(
            'Thanks For Sharing',
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
