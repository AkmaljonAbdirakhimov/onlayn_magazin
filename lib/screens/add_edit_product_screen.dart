import 'package:cyclop/cyclop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../widgets/manage_products/image_placeholder.dart';
import '../widgets/manage_products/custom_textfield.dart';

class AddEditScreen extends StatefulWidget {
  const AddEditScreen({Key? key}) : super(key: key);

  static const routeName = '/add-edit-product';

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _discountController = TextEditingController();
  final _mainImageController = TextEditingController();
  final _firstImageController = TextEditingController();
  final _secondImageController = TextEditingController();
  final _thirdImageController = TextEditingController();
  final _fourthImageController = TextEditingController();

  bool _isNew = false;
  Color? _color;

  // validation variables
  bool _hasMainImage = true;
  bool _hasFirstImage = true;
  bool _hasSecondImage = true;
  bool _hasThirdImage = true;
  bool _hasFourthImage = true;

  var productId;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then(
      (value) {
        _color = Theme.of(context).primaryColor;

        productId = ModalRoute.of(context)!.settings.arguments;
        if (productId != null) {
          final product = Provider.of<Products>(context, listen: false)
              .getById(productId as String);
          _titleController.text = product.title;
          _descriptionController.text = product.description;
          _priceController.text = product.price.toStringAsFixed(2);
          _discountController.text = product.discount.toStringAsFixed(0);
          _mainImageController.text = product.images[0];
          _firstImageController.text = product.images[1];
          _secondImageController.text = product.images[2];
          _thirdImageController.text = product.images[3];
          _fourthImageController.text = product.images[4];
          _color = product.color;
          _isNew = product.isNew;
        }
        setState(() {});
      },
    );
  }

  void _submit() {
    var hasImages = _checkImages();
    if (_formKey.currentState!.validate() && hasImages) {
      final product = Product(
        id: productId ?? UniqueKey().toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        images: [
          _mainImageController.text,
          _firstImageController.text,
          _secondImageController.text,
          _thirdImageController.text,
          _fourthImageController.text,
        ],
        isNew: _isNew,
        color: _color!,
        discount: _discountController.text.isEmpty
            ? 0
            : int.parse(_discountController.text),
      );
      if (productId == null) {
        Provider.of<Products>(context, listen: false).addProduct(product);
      } else {
        Provider.of<Products>(context, listen: false).editProduct(product);
      }
      Navigator.of(context).pop();
    }
  }

  bool _checkImages({int? imageIndex}) {
    switch (imageIndex) {
      case 0:
        _hasMainImage = true;
        break;
      case 1:
        _hasFirstImage = true;
        break;
      case 2:
        _hasSecondImage = true;
        break;
      case 3:
        _hasThirdImage = true;
        break;
      case 4:
        _hasFourthImage = true;
        break;
      default:
        _mainImageController.text.isEmpty
            ? _hasMainImage = false
            : _hasMainImage = true;
        _firstImageController.text.isEmpty
            ? _hasFirstImage = false
            : _hasFirstImage = true;
        _secondImageController.text.isEmpty
            ? _hasSecondImage = false
            : _hasSecondImage = true;
        _thirdImageController.text.isEmpty
            ? _hasThirdImage = false
            : _hasThirdImage = true;
        _fourthImageController.text.isEmpty
            ? _hasFourthImage = false
            : _hasFourthImage = true;
    }

    setState(() {});

    return _hasMainImage &&
        _hasFirstImage &&
        _hasSecondImage &&
        _hasThirdImage &&
        _hasFourthImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          productId == null ? 'Mahsulot Qo\'shish' : 'Mahsulotni Tahrirlash',
          style: Theme.of(context).textTheme.headline2,
        ),
        actions: [
          IconButton(
            onPressed: _submit,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomTextField(
                  labelText: 'Nomi',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Iltimos mahsulot nomini kiriting!';
                    } else if (value.length < 5) {
                      return 'Iltimos uzunroq nom kiriting!';
                    }
                  },
                  controller: _titleController,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  labelText: 'Ta\'rifi',
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Iltimos mahsulot ta\'rifini kiriting!';
                    } else if (value.length < 4) {
                      return 'Iltimos, batafsil ta\'rif kiriting!';
                    }
                  },
                  controller: _descriptionController,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  labelText: 'Narxi',
                  keyboard: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Iltimos mahsulot narxini kiriting!';
                    } else if (double.parse(value) < 5) {
                      return 'Narxi \$5 dan katta bo\'lishi kerak!';
                    }
                  },
                  controller: _priceController,
                  formats: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)$'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  labelText: 'Chegirma %',
                  keyboard: TextInputType.number,
                  controller: _discountController,
                  formats: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Mahsulot yangimi:',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    Checkbox(
                      value: _isNew,
                      onChanged: (value) {
                        setState(() {
                          _isNew = value!;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Orqa fon rangini tanlang: ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    ColorButton(
                      color: _color ?? Colors.white,
                      boxShape: BoxShape.rectangle,
                      size: 32,
                      config: const ColorPickerConfig(
                        enableEyePicker: false,
                      ),
                      onColorChanged: (value) {
                        setState(() {
                          _color = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ImagePlaceholder(
                  width: double.infinity,
                  height: 200,
                  labelText: 'Asosiy rasm linkini qo\'ying (png formatda)!',
                  controller: _mainImageController,
                  hasImage: _hasMainImage,
                  checkImage: _checkImages,
                  imageIndex: 0,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Qo\'shimcha rasmlar:',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      Expanded(
                        child: GridView(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                          ),
                          children: [
                            ImagePlaceholder(
                              height: 100,
                              width: 100,
                              labelText: 'RASM 1',
                              controller: _firstImageController,
                              hasImage: _hasFirstImage,
                              checkImage: _checkImages,
                              imageIndex: 1,
                            ),
                            ImagePlaceholder(
                              height: 100,
                              width: 100,
                              labelText: 'RASM 2',
                              controller: _secondImageController,
                              hasImage: _hasSecondImage,
                              checkImage: _checkImages,
                              imageIndex: 2,
                            ),
                            ImagePlaceholder(
                              height: 100,
                              width: 100,
                              labelText: 'RASM 3',
                              controller: _thirdImageController,
                              hasImage: _hasThirdImage,
                              checkImage: _checkImages,
                              imageIndex: 3,
                            ),
                            ImagePlaceholder(
                              height: 100,
                              width: 100,
                              labelText: 'RASM 4',
                              controller: _fourthImageController,
                              hasImage: _hasFourthImage,
                              checkImage: _checkImages,
                              imageIndex: 4,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
