import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:psc_119_ss/config.dart';
import 'package:psc_119_ss/news/list.dart';

class NewsItemDetailPage extends StatelessWidget {
  final NewsItem newsItem;

  NewsItemDetailPage({required this.newsItem});

  @override
  Widget build(BuildContext context) {
    print("sampul : " +
        '${AppConfig.base_url_api}/storage/upload/content/' +
        newsItem.sampul);
    return Scaffold(
      appBar: AppBar(
        title: Text(newsItem.judul),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tanggal: ${newsItem.tanggal}'),
              const SizedBox(height: 10),
              if (newsItem.sampul != null)
                Center(
                  child: Image.network(
                      '${AppConfig.base_url_api}/storage/upload/content/' +
                          newsItem.sampul),
                ),
              Html(data: newsItem.content),
            ],
          ),
        ),
      ),
    );
  }
}
