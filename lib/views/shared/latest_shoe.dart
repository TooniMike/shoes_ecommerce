import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shoes/models/sneaker_model.dart';
import 'package:shoes/views/ui/product_page.dart';
import 'shared.dart';

// ignore: camel_case_types
class latestShoes extends StatelessWidget {
  const latestShoes({
    super.key,
    required Future<List<Sneakers>> male,
  }) : _male = male;

  final Future<List<Sneakers>> _male;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sneakers>>(
        future: _male,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (snapshot.hasError) {
            return Text('Error ${snapshot.error}');
          } else {
            final male = snapshot.data;
            return StaggeredGridView.countBuilder(
                padding: EdgeInsets.zero,
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 16,
                itemCount: male!.length,
                scrollDirection: Axis.vertical,
                staggeredTileBuilder: (index) => StaggeredTile.extent(
                    (index % 2 == 0) ? 1 : 1,
                    (index % 4 == 1 || index % 4 == 3)
                        ? MediaQuery.of(context).size.height * 0.35
                        : MediaQuery.of(context).size.height * 0.308),
                itemBuilder: (context, index) {
                  final shoe = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductPage(sneakers: shoe),
                        ),
                      );
                    },
                    child: StaggerTile(
                      imageUrl: shoe.imageUrl[1],
                      name: shoe.name,
                      price: '\$${shoe.price}',
                    ),
                  );
                });
          }
        });
  }
}
