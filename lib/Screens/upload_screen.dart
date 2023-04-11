import 'dart:typed_data';

import 'package:automobile_management/widgets/custom_toast.dart';
import 'package:automobile_management/widgets/cutom_text.dart';
import 'package:automobile_management/function/time_date_function.dart';
import 'package:automobile_management/models/auth_method.dart';
import 'package:automobile_management/models/product_model.dart';
import 'package:automobile_management/services/databse_storage.dart';
import 'package:automobile_management/services/product_api.dart';
import 'package:automobile_management/utilities/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:automobile_management/dependency_injection/injection_container.dart';

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

  selectImage() async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthMethod authMethod = sl.get<AuthMethod>();
    Future<void> uploaddata() async {
      if (_formKey.currentState!.validate() && _image != null) {
        setState(() {
          _isloading = true;
        });
        String imageurl = await Storagemethod().uploadtostorage(
          'product',
          authMethod.currentUserData!.id.toString(),
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
          createdByUID: authMethod.currentUserData!.id.toString(),
          imageurl: imageurl,
          userImageurl: authMethod.currentUserData?.photoUrl,
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

    return SafeArea(
      child: Material(
        color: Colors.white,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: MemoryImage(_image!),
                              ),
                            ),
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
                  const SizedBox(height: 20),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: textFieldColor,
                    ),
                    padding: const EdgeInsets.only(left: 16),
                    child: TextField(
                      style: const TextStyle(color: textColor),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Name",
                        hintStyle: TextStyle(color: hintTextColor),
                      ),
                      controller: productname,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: textFieldColor,
                    ),
                    padding: const EdgeInsets.only(left: 16),
                    child: TextField(
                      style: const TextStyle(color: textColor),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Description",
                        hintStyle: TextStyle(color: hintTextColor),
                      ),
                      controller: productdecription,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: textFieldColor,
                    ),
                    padding: const EdgeInsets.only(left: 16),
                    child: TextField(
                      style: const TextStyle(color: textColor),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "amount",
                        hintStyle: TextStyle(color: hintTextColor),
                      ),
                      controller: amount,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: textFieldColor,
                    ),
                    padding: const EdgeInsets.only(left: 16),
                    child: TextField(
                      style: const TextStyle(color: textColor),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Quantity",
                        hintStyle: TextStyle(color: hintTextColor),
                      ),
                      controller: quantity,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: textFieldColor,
                    ),
                    padding: const EdgeInsets.only(left: 16),
                    child: TextField(
                      style: const TextStyle(color: textColor),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Category",
                        hintStyle: TextStyle(color: hintTextColor),
                      ),
                      controller: category,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: textFieldColor,
                    ),
                    padding: const EdgeInsets.only(left: 16),
                    child: TextField(
                      style: const TextStyle(color: textColor),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Subcategory",
                        hintStyle: TextStyle(color: hintTextColor),
                      ),
                      controller: subcategory,
                    ),
                  ),
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
