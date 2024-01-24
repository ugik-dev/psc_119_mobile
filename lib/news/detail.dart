import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:psc_119_ss/news/list.dart';

class NewsItemDetailPage extends StatelessWidget {
  final NewsItem newsItem;

  NewsItemDetailPage({required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(newsItem.judul),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tanggal: ${newsItem.tanggal}'),
            SizedBox(height: 10),
            Html(data: newsItem.content),
          ],
        ),
      ),
    );
  }
}
