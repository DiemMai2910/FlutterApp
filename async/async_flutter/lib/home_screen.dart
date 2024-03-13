import 'dart:convert';

import 'package:async_flutter/article_detail.dart';
import 'package:async_flutter/article_model.dart';
import 'package:async_flutter/saved_article.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Article> _savedArticles = [];
  // Danh sách các bài viết đã thích
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: FutureBuilder(
        future: getArticles(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              final data = snapshot.data ?? [];
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final articleData = data[index];
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ArticleDetail(article: articleData)));
                    },
                    title: articleData.title != '[Removed]'
                        ? Text(articleData.title,
                            style: TextStyle(fontWeight: FontWeight.bold))
                        : null,
                    subtitle: Text("By " + articleData.author),
                    leading: Image.network(
                      articleData.urlToImage,
                      width: 100,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                    trailing: Icon(Icons.more_vert),
                  );
                },
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SavedArticlesScreen(savedArticles: _savedArticles),
            ),
          );
        },
        child: const Icon(Icons.favorite),
      ),
    );
  }

  Future<List<Article>> getArticles() async {
    const url =
        'https://newsapi.org/v2/everything?q=apple&from=2024-03-12&to=2024-03-12&sortBy=popularity&apiKey=...'; //apikey is private
    final res = await http.get(Uri.parse(url));
    final body = json.decode(res.body) as Map<String, dynamic>;
    final List<Article> result = [];
    for (final article in body['articles']) {
      if (article['title'] != '[Removed]') {
        result.add(Article(
          title: article['title'],
          author: article['author'] ?? 'Unknown',
          urlToImage: article['urlToImage'] ??
              "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png",
          content: article['content'] ?? '',
        ));
      }
    }

    return result;
  }
}