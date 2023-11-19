import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:shoes/controllers/product_provider.dart';
import 'package:shoes/models/sneaker_model.dart';
import '../ui/ui.dart';
import 'shared.dart';

class HomeWidget extends StatelessWidget {
  final Future<List<Sneakers>> _male;
  final int tabIndex;
  const HomeWidget({
    super.key,
    required Future<List<Sneakers>> male,
    required this.tabIndex,
  }) : _male = male;

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.405,
            child: FutureBuilder<List<Sneakers>>(
                future: _male,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  } else if (snapshot.hasError) {
                    return Text('Error ${snapshot.error}');
                  } else {
                    final male = snapshot.data;
                    return ListView.builder(
                        itemCount: male!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final shoe = snapshot.data![index];
                          return GestureDetector(
                            onTap: () {
                              productNotifier.shoesSizes = shoe.sizes;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductPage(sneakers: shoe)));
                            },
                            child: ProductCard(
                                price: '\$${shoe.price}',
                                category: shoe.category,
                                id: shoe.id,
                                name: shoe.name,
                                image: shoe.imageUrl[0]),
                          );
                        });
                  }
                })),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Latest Shoes',
                    style: appStyle(20, Colors.black, FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductByCart(
                                    tabIndex: tabIndex,
                                  )));
                    },
                    child: Row(
                      children: [
                        Text(
                          'Show All',
                          style: appStyle(18, Colors.black, FontWeight.w500),
                        ),
                        const Icon(
                          AntDesign.caretright,
                          size: 15,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.13,
          child: FutureBuilder<List<Sneakers>>(
            future: _male,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              } else if (snapshot.hasError) {
                return Text('Error ${snapshot.error}');
              } else {
                final male = snapshot.data;
                return ListView.builder(
                  itemCount: male!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final shoe = snapshot.data![index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NewShoes(
                          onTap: () {
                            productNotifier.shoesSizes = shoe.sizes;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductPage(sneakers: shoe),
                              ),
                            );
                          },
                          imageUrl: shoe.imageUrl[1]),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
