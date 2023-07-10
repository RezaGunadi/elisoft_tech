part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  final BuildContext context;
  const AuthEvent(
    this.context,
  );

  @override
  List<Object> get props => [];
}

class AuthLoginEvent extends AuthEvent {
  final BuildContext context;
  String? name;
  String? email;
  String? phone;
  String? password;
  AuthLoginEvent(
      this.context, {this.name, this.phone, this.password, required this.email})
      : super(context);
}
