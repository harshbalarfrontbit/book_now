
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'adminpage.dart';

class AddProduct extends StatefulWidget {
  final String? name;
  final String? id;
  final String? image;
  final String? pname;
  final int? prs;
  final int? mrp;
  final String? catId;

  const AddProduct({
    Key? key,
    this.name,
    this.id,
    this.image,
    this.pname,
    this.prs,
    this.mrp,
    this.catId,
  }) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  bool active = false;

  String? selectCategory;
  String? selectImage;

  TextEditingController name = TextEditingController();
  TextEditingController pname = TextEditingController();
  TextEditingController prs = TextEditingController();
  TextEditingController mrp = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getCategoryData();
    debugPrint("name  --   ${widget.name}");
    name.text = widget.name ?? "";
    pname.text = widget.pname ?? "";
    prs.text = "${widget.prs ?? ""}";
    mrp.text = "${widget.mrp ?? ""}";

    setState(() {});
  }

  List categoryList = [];

  getCategoryData() async {
    var data = await FirebaseFirestore.instance.collection('mainFiled').get();

    for (var element in data.docs) {
      categoryList.add(element.data());
    }
    debugPrint("category -- $categoryList");
    for (var element in categoryList) {
      debugPrint("id ---  ${element["categoriesId"]}    ${widget.catId}");
      if (element['categoriesId'] == widget.catId) {
        selectCategory = widget.catId!;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColour.lightBlue,
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Material(
                                color: Colors.transparent,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 300),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 30,
                                            ),
                                            //
                                            child: GestureDetector(
                                              onTap: () async {
                                                final picker = ImagePicker();
                                                XFile? image =
                                                    await picker.pickImage(
                                                  source: ImageSource.camera,
                                                );
                                                if (image != null) {
                                                  selectImage = image.path;
                                                  setState(
                                                    () {},
                                                  );
                                                }
                                                // ignore: use_build_context_synchronously
                                                Navigator.pop(context);
                                              },
                                              child: Column(
                                                children: [
                                                  Image.network(
                                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTivA-XRcyho7rteW_HNFC-0wQobeb9rtxC00QgWSRLxXXwe0iDsggyJ_uk0ZC3aNaQdhg&usqp=CAU",
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                  const Text(
                                                    "Camera",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              final picker = ImagePicker();
                                              XFile? image =
                                                  await picker.pickImage(
                                                source: ImageSource.gallery,
                                              );
                                              if (image != null) {
                                                selectImage = image.path;
                                                setState(
                                                  () {},
                                                );
                                              }
                                              // ignore: use_build_context_synchronously
                                              Navigator.pop(context);
                                            },
                                            child: Column(
                                              children: [
                                                ClipOval(
                                                  child: Image.network(
                                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrlAgrtA42WwQuE4__9iEL6ghxMamSrXFYtm83JdMQUQ&s",
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                ),
                                                const Text(
                                                  "gallery",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
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
                            ],
                          );
                        },
                      );
                    },
                    child: Center(
                      child: selectImage != null
                          ? Image.file(
                              File(selectImage!),
                              height: 150,
                              width: 150,
                            )
                          : widget.image != null
                              ? Image.network(
                                  height: 150,
                                  width: 150,
                                  widget.image.toString(),
                                )
                              : Container(
                                  margin: const EdgeInsets.only(
                                      top: 20, bottom: 20),
                                  height: 150,
                                  width: 150,
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your name';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      controller: name,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'product name',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: TextFormField(
                      maxLines: 5,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your name';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      controller: pname,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'product description',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your price';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: prs,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'product prs',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your name';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: mrp,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'product mrp',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  if (categoryList.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          color: Colors.white),
                      child: DropdownButton(
                        hint: const Text('Select Category'),
                        items: categoryList
                            .map((e) => DropdownMenuItem(
                          value: "${e['categoriesId']}",
                          child: Text(
                            "${e['name']}",
                          ),
                        ))
                            .toList(),
                        isExpanded: true,
                        onChanged: (value) {
                          setState(() {
                            debugPrint(value);
                            selectCategory = value!;
                          });
                          debugPrint(value);
                        },
                        value: selectCategory,
                      ),
                    ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      onPressed: () async {
                        if (selectImage != null) {
                          String fileName =
                              DateTime.now().millisecondsSinceEpoch.toString();
                          Reference reference =
                              FirebaseStorage.instance.ref().child(fileName);
                          UploadTask uploadTask =
                              reference.putFile(File(selectImage!));
                          try {
                            TaskSnapshot snapshot = await uploadTask;
                            var imageUrl = await snapshot.ref.getDownloadURL();
                            debugPrint("imageUrl $imageUrl");
                            String id = FirebaseFirestore.instance
                                .collection("select_items")
                                .doc()
                                .id;
                            FirebaseFirestore.instance
                                .collection("select_items")
                                .doc(widget.id ?? id)
                                .set({
                              "pname": pname.text,
                              "image": imageUrl,
                              "name": name.text,
                              "prs": prs.text,
                              "mrp": mrp.text,
                              "cat_id": selectCategory,

                            }).whenComplete(() => Navigator.pop(context));
                          } on FirebaseException catch (e) {
                            debugPrint('Error --- ${e.message}');
                          }
                        } else if (widget.image != null) {
                          FirebaseFirestore.instance
                              .collection("select_items")
                              .doc(widget.id)
                              .set({
                            "pname": pname.text,
                            "image": widget.image,
                            "name": name.text,
                            "prs": prs.text,
                            "mrp": mrp.text,
                            "cat_id": selectCategory,
                          }).whenComplete(() => Navigator.pop(context));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('please select image')));
                        }
                      },
                      child: const Text('save')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
