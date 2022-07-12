import 'package:flutter/material.dart';

class ProductDetailsHeader extends StatefulWidget {
  final String productImage;
  const ProductDetailsHeader({
    Key? key,
    required this.productImage,
  }) : super(key: key);

  @override
  State<ProductDetailsHeader> createState() => _ProductDetailsHeaderState();
}

class _ProductDetailsHeaderState extends State<ProductDetailsHeader> {
  int _itemCount = 1;

  void _closeModalWindow(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _increaseItem() {
    setState(() {
      _itemCount++;
    });
  }

  void _decreaseItem() {
    if (_itemCount > 1) {
      setState(() {
        _itemCount--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  right: 0,
                  top: 0,
                  child: ElevatedButton(
                    onPressed: () => _closeModalWindow(context),
                    child: const Icon(Icons.keyboard_arrow_down, size: 26),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      elevation: 0,
                      shape: const CircleBorder(),
                    ),
                  ),
                ),
                if (widget.productImage.startsWith('http'))
                  Image.network(
                    widget.productImage,
                    width: 230,
                    height: 230,
                  ),
                if (!widget.productImage.startsWith('http'))
                  Image.asset(
                    widget.productImage,
                    width: 230,
                    height: 230,
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _decreaseItem,
                  child: const Icon(Icons.remove, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white.withOpacity(0.3),
                    elevation: 0,
                    shape: const CircleBorder(),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  alignment: Alignment.center,
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$_itemCount',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _increaseItem,
                  child: const Icon(Icons.add, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white.withOpacity(0.3),
                    elevation: 0,
                    shape: const CircleBorder(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
