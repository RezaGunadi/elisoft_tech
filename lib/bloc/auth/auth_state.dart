part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {
  final int? counter;
  AuthInitial({this.counter});
  @override
  List<Object> get props => [counter!];
}

class AuthLoginLoading extends AuthState {}

class AuthLoginFailure extends AuthState {
  final String error;

  AuthLoginFailure(this.error);
}
class AuthLoginSuccess extends AuthState {
  final AuthDetail data;

  AuthLoginSuccess(this.data);}

