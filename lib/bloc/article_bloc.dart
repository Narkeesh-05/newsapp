import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../service/api_service.dart';
import 'article_event.dart';
import 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final NewsService newsService;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  ArticleBloc(this.newsService) : super(ArticleLoading()) {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      ConnectivityResult result,
    ) {
      if (result != ConnectivityResult.none) {
        add(FetchArticles());
      }
    });

    on<FetchArticles>((event, emit) async {
      emit(ArticleLoading());

      try {
        final articles = await newsService.fetchNews();
        emit(ArticleLoaded(articles));
      } catch (e) {
        print("Error in Bloc: $e");
        emit(ArticleError('Failed to load news.Please try again.'));
      }
    });
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
