import 'package:flutter/material.dart';

import 'package:get/get.dart';


class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 40),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                height: 50,
                width: size.width,
                child: Row(
                  children: [
                    IconButton(onPressed: (){
                      Get.back();
                    }, icon: Icon(Icons.arrow_back_ios)),
                    SizedBox(width: 20,),
                    const Text("Prophetic prayers for children", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              const Divider(),
              Container(
                margin: EdgeInsets.only( top: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: const Text(
                          """This prayer journal is designed for parents to raise a daily prayer altar for their children. The new method of worship is a design that also originated from the home of the Wesley’s. Another great source of inspiration for him were the Winans who produced great women of God like Dede and Cece Winans through discipline and prayers. The songs they wrote often originated from the rule of going over sermon notes after service.""",
                        style: TextStyle(fontWeight: FontWeight.bold, height: 1.5, fontSize: 24),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: const Text("The author received major inspiration from people like Susana Wesley who by consistency in prayer produced great men like Charles and John Wesley, founders of Methodist Church. The new method of worship is a design that also originated from the home of the Wesley’s.",
                          style: TextStyle(fontWeight: FontWeight.bold, height: 1.5, fontSize: 24),
                        )
                    ),
                    SizedBox(height: 20,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: const Text("Another great source of inspiration for him were the Winans who produced great women of God like Dede and Cece Winans through discipline and prayers. The songs they wrote often originated from the rule of going over sermon notes after service.",
                          style: TextStyle(fontWeight: FontWeight.bold, height: 1.5, fontSize: 24)
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Divider(),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
