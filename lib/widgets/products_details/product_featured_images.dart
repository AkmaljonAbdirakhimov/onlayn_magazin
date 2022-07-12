import 'package:flutter/material.dart';

import 'circle_image.dart';

class ProductFeaturedImages extends StatelessWidget {
  final List<String> images;
  const ProductFeaturedImages({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: images
          .map(
            (image) => Row(
              children: [
                CircleImage(radius: 30, image: image),
                const SizedBox(width: 10),
              ],
            ),
          )
          .toList(),
    );
  }
}
