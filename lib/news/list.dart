// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:psc_119_ss/config.dart';
import 'package:psc_119_ss/news/detail.dart';

class NewsItem {
  final int id;
  final int refContentId;
  final String judul;
  final String slug;
  final String content;
  final String tanggal;
  final String sampul;
  final String nameContent;

  NewsItem({
    required this.id,
    required this.refContentId,
    required this.judul,
    required this.slug,
    required this.content,
    required this.tanggal,
    required this.sampul,
    required this.nameContent,
  });
}

class ListNews extends StatefulWidget {
  const ListNews({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ListNewsState createState() => _ListNewsState();
}

class _ListNewsState extends State<ListNews> {
  late List<NewsItem> newsItems = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('${AppConfig.base_url_api}/api/content'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['error'] == false) {
        final List<dynamic> dataList = data['data'];
        newsItems = dataList
            .map((item) => NewsItem(
                  id: item['id'],
                  refContentId: int.parse(item['ref_content_id']),
                  judul: item['judul'],
                  slug: item['slug'],
                  content: item['content'],
                  tanggal: item['tanggal'],
                  sampul: item['sampul'],
                  nameContent: item['name_content'],
                ))
            .toList();
        setState(() {});
      } else {
        // Handle error response
        print('Failed to fetch data: ${data['message']}');
      }
    } else {
      // Handle other HTTP status codes
      print('Failed to fetch data. Status Code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi'),
      ),
      // ignore: unnecessary_null_comparison
      body: newsItems == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: newsItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(newsItems[index].judul),
                  subtitle: Text(
                      '${newsItems[index].nameContent} - ${newsItems[index].tanggal}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NewsItemDetailPage(newsItem: newsItems[index]),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
