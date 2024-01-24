import 'package:flutter/material.dart';
import 'package:psc_119_ss/faskes/detail.dart';

class FaskesCard extends StatelessWidget {
  final String name;
  final String description;
  final String phone;
  final String distance;
  final String whatsapp;
  final String mapsUrl;
  final String website; // New variable
  final String refFaskes; // New variable
  final String alamat; // New variable

  FaskesCard({
    required this.name,
    required this.description,
    required this.phone,
    required this.distance,
    required this.whatsapp,
    required this.mapsUrl,
    required this.website,
    required this.refFaskes,
    required this.alamat,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailFaskesScreen(
              name: name,
              description: description,
              phone: phone,
              distance: distance,
              whatsapp: whatsapp,
              mapsUrl: mapsUrl,
              website: website,
              refFaskes: refFaskes,
              alamat: alamat,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.all(13.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Jarak $distance',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              "Phone: $phone / WA: $whatsapp",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailFaskes extends StatelessWidget {
  final String name;
  final String description;
  final String phone;
  final String distance;
  final String whatsapp;
  final String mapsUrl;
  final String website; // New variable
  final String refFaskes; // New variable
  final String alamat; // New variable

  DetailFaskes({
    required this.name,
    required this.description,
    required this.phone,
    required this.distance,
    required this.whatsapp,
    required this.mapsUrl,
    required this.website,
    required this.refFaskes,
    required this.alamat,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Faskes'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Website: $website'),
          Text('Ref Faskes: $refFaskes'),
          Text('Alamat: $alamat'),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Open Google Maps using the received URL
              // You might want to use a package like url_launcher for this
            },
            child: Text('Open in Google Maps'),
          ),
        ],
      ),
    );
  }
}
