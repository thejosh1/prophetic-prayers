import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prophetic_prayers/controller/auth_controller.dart';
import 'package:prophetic_prayers/services/testimony_services.dart';

import '../../services/route_services.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';

class CreateTestimonyScreen extends StatelessWidget {
  const CreateTestimonyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                height: Dimensions.Height44*10,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  color: Color(0xff515BDE)
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.only(left: Dimensions.Width20, right: Dimensions.Width20, top: Dimensions.Height40+10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.clear, color: Colors.white,),
                    ),
                    Text("Create testimony_screen", style: TextStyle(fontSize: Dimensions.Width16+2, fontWeight: FontWeight.bold, color: Colors.white),),
                    GestureDetector(
                      onTap: () {
                        Get.offAll(RouteServices.INITIAL);
                      },
                      child: Container(
                        height: Dimensions.Height20+10,
                        width: Dimensions.Width90-25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.Width30+10),
                          color: Colors.white
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.home, size: Dimensions.Width16,),
                            const Text("Home")
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ),
            Positioned(
              top: Dimensions.Height100,
              child: Container(
                child: Container(
                  padding: EdgeInsets.only(left: Dimensions.Width20, right: Dimensions.Width20, top: Dimensions.Height20),
                  width: MediaQuery.of(context).size.width,
                  height: Dimensions.Height500+200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.Width20+10),
                      topRight: Radius.circular(Dimensions.Width20+10),
                    ),
                    color: Colors.white
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: Dimensions.Height500-200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Dimensions.Height20,),
                        Form(
                          key: _formKey,
                            child: Column(
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration.collapsed(
                                      hintText: "Title here",
                                      hintStyle: TextStyle(color: Colors.blueGrey, fontSize: Dimensions.Width20+4, fontWeight: FontWeight.w600)
                                    ),
                                    controller: _titleController,
                                    style: TextStyle(
                                        fontSize: Dimensions.Width20+4,
                                        fontWeight: FontWeight.bold,
                                      color: Colors.black
                                    ),
                                      validator: (value) {
                                        if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                                          return "please enter a text";
                                        } else {
                                          return null;
                                        }
                                      }
                                  ),
                                  SizedBox(height: Dimensions.Height20,),
                                  Container(
                                    width: Dimensions.Width335-15,
                                    child: TextFormField(
                                      maxLines: null,
                                      keyboardType: TextInputType.multiline,
                                      controller: _noteController,
                                      decoration: InputDecoration.collapsed(
                                          hintText: "testimony_screen here",
                                          hintStyle: TextStyle(color: Colors.blueGrey, fontSize: Dimensions.Width20+4, fontWeight: FontWeight.w600)
                                      ),
                                      style: TextStyle(
                                          fontSize: Dimensions.Width16+2,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black
                                      ),
                                        validator: (value) {
                                          if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                                            return "please enter a text";
                                          } else {
                                            return null;
                                          }
                                        }
                                    ),
                                  ),
                                  SizedBox(height: Dimensions.Height270-70),
                                  GestureDetector(
                                    onTap: () async{
                                      if(_formKey.currentState!.validate()) {
                                       TestimonyServices.addItem(
                                            title: _titleController.text.trim(),
                                            testimonies: _noteController.text.trim(),
                                            useruid: AuthController.instance.auth.currentUser!.uid.toString(),
                                            timestamp: DateFormat.yMMMEd().format(DateTime.now()).toString()
                                        );
                                       FocusManager.instance.primaryFocus?.unfocus();
                                       Get.back();
                                      }

                                      },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(Dimensions.Width16-4),
                                      child: Container(
                                        width: double.infinity,
                                        height: Dimensions.Height44+8,
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
                                  SizedBox(height: Dimensions.Height20+10),
                                ]
                            )
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )
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
      height: Dimensions.Height100,
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
      padding: EdgeInsets.only(left: Dimensions.Width20+4, right: Dimensions.Width20+4, top: 46),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.arrow_back, size: Dimensions.Width20+4,),
          SizedBox(width: Dimensions.Width20,),
          const BigText(text: "testimony_screen")
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(Dimensions.Height100+26);
}
