import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoes/controllers/cart_provider.dart';
import 'package:shoes/controllers/payment_controller.dart';
import 'package:shoes/models/cart/get_products.dart';
import 'package:shoes/models/orders/orders_req.dart';
import 'package:shoes/services/cart_helper.dart';
import 'package:shoes/services/payment_helper.dart';
import 'package:shoes/views/shared/shared.dart';
import 'package:shoes/views/ui/mainScreen.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<dynamic> cart = [];
  late Future<List<Product>> _cartList;

  @override
  void initState() {
    _cartList = CartHelper().getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    var paymentNotifier = Provider.of<PaymentNotifier>(context);
    cartProvider.getCart();
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    AntDesign.close,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'My Cart',
                  style: appStyle(36, Colors.black, FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.60,
                  child: FutureBuilder(
                      future: _cartList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator.adaptive());
                        } else if (snapshot.hasError) {
                          return Center(
                            child: ReusableText(
                                text: "Failed to get cart item",
                                style: appStyle(
                                    18, Colors.black, FontWeight.w600)),
                          );
                        } else {
                          final cartData = snapshot.data;
                        return ListView.builder(
                          itemCount: cartData!.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final data = cartData[index];
                            return GestureDetector(
                              onTap: () {
                                cartProvider.setProductIndex = index;
                                cartProvider.checkout.insert(0, data);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: ClipRRect(
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(12)),
                                  child: Slidable(
                                    key: const ValueKey(0),
                                    endActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                              flex: 1,
                                              backgroundColor:
                                                  const Color(0xFF000000),
                                              foregroundColor: Colors.white,
                                              icon: Icons.delete,
                                              label: 'Delete',
                                              onPressed: (BuildContext _) async{
                                                await CartHelper().deleteItem(data.id).then((response) {
                                                  if(response == true){
                                                    Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MainScreen()));
                                                  } else {
                                                    debugPrint("Failed to delete the item");
                                                  }
                                                });
                                              }),
                                        ]),
                                    child: Container(
                                      height: MediaQuery.of(context).size.height *
                                          0.12,
                                      width: MediaQuery.of(context).size.width,
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
                                          Stack(
                                            children: [Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(12),
                                                  child: CachedNetworkImage(
                                                    imageUrl: data.cartItem.imageUrl[0],
                                                    width: 70,
                                                    height: 70,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 12, left: 20),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        data.cartItem.name,
                                                        style: appStyle(
                                                            14,
                                                            Colors.black,
                                                            FontWeight.bold),
                                                      ),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      Text(
                                                        data.cartItem.category,
                                                        style: appStyle(
                                                            12,
                                                            Colors.grey,
                                                            FontWeight.w600),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "\$${data.cartItem.price}",
                                                            style: appStyle(
                                                                14,
                                                                Colors.black,
                                                                FontWeight.w600),
                                                          ),
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          const SizedBox(
                                                            width: 15,
                                                          ),
                                                          
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Positioned(
                                                top: -1,
                                                left: 5,
                                                child: GestureDetector(
                                                  onTap: ()async{
                                                
                                              },
                                                  child: SizedBox(
                                                    height: 25,
                                                    width: 25,
                                                    child: Icon(
                                                      cartProvider.productIndex == index? Feather.check_square : Feather.square,
                                                      size: 16,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                ),
                                        
                                            Positioned(
                                                bottom: -2,
                                                child: GestureDetector(
                                                  onTap: ()async{
                                                await CartHelper().deleteItem(data.id).then((response) {
                                                  if(response == true){
                                                    Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MainScreen()));
                                                  } else {
                                                    debugPrint("Failed to delete the item");
                                                  }
                                                });
                                              },
                                                  child: Container(
                                                    width: 35,
                                                    height: 25,
                                                    decoration: const BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius: BorderRadius.only(
                                                        topRight: Radius.circular(12)
                                                      )
                                                    ),
                                                    child: const Icon(
                                                      AntDesign.delete,
                                                      size: 16,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ),
                                        ]),
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(16),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          // cartProvider.increment();
                                                        },
                                                        child: const Icon(
                                                          AntDesign.minussquare,
                                                          size: 18,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      Text(
                                                        // data['qty'].toString(),
                                                        data.quantity.toString(),
                                                        style: appStyle(
                                                            12,
                                                            Colors.black,
                                                            FontWeight.w600),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          // cartProvider.decrement();
                                                        },
                                                        child: const Icon(
                                                          AntDesign.plussquare,
                                                          size: 18,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                        }
                      }),
                )
              ],
            ),
            cartProvider.checkout.isNotEmpty ? Align(
              alignment: Alignment.bottomCenter,
              child: CheckoutButton(
                onTap: () async{
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    String? userId = prefs.getString('userId')??"";
                  Order model = Order(
                    userId: userId, cartItems: [
                      CartItem(
                      name: cartProvider.checkout[0].cartItem.name, 
                      id: cartProvider.checkout[0].cartItem.id, 
                      price: cartProvider.checkout[0].cartItem.price, 
                      cartQuantity: 1
                      )
                    ]);
                    //paymentNotifier.paymentUrl
                    PaymentHelper().payment(model).then((value) {
                      paymentNotifier.setPaymentUrl = value;
                    });
                },
                label: 'Proceed to Checkout'),
            ) :const SizedBox.shrink(),
          ] 
        ),
      ),
    );
  }
}
