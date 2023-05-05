import 'dart:typed_data';

import 'package:automobile_management/widgets/custom_toast.dart';
import 'package:automobile_management/widgets/cutom_text.dart';
import 'package:automobile_management/function/time_date_function.dart';
import 'package:automobile_management/models/auth_method.dart';
import 'package:automobile_management/models/product_model.dart';
import 'package:automobile_management/services/databse_storage.dart';
import 'package:automobile_management/services/product_api.dart';
import 'package:automobile_management/utilities/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:automobile_management/dependency_injection/injection_container.dart';

import '../Common/constants.dart';
import '../services/location_api.dart';

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
  final LocationApi locationApi = sl.get<LocationApi>();
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
          longitude: locationApi.currentPosistion.longitude,
          latitude: locationApi.currentPosistion.latitude,
        );
        bool temp = await ProductApi().add(product);
        if (temp) {
          CustomToast.successToast(message: 'uploaded');
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
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 60,
          leadingWidth: 100,
          leading: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: textFieldColor,
                      foregroundColor: Colors.black,
                      fixedSize: const Size.fromRadius(30),
                      elevation: 0,
                    ),
                    child: const Icon(Icons.arrow_back_rounded),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: textFieldColor.withOpacity(0),
          foregroundColor: textColor,
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        body: Material(
          color: Colors.white,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Picture",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(1),
                            spreadRadius: 0,
                            blurRadius: 8,
                            offset: const Offset(
                                1, 1), // changes position of shadow
                          ),
                        ], borderRadius: BorderRadius.circular(20)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox.fromSize(
                              size: const Size.fromRadius(90),
                              child: _image != null
                                  ? Stack(
                                      children: <Widget>[
                                        Container(
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: MemoryImage(_image!),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 25.0, top: 20),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                selectImage();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                backgroundColor: textFieldColor,
                                                foregroundColor: Colors.black,
                                                fixedSize:
                                                    const Size.fromRadius(15),
                                                elevation: 0,
                                              ),
                                              child: const Icon(CupertinoIcons
                                                  .add_circled_solid),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        selectImage();
                                      },
                                      child: Container(
                                        color: Colors.white,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.add_circle_outline_outlined,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("Add Photo")
                                          ],
                                        ),
                                      ),
                                    )),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Details",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      " Name",
                      style: TextStyle(
                          color: textColor.withOpacity(0.5),
                          fontWeight: FontWeight.bold),
                    ),
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
                          // hintText: "Name",
                          hintStyle: TextStyle(color: hintTextColor),
                        ),
                        controller: productname,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      " Description",
                      style: TextStyle(
                          color: textColor.withOpacity(0.5),
                          fontWeight: FontWeight.bold),
                    ),
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
                          // hintText: "Description",
                          hintStyle: TextStyle(color: hintTextColor),
                        ),
                        controller: productdecription,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      " Amount",
                      style: TextStyle(
                          color: textColor.withOpacity(0.5),
                          fontWeight: FontWeight.bold),
                    ),
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
                          // hintText: "amount",
                          hintStyle: TextStyle(color: hintTextColor),
                        ),
                        controller: amount,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      " Quantity",
                      style: TextStyle(
                          color: textColor.withOpacity(0.5),
                          fontWeight: FontWeight.bold),
                    ),
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
                          // hintText: "Quantity",
                          hintStyle: TextStyle(color: hintTextColor),
                        ),
                        controller: quantity,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      " Category",
                      style: TextStyle(
                          color: textColor.withOpacity(0.5),
                          fontWeight: FontWeight.bold),
                    ),
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
                          // hintText: "Category",
                          hintStyle: TextStyle(color: hintTextColor),
                        ),
                        controller: category,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      " Subcategory",
                      style: TextStyle(
                          color: textColor.withOpacity(0.5),
                          fontWeight: FontWeight.bold),
                    ),
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
                          // hintText: "Subcategory",
                          hintStyle: TextStyle(color: hintTextColor),
                        ),
                        controller: subcategory,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          await uploaddata();
                          Navigator.pop(context);
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
