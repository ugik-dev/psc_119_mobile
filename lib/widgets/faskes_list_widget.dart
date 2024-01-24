import 'package:flutter/material.dart';
import 'package:psc_119_ss/widgets/faskes_card.dart';

class FaskesListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> dataFaskes;

  const FaskesListWidget({Key? key, required this.dataFaskes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10.0,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: dataFaskes.length,
          itemBuilder: (BuildContext context, int index) {
            return FaskesCard(
              name: dataFaskes[index]['name'],
              description: dataFaskes[index]['description'],
              distance: dataFaskes[index]['distance'],
              phone: dataFaskes[index]['phone'],
              whatsapp: dataFaskes[index]['whatsapp'],
              alamat: dataFaskes[index]['alamat'],
              mapsUrl: dataFaskes[index]['url'],
              website: dataFaskes[index]['website'],
              refFaskes: dataFaskes[index]['name_jenis'],
            );
          },
        ),
      ],
    );
  }
}
