import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:shoes/controllers/login_provider.dart';
import 'package:shoes/services/authhelper.dart';
import 'package:shoes/views/ui/auth/login.dart';
import 'package:shoes/views/ui/cartpage.dart';
import 'package:shoes/views/ui/favorites.dart';
import 'package:shoes/views/ui/nonuser.dart';

import '../shared/shared.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<LoginNotifier>(context);
    return authNotifier.loggeIn == false ? const NonUser() : Scaffold(
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
            height: 65,
            decoration: const BoxDecoration(
              color: Color(0xFFE2E2E2),
            ),
            child: Column(
              children: [
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
                          FutureBuilder(
                            future: AuthHelper().getProfile(),
                            builder: (context, snapshot) {
                              if(snapshot.connectionState == ConnectionState.waiting){
                                return const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                );
                              } else if (snapshot.hasError){
                                return Center(
                                  child: ReusableText(text: "Error getting your data", style: appStyle(16, Colors.black, FontWeight.w600)),
                                );
                              } else {
                                final userData = snapshot.data;
                              return SizedBox(
                                height: 37,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ReusableText(
                                        text: userData?.username??"",
                                        style: appStyle(
                                            11, Colors.black, FontWeight.normal)),
                                    ReusableText(
                                        text: userData?.email??"",
                                        style: appStyle(
                                            11, Colors.black, FontWeight.normal)),
                                  ],
                                ),
                              );
                              }
                            }
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Feather.edit,
                              size: 18,
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 170,
                color: Colors.grey.shade200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TilesWidget(
                        OnTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        },
                        title: "My Orders",
                        leading: MaterialCommunityIcons.truck_fast_outline),
                    TilesWidget(
                        OnTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Favorites()));
                        },
                        title: "My Favorites",
                        leading: MaterialCommunityIcons.heart_outline),
                    TilesWidget(
                        OnTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartPage()));
                        },
                        title: "Cart",
                        leading: Fontisto.shopping_bag_1),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 115,
                color: Colors.grey.shade200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TilesWidget(
                        OnTap: () {},
                        title: "Coupons",
                        leading: MaterialCommunityIcons.tag_outline),
                    TilesWidget(
                        OnTap: () {},
                        title: "My Store",
                        leading: MaterialCommunityIcons.shopping_outline),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 170,
                color: Colors.grey.shade200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TilesWidget(
                        OnTap: () {},
                        title: "Shipping Address",
                        leading: SimpleLineIcons.location_pin),
                    TilesWidget(
                        OnTap: () {},
                        title: "Settings",
                        leading: AntDesign.setting),
                    TilesWidget(
                        OnTap: () {
                          authNotifier.logout();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        },
                        title: "Logout",
                        leading: AntDesign.logout),
                  ],
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
