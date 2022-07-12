import 'package:flutter/material.dart';

import 'custom_textfield.dart';

class ImagePlaceholder extends StatefulWidget {
  final double width;
  final double height;
  final String labelText;
  final TextEditingController controller;
  bool hasImage;
  final Function checkImage;
  final int imageIndex;
  ImagePlaceholder({
    Key? key,
    required this.width,
    required this.height,
    required this.labelText,
    required this.controller,
    this.hasImage = true,
    required this.checkImage,
    required this.imageIndex,
  }) : super(key: key);

  @override
  State<ImagePlaceholder> createState() => _ImagePlaceholderState();
}

class _ImagePlaceholderState extends State<ImagePlaceholder> {
  final _imageFormKey = GlobalKey<FormState>();

  void _submitImage() {
    if (_imageFormKey.currentState!.validate()) {
      setState(() {
        widget.hasImage = true;
      });
      widget.checkImage(imageIndex: widget.imageIndex);
      Navigator.of(context).pop();
    }
  }

  void _openImageUrlDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Rasm linkini kiriting!'),
          content: Form(
            key: _imageFormKey,
            child: CustomTextField(
              labelText: 'Rasm URL',
              controller: widget.controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Iltimos mahsulot rasmini kiriting!';
                } else if (value.length < 5) {
                  return 'Iltimos uzunroq url kiriting!';
                }
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'BEKOR QILISH',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            ElevatedButton(
              onPressed: _submitImage,
              child: const Text('SAQLASH'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 1.0,
          color: widget.hasImage ? Colors.grey : Colors.red,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: _openImageUrlDialog,
        splashColor: Theme.of(context).primaryColor.withOpacity(0.5),
        highlightColor: Colors.transparent,
        child: Container(
          height: widget.height,
          width: widget.width,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: widget.controller.text.isNotEmpty
              ? widget.controller.text.startsWith('http')
                  ? Image.network(
                      widget.controller.text,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      widget.controller.text,
                      fit: BoxFit.cover,
                    )
              : Text(
                  widget.labelText,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 16,
                        color: widget.hasImage ? Colors.black : Colors.red,
                      ),
                ),
        ),
      ),
    );
  }
}
