import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewShoes extends StatelessWidget {
  final String imageUrl;
  final void Function()? onTap;
  const NewShoes({
    super.key, required this.imageUrl, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
                Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                  color: Colors.white,
                  spreadRadius: 1,
                  blurRadius: 0.8,
                  offset: Offset(0, 1))
            ]),
        height:
            MediaQuery.of(context).size.height *
                0.12,
        width: MediaQuery.of(context).size.width *
            0.28,
        child: CachedNetworkImage(
          imageUrl: imageUrl
        ),
      ),
    );
  }
}
