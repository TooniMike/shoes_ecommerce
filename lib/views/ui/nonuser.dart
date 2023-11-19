import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shoes/views/shared/appstyle.dart';
import 'package:shoes/views/shared/reusable_text.dart';

import 'ui.dart';

class NonUser extends StatelessWidget {
  const NonUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE2E2E2),
        elevation: 0,
        leading: const Icon(
          MaterialCommunityIcons.qrcode_scan,
          size: 18,
          color: Colors.black,
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/usa.svg',
                    width: 20,
                    height: 25,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 15,
                    width: 1,
                    color: Colors.grey,
                  ),
                  ReusableText(
                      text: " USA",
                      style: appStyle(16, Colors.black, FontWeight.normal)),
                  const SizedBox(
                    width: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Icon(
                      SimpleLineIcons.settings,
                      color: Colors.black,
                      size: 18,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 750,
            decoration: const BoxDecoration(
              color: Color(0xFFE2E2E2),
            ),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 16, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          height: 35,
                          width: 35,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/user.jpeg'),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        ReusableText(
                            text: "Hello, Please Login into your Account",
                            style:
                                appStyle(11, Colors.grey.shade600, FontWeight.normal)),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 5),
                        width: 60,
                        height: 35,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Center(
                          child: ReusableText(
                            text: "Login",
                            style:
                                appStyle(10, Colors.white, FontWeight.normal),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ]),
          )
        ]),
      ),
    );
  }
}
