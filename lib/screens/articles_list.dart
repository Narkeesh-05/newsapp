import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../bloc/article_bloc.dart';
import '../bloc/article_event.dart';
import '../bloc/article_state.dart';
import 'article_details.dart';

class ArticlesList extends StatelessWidget {
  const ArticlesList({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.4,
        backgroundColor: Colors.white,
        title: Text(
          'DAILY NEWS',
          style: TextStyle(
            color: HexColor("#1E4684"),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ArticleBloc, ArticleState>(
        builder: (context, state) {
          if (state is ArticleLoading) {
            return _buildSkeletonLoader(screenHeight, screenWidth, 10);
          } else if (state is ArticleLoaded) {
            return ListView.builder(
              itemCount: state.articles.length,
              itemBuilder: (context, index) {
                final article = state.articles[index];
                return InkWell(
                  child: Card(
                    elevation: 3,
                    margin: const EdgeInsets.all(8.0),
                    child: Container(
                      height: screenHeight * 0.13,
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 10,
                        bottom: 5,
                        right: 5,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: screenHeight * 0.09,
                                width: screenWidth * 0.20,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.network(
                                    article.imageUrl,
                                    height: screenHeight * 0.09,
                                    width: 100,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (
                                      context,
                                      child,
                                      loadingProgress,
                                    ) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        color: Colors.grey[300],
                                        height: screenHeight * 0.09,
                                        width: 100,
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[300],
                                        height: screenHeight * 0.09,
                                        width: 100,
                                        child: const Icon(
                                          Icons.broken_image,
                                          color: Colors.grey,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              SizedBox(
                                height: screenHeight * 0.09,
                                width: screenWidth * 0.69,

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      article.title,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 17.5,
                                        fontWeight: FontWeight.bold,
                                        color: HexColor("#1E4684"),
                                      ),
                                    ),
                                    Text(
                                      article.description,
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Text(
                                  article.publishedAt,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticleDetails(article: article),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is ArticleError) {
            return _buildErrorUI(context, screenHeight, screenWidth);
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }

  Widget _buildSkeletonLoader(
    double screenHeight,
    double screenWidth,
    int itemCount,
  ) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: screenHeight * 0.09,
                  width: screenWidth * 0.20,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16,
                        width: screenWidth * 0.60,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 12,
                        width: screenWidth * 0.55,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 10,
                        width: screenWidth * 0.40,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 🔴 Error UI
  Widget _buildErrorUI(
    BuildContext context,
    double screenHeight,
    double screenWidth,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/connection_error.jpg',
            height: screenHeight * 0.45,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 20),
          const Text(
            'Failed to load news. Please try again.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.5,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 45,
            width: screenWidth * 0.27,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: HexColor("#1E4684"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.5),
                ),
              ),
              onPressed: () {
                BlocProvider.of<ArticleBloc>(context).add(FetchArticles());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Retry', style: TextStyle(color: Colors.white)),
                  Icon(Icons.refresh, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
