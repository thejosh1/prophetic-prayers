import 'package:flutter/material.dart';
import 'package:prophetic_prayers/controller/auth_controller.dart';
import 'package:prophetic_prayers/pages/auth_pages/sign_up.dart';
import 'package:get/get.dart';

import '../../utils/dimensions.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(),
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _isObscure;
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.Width20+2),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: Dimensions.Height100),
              TextFormField(
                controller: _emailController,
                style: const TextStyle(),
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: Dimensions.Width2-1,
                      color: const Color(0xffBEC2CE),
                    ),
                  ),
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    color: const Color(0xffBEC2CE),
                    fontSize: Dimensions.Width16,
                  ),
                  prefixIcon: const Icon(
                    Icons.person_add_outlined,
                    color: Color(0xffBEC2CE),
                  ),
                ),
                  validator: (value) {
                    if(value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(value)) {
                      return "please enter a correct email";
                    } else {
                      return null;
                    }
                  }
              ),
              SizedBox(height: Dimensions.Height40),
              TextFormField(
                controller: _passwordController,
                style: const TextStyle(),
                obscureText: _isObscure,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: Dimensions.Width2-1,
                      color: const Color(0xffBEC2CE),
                    ),
                  ),
                  hintText: 'Password',
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
                ),
                  validator: (value) {
                    if(value!.isEmpty || !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)) {
                      return "please password should contain 1 Upper case,\n 1 lowercase,\n 1 Numeric Number,\n 1 Special Character";
                    } else {
                      return null;
                    }
                  }
              ),
              SizedBox(height: Dimensions.Height40+3),
              GestureDetector(
                onTap: () {
                  if(_formKey.currentState!.validate()) {
                    AuthController.instance.Login(_emailController.text.trim(), _passwordController.text.trim());
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
                      'LOGIN',
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
              GestureDetector(
                onTap: () {
                  Get.to(()=> const ForgotPasswordScreen());
                },
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xffBEC2CE),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.Height10*3),
              GestureDetector(
                onTap: (() {
                  Get.offAll(()=> const SignUpScreen());
                }),
                child: const Text(
                  'Here for the first time? Sign up',
                  style: TextStyle(
                    color: Color(0xffBEC2CE),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
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
              Icon(Icons.more_vert),
            ],
          ),
          SizedBox(height: Dimensions.Height20+1),
          Text(
            'Log in',
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
