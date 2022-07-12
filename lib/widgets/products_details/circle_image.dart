import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final double radius;
  final String image;
  const CircleImage({
    Key? key,
    required this.image,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey.shade100,
      child: image.startsWith('http')
          ? Image.network(
              image,
              width: radius + 10,
            )
          : Image.asset(
              image,
              width: radius + 10,
            ),
    );
  }
}
