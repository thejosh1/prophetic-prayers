import 'package:flutter/material.dart';
import 'package:prophetic_prayers/controller/auth_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../utils/dimensions.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(),
      body: ForgotPasswordForm(),
    );
  }
}

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  FirebaseStorage storage = FirebaseStorage.instance;
  final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController _confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    //_confirmPasswordController.dispose();
    _emailController.dispose();
    //_passwordController.dispose();
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
                      style:  TextStyle(),
                      controller: _emailController,
                      textInputAction: TextInputAction.done,
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
                    SizedBox(height: Dimensions.Height100*2),
                    GestureDetector(
                      onTap: () async{
                          AuthController.instance.resetPassword(
                            _emailController.text.trim()
                          );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.Width16-4),
                        child: Container(
                          width: double.infinity,
                          height: Dimensions.Height100-50,
                          color: Colors.orange,
                          alignment: Alignment.center,
                          child: Text(
                            'Reset Password',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimensions.Width16+2,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]
              ),
            ),
          ),
        )
    );
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
            'Reset Password',
            style: TextStyle(
              fontSize: Dimensions.Height40-6,
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
