part of 'articles_bloc.dart';

abstract class ArticlesEvent extends Equatable {
  final BuildContext context;
  const ArticlesEvent(
    this.context,
  );

  @override
  List<Object> get props => [];
}

class ArticlesListEvent extends ArticlesEvent {
  final BuildContext context;
  String token;
  ArticlesListEvent(
      this.context, {required this.token})
      : super(context);
}
