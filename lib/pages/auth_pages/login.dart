import 'package:flutter/material.dart';

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
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          children: [
            SizedBox(height: 100),
            const TextField(
              style: TextStyle(),
              decoration: InputDecoration(
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
            const TextField(
              style: TextStyle(),
              obscureText: true,
              decoration: InputDecoration(
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
              onTap: () {},
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
            const Text(
              'Forgot password?',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xffBEC2CE),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Here for the first time? Sign up',
              style: TextStyle(
                color: Color(0xffBEC2CE),
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
