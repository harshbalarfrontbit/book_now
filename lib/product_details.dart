import 'package:ex_application/google_maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class DetailsPage extends StatefulWidget {
  final dynamic image;
  final dynamic tag;
  final dynamic productData;
  final dynamic productId;
  final dynamic name;
  final dynamic pname;
  final dynamic prs;
  final dynamic mrp;

  const DetailsPage(
      {Key? key,
      this.image,
      this.tag,
      this.productData,
      this.productId,
      this.name,
      this.pname,
      this.prs,
      this.mrp})
      : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  DateTime? selectDateTime;
  TimeOfDay? selectTime;

  Set<Marker> markerList = {
    const Marker(
      markerId: MarkerId("01"),
      position: LatLng(21.237106539704083, 72.87721937617128),
    )
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue.shade50,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("select items"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 10,
                      spreadRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                height: 300,
                width: double.infinity,
                child: Hero(
                  tag: widget.tag,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                    child: Image.network(
                      "${widget.image}",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        bottom: 15,
                      ),
                      child: Text(
                        widget.name,
                        style: const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          RatingBar.builder(
                            initialRating: 3.5,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 25,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            onRatingUpdate: (value) {},
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text("(4500)"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 5,
                            ),
                            child: Text(
                              "₹${widget.prs}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ),
                          Text(
                            "₹${widget.mrp}",
                            style: const TextStyle(
                              color: Colors.black45,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text(
                        "Property Location.",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GoogleMapsDemo(),
                            ),
                          );
                        },
                        child: const Image(
                          image: NetworkImage(
                              "https://media.wired.com/photos/59269cd37034dc5f91bec0f1/191:100/w_1280,c_limit/GoogleMapTA.jpg"),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text(
                        "Property description.",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      widget.pname,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(selectDateTime == null
                                  ? "Please Select Date"
                                  : DateFormat("dd MMM, yyyy, hh:mm aa EEEE").format(
                                DateTime(
                                  selectDateTime!.year,
                                  selectDateTime!.month,
                                  selectDateTime!.day,
                                  selectTime!.hour,
                                  selectTime!.minute,
                                ),
                              ))),
                          ElevatedButton(
                              onPressed: () async {
                                var pickDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2023, DateTime.now().month + 2));
                                debugPrint("pickDate -=-=-=-=  $pickDate");
                                if (pickDate != null) {
                                  selectDateTime = pickDate;
                                  var pickTime = await showTimePicker(
                                      context: context, initialTime: TimeOfDay.now());
                                  debugPrint("time-==-=-=-==--=-=-= $pickTime");
                                  if (pickTime != null) {
                                    selectTime = pickTime;
                                  }
                                  setState(() {});
                                }
                              },
                              child: const Text("Date, Time Picker")),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
