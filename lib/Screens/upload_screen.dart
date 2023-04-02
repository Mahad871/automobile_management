import 'dart:typed_data';

import 'package:automobile_management/Widgets/custom_elevated_button.dart';
import 'package:automobile_management/Widgets/custom_textformfield.dart';
import 'package:automobile_management/Widgets/custom_toast.dart';
import 'package:automobile_management/Widgets/custom_validator.dart';
import 'package:automobile_management/Widgets/cutom_text.dart';
import 'package:automobile_management/function/time_date_function.dart';
import 'package:automobile_management/models/product_model.dart';
import 'package:automobile_management/services/databse_storage.dart';
import 'package:automobile_management/services/product_api.dart';
import 'package:automobile_management/utilities/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Common/constants.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final TextEditingController productname = TextEditingController();
  final TextEditingController productdecription = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  final TextEditingController category = TextEditingController();
  final TextEditingController subcategory = TextEditingController();
  Uint8List? _image;
  bool _isloading = false;
  final _formKey = GlobalKey<FormState>();
  Future<void> uploaddata() async {
    if (_formKey.currentState!.validate() && _image != null) {
      setState(() {
        _isloading = true;
      });
      String imageurl = await Storagemethod().uploadtostorage(
        'post',
        'tester',
        _image!,
      );

      Product product = Product(
        pid: TimeStamp.timestamp.toString(),
        amount: int.parse(amount.text),
        colors: '',
        quantity: quantity.text,
        productname: productname.text,
        description: productdecription.text,
        timestamp: TimeStamp.timestamp,
        category: category.text,
        subCategory: subcategory.text,
        createdByUID: 'tester',
        imageurl: imageurl,
      );
      bool temp = await ProductApi().add(product);
      if (temp) {
        CustomToast.successToast(message: 'ho giya upload');
        productname.clear();
        productdecription.clear();
        amount.clear();
        category.clear();
        quantity.clear();
        subcategory.clear();
      }
      setState(() {
        _isloading = false;
      });
    }
  }

  selectImage() async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _image != null
                      ? GestureDetector(
                          onTap: () {
                            selectImage();
                          },
                          child: Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: MemoryImage(_image!))),
                          ),
                        )
                      : Container(
                          height: 200,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  onPressed: selectImage,
                                  icon: const Icon(
                                      Icons.add_circle_outline_outlined,
                                      color: Colors.white,
                                      size: 36),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const ForText(
                                  name: 'Add Image',
                                  color: Colors.white,
                                  size: 22,
                                )
                              ],
                            ),
                          ),
                        ),
                  textField(context, productname, 'name'),
                  textField(context, productdecription, 'Description'),
                  textField(context, amount, 'amount'),
                  textField(context, quantity, 'quantity'),
                  textField(context, category, 'category'),
                  textField(context, subcategory, 'subcategory'),
                  const SizedBox(height: 20),
                  _isloading
                      ? const CircularProgressIndicator()
                      : Center(
                          child: GestureDetector(
                            onTap: () {
                              uploaddata();
                            },
                            child: Container(
                              height: 55,
                              width: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.black,
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: _isloading
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : const Text(
                                          ' Upload',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textField(
      BuildContext context, TextEditingController controller, String hint) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          // starticon: Icons.person,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(color: hintTextColor),
          ),
          // validator: (String? value) => CustomValidator.isEmpty(value),
        ),
      ],
    );
  }
}
