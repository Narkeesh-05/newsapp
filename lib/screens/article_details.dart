import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../model/article.dart';

class ArticleDetails extends StatelessWidget {
  final Article article;

  const ArticleDetails({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Article Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: HexColor("#1E4684"),
        elevation: 0.4,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildArticleImage(article.imageUrl),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    article.publishedAt,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    article.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleImage(String? imageUrl) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.grey.shade300),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        child: Image.network(
          imageUrl ?? '',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                  const SizedBox(height: 10),
                  Text(
                    "Image not available",
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                ],
              ),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                color: HexColor("#1E4684"),
                value:
                    loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
