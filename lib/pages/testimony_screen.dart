import 'package:flutter/material.dart';

class TestimonyScreen extends StatefulWidget {
  const TestimonyScreen({Key? key}) : super(key: key);

  @override
  State<TestimonyScreen> createState() => _TestimonyScreenState();
}

class _TestimonyScreenState extends State<TestimonyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 16.7, top: 44),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_back,
                      size: 18,
                      color: Color(0xFF000000),
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_vert,
                      size: 20,
                      color: Color(0xFF000000),
                    ))
              ],
            ),
          ),
          Divider(
            height: 2,
            color: Color(0xFFEAECEF),
            thickness: 2,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          "REVIEW",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1E2432)),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Container(
                          height: 27,
                          width: 27,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFFE2952A)),
                          child: Text(
                            "15",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF1E2432)),
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: 154,
                      height: 28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Color(0xFF515BDE)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.hourglass_empty,
                            color: Color(0xFF515BDE),
                          ),
                          Text("Write a review")
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
