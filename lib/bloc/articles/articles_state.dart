part of 'articles_bloc.dart';

// abstract class ArticlesState {}

abstract class ArticlesState {}

class ArticlesInitial extends ArticlesState {
  final int? counter;
  ArticlesInitial({this.counter});
  @override
  List<Object> get props => [counter!];
}

// class ArticlesInitial extends ArticlesState {
//   final int? counter;
//   ArticlesInitial({this.counter});
//   @override
//   List<Object> get props => [counter!];
// }

class ArticlesListLoading extends ArticlesState {}

class ArticlesListFailure extends ArticlesState {
  final String error;

  ArticlesListFailure(this.error);
}
class ArticlesListSuccess extends ArticlesState {
  final List<Articles> data;

  ArticlesListSuccess(this.data);}

