import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/auth_detail.dart';
import '../../repositories/auth/auth_repository.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository = AuthRepository();

  AuthBloc({AuthState? initialState}) : super(initialState!);

  AuthState get initialState => AuthInitial(counter: 4);
  // VenueMembershipState get initialState => VenueInitial(counter: 4);

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthLoginEvent) {
      yield AuthLoginLoading();
      AuthDetailModel responseApi = await AuthRepository().login(event.context,
          email: event.email!,
          name: event.name!,
          password: event.password!,
          phone: event.phone!);
      if (responseApi.status == true || responseApi.code != 200) {
        yield AuthLoginFailure(responseApi.message!);
        return;
      }
      yield AuthLoginSuccess(responseApi.data!);
    }
  }
}
