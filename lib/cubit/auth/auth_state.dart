import 'package:chandlier/data/models/status/form_status.dart';
import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  const AuthState({
    this.password = '',
    this.email = '',
    this.status = FormStatus.pure,
    this.statusMessage = "",
  });

  final String email;
  final String password;
  final FormStatus status;
  final String statusMessage;

  AuthState copyWith({
    String? email,
    String? statusMessage,
    String? password,
    FormStatus? status,
  }) =>
      AuthState(
        password: password ?? this.password,
        email: email ?? this.email,
        status: status ?? this.status,
        statusMessage: statusMessage ?? this.statusMessage,
      );

  @override
  String toString() {
    return '''
    Username: $password
    UserAge:$email
    Status:$status
    ''';
  }

  @override
  List<Object?> get props => [
    email,
    password,
    status,
    statusMessage,
  ];
}
