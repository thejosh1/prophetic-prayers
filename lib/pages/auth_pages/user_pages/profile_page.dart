import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../base/custom_loader.dart';
import '../../../controller/auth_controllers/auth_controller.dart';
import '../../../controller/user_controllers/user_controller.dart';
import '../../../services/route_services.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/app_icons.dart';
import '../../../widgets/big_text.dart';
import '../../../widgets/profile_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseStorage storage = FirebaseStorage.instance;
  final user = AuthController.instance.auth.currentUser;
  final CollectionReference ref = FirebaseFirestore.instance.collection("users");
  final Collections = FirebaseFirestore.instance.collection("testimonies").doc().id;

  Future<void> showInformationDialogue(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text("Choose photo"),
            actions: [
              TextButton(
                  onPressed: () async{
                    Get.back(result: upload(true), closeOverlays: true);
                    Get.snackbar("Account Creation", "Picture has been saved");
                  },
                  child: const Text("browse gallery")
              ),
              TextButton(
                  onPressed: () async{
                    Get.back(result: upload(false), closeOverlays: true);
                    Get.snackbar("Account Creation", "Picture has been saved");
                  },
                  child: const Text("Take selfie")
              )
            ],
          );
        });
  }
  Future<void> showNameInformationDialogue(BuildContext context) async {
    TextEditingController _nameController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return await showDialog(
        context: context,
        builder: (context) {
          return GetBuilder<UserController>(builder: (_userController) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            return Scaffold(
              resizeToAvoidBottomInset: true,
              //backgroundColor: Colors.transparent,
              body: AlertDialog(
                content: Form(
                  key: formKey,
                  child: SizedBox(
                    height: Dimensions.Height100,
                    width: Dimensions.Width100,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget> [
                          MediaQuery.removePadding(
                            removeBottom: false,
                            removeTop: false,
                            removeLeft: true,
                            removeRight: true,
                            context: context,
                            child: TextFormField(
                              style: const TextStyle(),
                              controller: _nameController,
                              decoration: InputDecoration(
                                  hintText: 'Edit name',
                                  hintStyle: TextStyle(
                                    color: const Color(0xffBEC2CE),
                                    fontSize: Dimensions.Width16,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.edit_note,
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
                          ),
                          SizedBox(height: Dimensions.Height10,),
                          RichText(
                              text: TextSpan(
                                  recognizer: TapGestureRecognizer()..onTap=()=> {
                                    if(formKey.currentState!.validate()) {
                                      _userController.editName(_nameController.text.trim()),
                                      if (!currentFocus.hasPrimaryFocus) {
                                        currentFocus.unfocus(),
                                      },
                                      //FocusManager.instance.primaryFocus?.unfocus(),
                                      Navigator.of(context, rootNavigator: true).pop(),
                                      setState(() {}),
                                    }
                                  },
                                  text: "Submit",
                                  style: TextStyle(color: Colors.orange, fontSize: Dimensions.Width16)
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
        }
    );
  }
  // Future<void> showEmailInformationDialogue(BuildContext context) async {
  //   TextEditingController _emailController = TextEditingController();
  //   TextEditingController _passwordController = TextEditingController();
  //   final formKey = GlobalKey<FormState>();
  //   return await showDialog(
  //       context: context,
  //       builder: (context) {
  //         return GetBuilder<UserController>(builder: (_userController) {
  //           FocusScopeNode currentFocus = FocusScope.of(context);
  //           return Scaffold(
  //             resizeToAvoidBottomInset: true,
  //             //backgroundColor: Colors.transparent,
  //             body: AlertDialog(
  //               content: Form(
  //                 key: formKey,
  //                 child: SizedBox(
  //                   height: Dimensions.Height100*3,
  //                   width: Dimensions.Width100*3,
  //                   child: SingleChildScrollView(
  //                     child: Column(
  //                       children: <Widget> [
  //                         MediaQuery.removePadding(
  //                           removeBottom: false,
  //                           removeTop: false,
  //                           removeLeft: true,
  //                           removeRight: true,
  //                           context: context,
  //                           child: TextFormField(
  //                             style: const TextStyle(),
  //                             controller: _emailController,
  //                             decoration: InputDecoration(
  //                                 hintText: 'Type in your new email',
  //                                 hintStyle: TextStyle(
  //                                   color: const Color(0xffBEC2CE),
  //                                   fontSize: Dimensions.Width16,
  //                                 ),
  //                                 prefixIcon: const Icon(
  //                                   Icons.edit_note,
  //                                   color: Color(0xffBEC2CE),
  //                                 ),
  //                                 border: UnderlineInputBorder(
  //                                   borderSide: BorderSide(
  //                                       width: Dimensions.Width2-1,
  //                                       color: const Color(0xffBEC2CE)
  //                                   ),
  //                                 )
  //                             ),
  //                             validator: (value) {
  //                               if(value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(value)) {
  //                                 return "please enter a correct email";
  //                               } else {
  //                                 return null;
  //                               }
  //                             },
  //                           ),
  //                         ),
  //                         SizedBox(height: Dimensions.Height20,),
  //                         MediaQuery.removePadding(
  //                           removeBottom: false,
  //                           removeTop: false,
  //                           removeLeft: true,
  //                           removeRight: true,
  //                           context: context,
  //                           child: TextFormField(
  //                             style: const TextStyle(),
  //                             controller: _passwordController,
  //                             decoration: InputDecoration(
  //                                 hintText: 'Your recent password',
  //                                 hintStyle: TextStyle(
  //                                   color: const Color(0xffBEC2CE),
  //                                   fontSize: Dimensions.Width16,
  //                                 ),
  //                                 prefixIcon: const Icon(
  //                                   Icons.edit_note,
  //                                   color: Color(0xffBEC2CE),
  //                                 ),
  //                                 border: UnderlineInputBorder(
  //                                   borderSide: BorderSide(
  //                                       width: Dimensions.Width2-1,
  //                                       color: const Color(0xffBEC2CE)
  //                                   ),
  //                                 )
  //                             ),
  //                             validator: (value) {
  //                               if(value!.isEmpty || value.length<6) {
  //                                 return "please enter a correct password";
  //                               } else {
  //                                 return null;
  //                               }
  //                             },
  //                           ),
  //                         ),
  //                         SizedBox(height: Dimensions.Height60,),
  //                         GestureDetector(
  //                           onTap: () async {
  //                             if (formKey.currentState!.validate()) {
  //                               _userController.editEmail(
  //                                   _emailController.text.trim(),
  //                                   _passwordController.text.trim());
  //                               if (!currentFocus.hasPrimaryFocus) {
  //                                 currentFocus.unfocus();
  //                               }
  //                               //FocusManager.instance.primaryFocus?.unfocus(),
  //                               Get.offAllNamed(RouteServices.VERIFICATIONSCREEN);
  //                               setState(() {});
  //                             }
  //                           },
  //                           child: ClipRRect(
  //                             borderRadius: BorderRadius.circular(Dimensions.Width16-4),
  //                             child: Container(
  //                               width: double.infinity,
  //                               height: Dimensions.Height40+10,
  //                               color: Colors.orange,
  //                               alignment: Alignment.center,
  //                               child: Text(
  //                                 'Submit',
  //                                 style: TextStyle(
  //                                   color: Colors.white,
  //                                   fontSize: Dimensions.Width16+2,
  //                                   fontWeight: FontWeight.w700,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           );
  //         });
  //       }
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = AuthController.instance.auth.currentUser;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(),
        backgroundColor: const Color(0xffF7F8FA),
        body: GetBuilder<UserController>(builder: (_userController) {
          return FutureBuilder(
            future: _userController.getUserRoute(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                    height: size.height,
                    width: double.maxFinite,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        CustomLoader(),
                      ],
                    )
                );
              } else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data!.exists) {
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                return Container(
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: Dimensions.Height10,),
                                //image
                                Stack(
                                  children: [
                                    Positioned(
                                      child: StreamBuilder(
                                        stream: FirebaseFirestore.instance.collection("users").doc(user?.uid).snapshots(),
                                        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                                          if(!snapshot.hasData) {
                                            return const Center(child: CustomLoader());
                                          }
                                          Map<String, dynamic> data = snapshot.data!.data() as Map<String ,dynamic>;
                                          if(data["imagePath"] != null) {
                                            return Container(
                                              height: Dimensions.Height100+50,
                                              width: Dimensions.Height100+50,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage("${data["imagePath"]}"),
                                                      fit: BoxFit.cover
                                                  ),
                                                  shape: BoxShape.circle
                                              ),
                                            );
                                          }
                                          return Container(
                                            height: Dimensions.Height100+50,
                                            width: Dimensions.Height100+50,
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage("images/cute-boy.jpg"),
                                                    fit: BoxFit.cover
                                                ),
                                                shape: BoxShape.circle
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Positioned(
                                        right: 2,
                                        bottom: 5,
                                        child: GestureDetector(
                                          onTap: () async {
                                            showInformationDialogue(context).then((
                                                value) async => await uploadPfp().then((
                                                value) {}).then((
                                                value) async => await getDownload().then((
                                                value) => _userController.changeProfilePicture(value)
                                            )));
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.white, width: 2),
                                                shape: BoxShape.circle
                                            ),
                                            child: Container(
                                              width: double.maxFinite,
                                              height: double.maxFinite,
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle
                                              ),

                                              child: const Icon(Icons.add_a_photo, color: Colors.orange,),
                                            ),
                                          ),
                                        )
                                    )
                                  ],
                                ),
                                SizedBox(height: Dimensions.Height20+10),
                                //name
                                GestureDetector(
                                  onTap: () {
                                    showNameInformationDialogue(context);
                                  },
                                  child: ProfileWidget(
                                      appIcons: AppIcons(
                                        icon: Icons.person,
                                        iconcolor: Colors.white,
                                        backgroundColor: Colors.orange,
                                        size: Dimensions.Height10*5,
                                      ),
                                      bigText: BigText(text: data["name"],)
                                  ),
                                ),
                                SizedBox(height: Dimensions.Height10/2,),
                                //email
                                ProfileWidget(
                                    appIcons: AppIcons(
                                      icon: Icons.email,
                                      iconcolor: Colors.white,
                                      backgroundColor: Colors.orange,
                                      size: Dimensions.Height10*5,
                                    ),
                                    bigText: BigText(text: data["email"],)
                                ),
                                SizedBox(height: Dimensions.Height10/2,),
                                //testimonies
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(RouteServices.USERTESTIMONYPAGE);
                                  },
                                  child: ProfileWidget(
                                      appIcons: AppIcons(
                                        icon: Icons.list,
                                        iconcolor: Colors.white,
                                        backgroundColor: Colors.orange,
                                        size: Dimensions.Height10*5,
                                      ),
                                      bigText: const BigText(text: "Testimonies",)
                                  ),
                                ),
                                SizedBox(height: Dimensions.Height10/2,),
                                //testify
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(RouteServices.CREATETESTIMONYSCREEN);
                                  },
                                  child: ProfileWidget(
                                      appIcons: AppIcons(
                                        icon: Icons.edit,
                                        iconcolor: Colors.white,
                                        backgroundColor: Colors.orange,
                                        size: Dimensions.Height10*5,
                                      ),
                                      bigText: const BigText(text: "Testify",)
                                  ),
                                ),
                                SizedBox(height: Dimensions.Height10/2,),
                                //logout
                                GestureDetector(
                                  onTap: () {
                                    if(Get.find<AuthController>().isLoggedIn()) {
                                      Get.find<AuthController>().Logout();
                                      Get.offAllNamed(RouteServices.INITIAL);
                                    }
                                  },
                                  child: ProfileWidget(
                                      appIcons: AppIcons(
                                        icon: Icons.logout_outlined,
                                        iconcolor: Colors.white,
                                        backgroundColor: Colors.redAccent,
                                        size: Dimensions.Height10*5,
                                      ),
                                      bigText: const BigText(text: "Logout",)
                                  ),
                                ),
                                SizedBox(height: Dimensions.Height10/2,),
                              ],
                            ),
                          )
                      ),
                    ],
                  ),
                );
              }
              return Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(top: Dimensions.Height20),
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Get.snackbar("Operation Denied", "You need to sign in first");
                      },
                      child: Container(
                        height: Dimensions.Height100+50,
                        width: Dimensions.Width100+50,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/cute-boy.jpg"),
                                fit: BoxFit.cover
                            ),
                          shape: BoxShape.circle
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.Height20+10),
                    //profile icon
                    Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: <Widget>[
                              //name
                              GestureDetector(
                                onTap: () {
                                  Get.snackbar("Operation Denied", "You need to sign in first");
                                },
                                child: ProfileWidget(
                                    appIcons: AppIcons(
                                      icon: Icons.person,
                                      iconcolor: Colors.white,
                                      backgroundColor: Colors.orange,
                                      size: Dimensions.Height10*5,
                                    ),
                                    bigText: const BigText(text: "name",)
                                ),
                              ),
                              SizedBox(height: Dimensions.Height10/2,),
                              //email
                              GestureDetector(
                                onTap: () {
                                  Get.snackbar("Operation Denied", "You need to sign in first");
                                },
                                child: ProfileWidget(
                                    appIcons: AppIcons(
                                      icon: Icons.email,
                                      iconcolor: Colors.white,
                                      backgroundColor: Colors.orange,
                                      size: Dimensions.Height10*5,
                                    ),
                                    bigText: const BigText(text: "email",)
                                ),
                              ),
                              SizedBox(height: Dimensions.Height10/2,),
                              //testimonies
                              GestureDetector(
                                onTap: () {
                                  Get.snackbar("Operation Denied", "You need to sign in first");
                                },
                                child: ProfileWidget(
                                    appIcons: AppIcons(
                                      icon: Icons.list,
                                      iconcolor: Colors.white,
                                      backgroundColor: Colors.orange,
                                      size: Dimensions.Height10*5,
                                    ),
                                    bigText: const BigText(text: "Testimonies",)
                                ),
                              ),
                              SizedBox(height: Dimensions.Height10/2,),
                              //testify
                              GestureDetector(
                                onTap: () {
                                  Get.snackbar("Operation Denied", "You need to sign in first");
                                },
                                child: ProfileWidget(
                                    appIcons: AppIcons(
                                      icon: Icons.edit,
                                      iconcolor: Colors.white,
                                      backgroundColor: Colors.orange,
                                      size: Dimensions.Height10*5,
                                    ),
                                    bigText: const BigText(text: "Testify",)
                                ),
                              ),
                              SizedBox(height: Dimensions.Height10/2,),
                              //logout
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(RouteServices.LOGINPAGE);
                                },
                                child: ProfileWidget(
                                    appIcons: AppIcons(
                                      icon: Icons.logout_outlined,
                                      iconcolor: Colors.white,
                                      backgroundColor: Colors.redAccent,
                                      size: Dimensions.Height10*5,
                                    ),
                                    bigText: const BigText(text: "Sign In",)
                                ),
                              ),
                              SizedBox(height: Dimensions.Height10/2,),
                            ],
                          ),
                        )
                    ),
                  ],
                ),
              );
            },
          );
        },),
    );
  }
  XFile? photo;
  Future<void> upload(bool gallery) async {
    final picker = ImagePicker();
    if (gallery) {
      photo = await picker.pickImage(source: ImageSource.gallery);
      setState(() {});
    } else {
      photo = await picker.pickImage(source: ImageSource.camera, );
      setState(() {});
    }
  }


  Future<void> uploadPfp() async {
    if(photo != null) {
      File uploadFile =File(photo!.path);
      try {
        await storage.ref("avatar/${uploadFile.path}").putFile(
            uploadFile
        );
      } on FirebaseException catch(e) {
        Get.snackbar("Account Creation", e.toString(),
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } else if(photo == null){
      Get.snackbar("Account Creation", "You need to create a profile picture",
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          titleText: const Text("Account creation failed", style: TextStyle(color: Colors.white),),
          messageText: const Text(
            "You need a profile picture for this account", style: TextStyle(color: Colors.white),
          )
      );
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
    final user = AuthController.instance.auth.currentUser;
    // TODO: implement build
    return Container(
      height: Dimensions.Height100,
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            blurRadius: 0.5,
            spreadRadius: 0.5,
            offset: Offset(0, 3),
            color: Colors.transparent)
      ]),
      padding: EdgeInsets.only(left: Dimensions.Width20+4, right: Dimensions.Width20+4, top: Dimensions.Height40+6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          BigText(text: "My Profile")
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(Dimensions.Height100+26);
}

