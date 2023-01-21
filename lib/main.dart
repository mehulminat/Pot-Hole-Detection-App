import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:harsh_app/services/db_services.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DbServices db = DbServices();

  @override
  void initState() {
    db.getMarkers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DbServices dbServices = DbServices();
    const CameraPosition kGoogle = CameraPosition(
      target: LatLng(22.55543, 72.9230435),
      zoom: 30,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the
        primarySwatch: Colors.brown,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Pot Hole Detection System')),
        ),
        body: FutureBuilder(
          future: dbServices.getMarkers(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return GoogleMap(
                initialCameraPosition: kGoogle,
                markers: snapshot.data!.toSet(),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

}