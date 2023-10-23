import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ex_application/adddata.dart';
import 'package:ex_application/booking.dart';
import 'package:ex_application/categories_data.dart';
import 'package:ex_application/custom_drawer.dart';
import 'package:ex_application/favoritescr.dart';
import 'package:ex_application/help.dart';
import 'package:ex_application/profile.dart';
import 'package:ex_application/product_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

bool isAdmin = false;
// bool isAdmin = true;

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int index = 1;
  bool isselected = false;
  List page = [];



  TextEditingController name = TextEditingController();
  TextEditingController pname = TextEditingController();
  TextEditingController prs = TextEditingController();
  TextEditingController mrp = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    page = [
      // WillPopScope(child: child, onWillPop: onWillPop)
      const CustomDrawer(),
      const HomePage(),
      const Booking(),
      FavoritePage(),
      const Profile(),
    ];
  }

  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColour.lightBlue,
        key: _scaffoldState,
        drawer: Drawer(
          backgroundColor: Colors.blue.shade50,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Switch(
                          value: isselected,
                          onChanged: (value) {
                            if (Get.isDarkMode) {
                              AppColour.blue = Colors.black54;
                              AppColour.lightBlue = Colors.black12;
                            } else {
                              AppColour.blue = Colors.blue;
                              AppColour.lightBlue = Colors.blue.shade50;
                            }
                            Get.isDarkMode
                                ? Get.changeTheme(ThemeData.light())
                                : Get.changeTheme(
                                    ThemeData.dark(),
                                  );
                            isselected = value;
                            setState(() {});
                          },
                        ),
                        // Switch(value: value, onChanged: onChanged),
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'themes',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Divider(
                color: Colors.black,
                height: 2,
              ),
            ],
          ),
        ),
        floatingActionButton: isAdmin == false
            ? SizedBox(
                height: 50,
                width: 50,
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChatScreen(
                              receiverId: "Harsh",
                              senderId: "Pratik",
                              name: "Harsh Bhai",
                            ),
                          ));
                    },
                    child: const Icon(Icons.message)),
              )
            : SizedBox(
                height: 50,
                width: 50,
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddProduct(),
                          ));
                    },
                    child: const Icon(Icons.add)),
              ),
        body: page[index],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          backgroundColor: Colors.blue,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: "menu",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: "Home",
              // backgroundColor: Colors.blueGrey
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_added_rounded),
              label: "booking",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favorite",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: "profile",
            ),
          ],
          onTap: (i) {
            if (i == 0) {
              _scaffoldState.currentState?.openDrawer();
            } else {
              setState(() {
                index = i;
              });
            }
          },
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 250,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                        bottom: 20,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      height: 50,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.search_rounded),
                            iconSize: 25,
                            color: Colors.blue,
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration.collapsed(
                                hintText: "Search here...",
                              ),
                              textCapitalization: TextCapitalization.sentences,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.notifications_none_rounded),
                            iconSize: 25,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.account_circle,
                      size: 75,
                      color: Colors.white,
                    ),
                    const Text(
                      "user name",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const Text(
                      "please check your requirement...",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Text(
              "Categories",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
              height: 125,
              margin: const EdgeInsets.only(top: 10),
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('mainFiled')
                    .snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error = ${snapshot.error}');
                  }
                  if (snapshot.hasData) {
                    final docs = snapshot.data!.docs;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: docs.length,
                      itemBuilder: (_, i) {
                        final data = docs[i].data();
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CategoriesItems(id: docs[i].id),
                                    )),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(60),
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black54,
                                          blurRadius: 10,
                                          spreadRadius: 0,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                      border: Border.all(
                                        width: 4,
                                        color: Colors.blue,
                                      )),
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(
                                      "${data["image"]}",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "${data["name"]}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  // fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              )
              // -------
              ),
          const Padding(
            padding: EdgeInsets.only(left: 10, bottom: 10),
            child: Text(
              "select items",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('select_items')
                .snapshots(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                return Text('Error = ${snapshot.error}');
              }
              if (snapshot.hasData) {
                final docs = snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: docs.length,
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
                              Stack(
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
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      /* IconButton(
                    icon: Icon(
                    select_items[index].isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: articles[index].isFavorite ? Colors.red : null,
                    ),
                    onPressed: () {
                    setState(() {
                    articles[index].isFavorite = !articles[index].isFavorite;
                    });
                    },
                    ),*/
                                    ],
                                  ),

                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 10),
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
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}

class AppColour {
  static Color blue = Colors.blue;
  static Color lightBlue = Colors.blue.shade50;
}
