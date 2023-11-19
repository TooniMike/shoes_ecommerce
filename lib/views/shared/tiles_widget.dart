import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';


class TilesWidget extends StatelessWidget {
  final String title;
  final IconData leading;
  final Function()? OnTap;

  const TilesWidget({
    Key? key,
    required this.title,
    required this.leading,
    // ignore: non_constant_identifier_names
    this.OnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: OnTap,
        leading: Icon(leading, color: Colors.grey.shade700),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: title != "Settings"
            ? const Icon(
                AntDesign.right,
                size: 16,
              )
            : SvgPicture.asset(
                "assets/images/usa.svg",
                width: 15,
                height: 20,
              ));
  }
}