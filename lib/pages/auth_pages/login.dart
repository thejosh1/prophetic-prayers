import 'package:flutter/material.dart';
import 'package:prophetic_prayers/controller/auth_controller.dart';
import 'package:prophetic_prayers/pages/auth_pages/sign_up.dart';
import 'package:get/get.dart';

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
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          children: [
            SizedBox(height: 100),
            TextField(
              controller: _emailController,
              style: TextStyle(),
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
                  Icons.person_add_outlined,
                  color: Color(0xffBEC2CE),
                ),
              ),
            ),
            SizedBox(height: 40),
            TextField(
              controller: _passwordController,
              style: TextStyle(),
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
            const SizedBox(height: 43),
            GestureDetector(
              onTap: () {
                AuthController.instance.Login(_emailController.text.trim(), _passwordController.text.trim());
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  color: const Color(0xff515BDE),
                  alignment: Alignment.center,
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
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
            const SizedBox(height: 30),
            GestureDetector(
              onTap: (() {
                Get.offAll(()=> const SignUpScreen());
              }),
              child: Text(
                'Here for the first time? Sign up',
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
              const Icon(Icons.arrow_back_outlined),
              const Icon(Icons.more_vert),
            ],
          ),
          const SizedBox(height: 21),
          const Text(
            'Log in',
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
