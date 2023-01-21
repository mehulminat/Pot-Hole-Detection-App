import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DbServices {
  Future<DatabaseEvent> database = FirebaseDatabase.instance
      .ref('UsersData/sPutZw68LqgKG0L2d3b1120UGJb2/readings/timestamp')
      .once();

  DatabaseReference data = FirebaseDatabase.instance
      .ref('UsersData/sPutZw68LqgKG0L2d3b1120UGJb2/readings/timestamp');

  Stream<DatabaseEvent> get eventStream => data.onValue;

  Future<List<Marker>> getMarkers() async {
    List<Marker> markers = [];
    markers.clear();
    await database.then((dataSnapshot) async {
      List<Object?> mapMarkers = dataSnapshot.snapshot.value as List;
      var latitude = await dataSnapshot.snapshot.ref.get();
      for (var element in mapMarkers) {
        Map x = element as Map;
        x['latitude'];
        x['longitude'];
        markers.add(
          Marker(
            markerId: MarkerId(
              mapMarkers.iterator.toString(),
            ),
            position: LatLng(
              double.parse(
                x['latitude'].toString(),
              ),
              double.parse(
                x['longitude'].toString(),
              ),
            ),
          ),
        );
        debugPrint(x.toString());
        debugPrint(element.toString());
        debugPrint('\n');
      }
      // debugPrint(mapMarkers.toString());
    });
    return markers;
  }
}