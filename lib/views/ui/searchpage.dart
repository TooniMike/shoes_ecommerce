import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:shoes/controllers/product_provider.dart';
import 'package:shoes/services/helper.dart';
import '../../models/sneaker_model.dart';
import '../shared/shared.dart';
import 'ui.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: Colors.black,
        title: CustomField(
          hintText: 'Search for a product',
          controller: search,
          onEditingComplete: () {
            setState(() {});
          },
          prefixIcon: GestureDetector(
            onTap: () {},
            child: const Icon(
              AntDesign.camera,
              color: Colors.black,
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: const Icon(
              AntDesign.search1,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: search.text.isEmpty
          ? Container(
              height: 600,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(right: 50),
              child: Image.asset('assets/images/Pose23.png'),
            )
          : FutureBuilder<List<Sneakers>>(
              future: Helper().search(search.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: ReusableText(
                      text: 'Error Retriving the data',
                      style: appStyle(20, Colors.black, FontWeight.bold),
                    ),
                  );
                } else if (snapshot.data!.isEmpty) {
                  return Center(
                    child: ReusableText(
                      text: 'Product not found',
                      style: appStyle(20, Colors.black, FontWeight.bold),
                    ),
                  );
                } else {
                  final shoes = snapshot.data;
                  return ListView.builder(
                    itemCount: shoes!.length,
                    itemBuilder: ((context, index) {
                      final shoe = shoes[index];
                      return GestureDetector(
                        onTap: () {
                          productProvider.shoesSizes = shoe.sizes;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductPage(sneakers: shoe),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            child: Container(
                              height: 90,
                              width: 325,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade500,
                                    spreadRadius: 5,
                                    blurRadius: 0.3,
                                    offset: const Offset(0, 1),
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: CachedNetworkImage(
                                          imageUrl: shoe.imageUrl[0],
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 12, left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ReusableText(
                                                text: shoe.name,
                                                style: appStyle(16, Colors.black,
                                                    FontWeight.w600),
                                                    ),
                                                    const SizedBox(height: 3,),
                                                    ReusableText(
                                                text: shoe.category,
                                                style: appStyle(13, Colors.grey.shade600,
                                                    FontWeight.w600),
                                                    ),
                                                    const SizedBox(
                                                      height: 3,
                                                    ),
                                                    ReusableText(
                                                text: "\$ ${shoe.price}",
                                                style: appStyle(14, Colors.black,
                                                    FontWeight.w600),
                                                    )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                }
              },
            ),
    );
  }
}
