import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:shoes/controllers/favorites_provider.dart';
import 'package:shoes/controllers/login_provider.dart';
import 'package:shoes/controllers/product_provider.dart';
import 'package:shoes/models/cart/add_to_cart.dart';
import 'package:shoes/models/sneaker_model.dart';
import 'package:shoes/services/cart_helper.dart';
import 'package:shoes/views/ui/ui.dart';
import '../shared/shared.dart';

class ProductPage extends StatefulWidget {
  final Sneakers sneakers;
  const ProductPage({super.key, required this.sneakers});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var favoritesNotifier =
        Provider.of<FavoritesNotifier>(context, listen: true);
    var authNotifier = Provider.of<LoginNotifier>(context);
    favoritesNotifier.getFavorites();
    return Scaffold(body: Consumer<ProductNotifier>(
      builder: (context, productNotifier, child) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              leadingWidth: 0,
              title: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        productNotifier.shoeSizes.clear();
                      },
                      child: const Icon(
                        AntDesign.close,
                        color: Colors.black,
                      ),
                    ),
                    Consumer<FavoritesNotifier>(
                      builder: (context, FavoritesNotifier, child) {
                        return GestureDetector(
                          onTap: () {
                            if (authNotifier.loggeIn == true) {
                              if (FavoritesNotifier.ids
                                  .contains(widget.sneakers.id)) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Favorites()));
                              } else {
                                favoritesNotifier.createFav({
                                  "id": widget.sneakers.id,
                                  "name": widget.sneakers.name,
                                  "category": widget.sneakers.category,
                                  "price": widget.sneakers.price,
                                  "imageUrl": widget.sneakers.imageUrl[0],
                                });
                              }
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            }
                          },
                          child:
                              FavoritesNotifier.ids.contains(widget.sneakers.id)
                                  ? const Icon(
                                      AntDesign.heart,
                                      color: Colors.black,
                                    )
                                  : const Icon(
                                      AntDesign.hearto,
                                      color: Colors.black,
                                    ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              pinned: true,
              snap: false,
              floating: true,
              backgroundColor: Colors.transparent,
              expandedHeight: MediaQuery.of(context).size.height,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.49,
                      width: MediaQuery.of(context).size.width,
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.sneakers.imageUrl.length,
                        controller: pageController,
                        onPageChanged: (page) {
                          productNotifier.activePage = page;
                        },
                        itemBuilder: (context, int index) {
                          return Stack(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.39,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.grey.shade300,
                                child: CachedNetworkImage(
                                  imageUrl: widget.sneakers.imageUrl[index],
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                left: 0,
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List<Widget>.generate(
                                    widget.sneakers.imageUrl.length,
                                    (index) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: CircleAvatar(
                                        radius: 5,
                                        backgroundColor:
                                            productNotifier.activepage != index
                                                ? Colors.grey
                                                : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.64,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.sneakers.name,
                                  style: appStyle(
                                      30, Colors.black, FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      widget.sneakers.category,
                                      style: appStyle(
                                          16, Colors.grey, FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    RatingBar.builder(
                                      initialRating: 4,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 22,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 1),
                                      itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          size: 18,
                                          color: Colors.black),
                                      onRatingUpdate: (rating) {},
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '\$${widget.sneakers.price}',
                                      style: appStyle(
                                          22, Colors.black, FontWeight.w600),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Colors',
                                          style: appStyle(18, Colors.black,
                                              FontWeight.w500),
                                        ),
                                        const SizedBox(width: 5),
                                        const CircleAvatar(
                                          radius: 7,
                                          backgroundColor: Colors.black,
                                        ),
                                        const SizedBox(width: 5),
                                        const CircleAvatar(
                                          radius: 7,
                                          backgroundColor: Colors.amber,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Select sizes',
                                          style: appStyle(16, Colors.black,
                                              FontWeight.w600),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          'View size guide',
                                          style: appStyle(
                                              16, Colors.grey, FontWeight.w600),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 40,
                                      child: ListView.builder(
                                        itemCount:
                                            productNotifier.shoeSizes.length,
                                        scrollDirection: Axis.horizontal,
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          final sizes =
                                              productNotifier.shoeSizes[index];
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            child: ChoiceChip(
                                              disabledColor: Colors.white,
                                              label: Text(
                                                sizes['size'],
                                                style: appStyle(
                                                    12,
                                                    sizes['isSelected']
                                                        ? Colors.white
                                                        : Colors.black38,
                                                    FontWeight.w500),
                                              ),
                                              selectedColor: Colors.black,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              selected: sizes['isSelected'],
                                              onSelected: (newState) {
                                                if (productNotifier.sizes
                                                    .contains(sizes['size'])) {
                                                  productNotifier.sizes
                                                      .remove(sizes['size']);
                                                } else {
                                                  productNotifier.sizes
                                                      .add(sizes['size']);
                                                }
                                                productNotifier.toggleCheck(
                                                  index,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(
                                  indent: 10,
                                  endIndent: 10,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: Text(
                                    widget.sneakers.title,
                                    style: appStyle(
                                        16, Colors.black, FontWeight.w700),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Text(
                                    widget.sneakers.description,
                                    textAlign: TextAlign.justify,
                                    maxLines: 4,
                                    style: appStyle(
                                        12, Colors.black, FontWeight.normal),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: CheckoutButton(
                                      label: 'Add to Cart',
                                      onTap: () async {
                                        if (authNotifier.loggeIn == true) {
                                          AddToCart model = AddToCart(
                                              cartItem: widget.sneakers.id,
                                              quantity: 1);
                                          CartHelper().addToCart(model);
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MainScreen()));
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginPage()),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    ));
  }
}
