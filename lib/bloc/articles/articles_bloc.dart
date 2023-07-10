import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/device_list.dart';
import '../../repositories/articles/articles_repository.dart';

part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  ArticlesBloc() : super(ArticlesInitial()) {
    final ArticlesRepository deviceRepository = ArticlesRepository();

    @override
    Stream<ArticlesState> mapEventToState(ArticlesEvent event) async* {
      if (event is ArticlesListEvent) {
        yield ArticlesListLoading();
        ArticlesListModel responseApi = await ArticlesRepository()
            .getArticles(event.context, rememberToken: event.token);
        if (responseApi.status == true || responseApi.code != 200) {
          yield ArticlesListFailure(responseApi.message!);
          return;
        }
        yield ArticlesListSuccess(responseApi.data!);
      }
    }
  }
}