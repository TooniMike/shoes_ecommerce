import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:shoes/controllers/product_provider.dart';
import 'package:shoes/views/shared/category_btn.dart';
import '../shared/shared.dart';

class ProductByCart extends StatefulWidget {
  final int tabIndex;
  const ProductByCart({super.key, required this.tabIndex});

  @override
  State<ProductByCart> createState() => _ProductByCartState();
}

class _ProductByCartState extends State<ProductByCart>
    with TickerProviderStateMixin {
      // late final int tabIndex;
      
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController.animateTo(widget.tabIndex, curve: Curves.easeIn);
  }

  @override
  void dispose(){
    _tabController.dispose();
    super.dispose();
  }

  List<String> brand = [
    'assets/images/adidas.png',
    'assets/images/gucci.png',
    'assets/images/jordan.png',
    'assets/images/nike.png',
  ];

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    productNotifier.getFemale();
    productNotifier.getMale();
    productNotifier.getKids();
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 30, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/top_image.png'),
                    fit: BoxFit.fill),
              ),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(6, 12, 16, 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          AntDesign.close,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // print(_tabController.toString());
                          filter();
                        },
                        child: const Icon(
                          FontAwesome.sliders,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                TabBar(
                    padding: EdgeInsets.zero,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.transparent,
                    controller: _tabController,
                    // controller: tabIndex,
                    isScrollable: true,
                    labelColor: Colors.white,
                    labelStyle: appStyle(24, Colors.white, FontWeight.bold),
                    unselectedLabelColor: Colors.grey.withOpacity(0.3),
                    tabs: const [
                      Tab(
                        text: 'Men Shoes',
                      ),
                      Tab(
                        text: 'Women Shoes',
                      ),
                      Tab(
                        text: 'Kids Shoes',
                      ),
                    ]),
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.175,
                left: 16,
                right: 12,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: TabBarView(controller: _tabController, children: [
                  latestShoes(male: productNotifier.male),
                  latestShoes(male: productNotifier.female),
                  latestShoes(male: productNotifier.kids),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> filter(){
    double _value = 100;
    return showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.white54,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height*0.84,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(26),
            topRight: Radius.circular(26),
          )
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 5,
              width: 40,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.black38,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.8,
              child: Column(
                children: [
                  const CustomSpacer(),
                  Text('Filter', style: appStyle(30, Colors.black, FontWeight.bold),),
                  const CustomSpacer(),
                  Text('Gender', style: appStyle(20, Colors.black, FontWeight.bold),),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      CategoryBtn(
                        buttonClr: Colors.black, 
                        label: 'Men'
                        ),
                        CategoryBtn(
                        buttonClr: Colors.grey, 
                        label: 'Women'
                        ),
                        CategoryBtn(
                        buttonClr: Colors.grey, 
                        label: 'Kids'
                        ),
                    ],
                  ),
                  const CustomSpacer(),
                  Text('Category', style: appStyle(20, Colors.black, FontWeight.w600),),
                  const SizedBox(height: 10,),
                  const Row(
                    children: [
                      CategoryBtn(buttonClr: Colors.black, label: 'Shoes'),
                      CategoryBtn(buttonClr: Colors.grey, label: 'Apparrels'),
                      CategoryBtn(buttonClr: Colors.grey, label: 'Accessories'),
                    ],
                  ),
                  const CustomSpacer(),
                  Text('Price', style: appStyle(20, Colors.black, FontWeight.w600),),
                  const CustomSpacer(),
                  Slider(
                    value: _value, 
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey,
                    thumbColor: Colors.black,
                    max: 500,
                    divisions: 50,
                    label: _value.toString(),
                    secondaryTrackValue: 200,
                    onChanged: (double value) {

                    }
                    ),
                    const CustomSpacer(),
                    Text('Brand', style: appStyle(20, Colors.black, FontWeight.bold),),
                    const SizedBox(height: 10,),
                    Container(
                      padding: const EdgeInsets.all(8),
                      height: 80,
                      child: ListView.builder(
                        itemCount: brand.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index){
                          return Padding(padding: const EdgeInsets.all(8),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: const BorderRadius.all(Radius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(brand[index], 
                                height: 60,
                                width: 70,
                                color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          );
                      }),
                    )
                ],
              ),
            )
          ],
        ),
      )
      );
  }
}


