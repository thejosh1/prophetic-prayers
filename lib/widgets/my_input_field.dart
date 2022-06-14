import 'package:flutter/material.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget widget;
  const MyInputField({Key? key, required this.title, required this.hint, this.controller, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(),
          ),
          Container(
            margin: EdgeInsets.only(top: 8.0),
            padding: EdgeInsets.only(left: 14),
            height: 52,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(12)
            ),
            child: Row(
              children: [
                Expanded(child: TextFormField(
                  autofocus: false,
                  cursorColor: Colors.grey[700],
                  controller: controller,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 14
                  ),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 14
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 0
                      )
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white,
                            width: 0
                        )
                    ),
                  ),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
