import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ex_application/adddata.dart';
import 'package:ex_application/product_details.dart';
import 'package:flutter/material.dart';

import 'adminpage.dart';

class CategoriesItems extends StatefulWidget {
  final String id;

  const CategoriesItems({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<CategoriesItems> createState() => _CategoriesItemsState();
}

class _CategoriesItemsState extends State<CategoriesItems> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue.shade50,
        appBar: AppBar(
          title: const Text("select category items"),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('select_items')
              .where("cat_id", isEqualTo: widget.id.trim())
              .snapshots(),
          builder: (_, snapshot) {
            if (snapshot.hasError) return Text('Error = ${snapshot.error}');
            if (snapshot.hasData) {
              final docs = snapshot.data!.docs;
              debugPrint(docs as String?);
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: docs.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (_, i) {
                        final data = docs[i].data();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(10),
                              height: 350,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black54,
                                    blurRadius: 10,
                                    spreadRadius: 0,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    height: 200,
                                    width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      child: InkWell(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DetailsPage(
                                                image: "${data["image"]}",
                                                productData: data,
                                                productId: docs[i].id,
                                                tag: "tag$i",
                                                name: data["name"],
                                                pname: data["pname"],
                                                prs: data["prs"],
                                                mrp: data["mrp"],
                                              ),
                                            )),
                                        child: Hero(
                                          tag: "tag$i",
                                          child: Image(
                                            image: NetworkImage(
                                              "${data["image"]}",
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                          ),
                                          child: Text(
                                            'name :${data["name"]}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        /* Text(
                                      'pname :${data["pname"]}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),*/
                                        Row(
                                          children: [
                                            Text(
                                              'P.R.S. : ₹${data["prs"]}',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                  left: 20, right: 5),
                                              child: Text("M.R.P. :"),
                                            ),
                                            Text(
                                              '₹${data["mrp"]}',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                          ],
                                        ),
                                        isAdmin == false
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 5),
                                                      child: ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          AddProduct(
                                                                    name: data[
                                                                        "name"],
                                                                    prs: int.parse(
                                                                        "${data["prs"]}"),
                                                                    mrp: int.parse(
                                                                        "${data["mrp"]}"),
                                                                    pname: data[
                                                                        "pname"],
                                                                    id: docs[i]
                                                                        .id,
                                                                    image: data[
                                                                        "image"],
                                                                    catId: data[
                                                                        "cat_id"],
                                                                  ),
                                                                ));
                                                          },
                                                          child: const Text(
                                                              "Edit")),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 5),
                                                      child: ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          AddProduct(
                                                                    name: data[
                                                                        ""],
                                                                    pname: data[
                                                                        ""],
                                                                    prs: data[
                                                                        ""],
                                                                    mrp: data[
                                                                        ""],
                                                                    catId: data[
                                                                        ""],
                                                                    id: docs[i]
                                                                        .id,
                                                                  ),
                                                                ));
                                                          },
                                                          child: const Text(
                                                              "create")),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "select_items")
                                                            .doc(docs[i].id)
                                                            .delete();
                                                      },
                                                      child:
                                                          const Text("delete"),
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
                    ),
                  )
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
