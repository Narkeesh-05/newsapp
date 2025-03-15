import 'package:equatable/equatable.dart';

abstract class ArticleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchArticles extends ArticleEvent {}
