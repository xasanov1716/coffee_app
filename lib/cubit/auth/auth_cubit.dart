import 'package:chandlier/cubit/auth/auth_state.dart';
import 'package:chandlier/data/models/status/form_status.dart';
import 'package:chandlier/data/models/universal_data.dart';
import 'package:chandlier/data/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(const AuthState());

  void updatePassword(String password) {
    emit(state.copyWith(password: password));
  }

  final AuthRepository authRepository;

  void updateEmail(String email) {
    emit(state.copyWith(email: email));
  }

  Future<void> logOutUser() async {
    emit(state.copyWith(status: FormStatus.loading));
    UniversalData data = await authRepository.logOutUser();
    if (data.error.isEmpty) {
      emit(state.copyWith(status: FormStatus.unauthenticated));
    } else {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          statusMessage: data.error,
        ),
      );
    }
  }

  Future<void> signUp(context) async {
    emit(state.copyWith(status: FormStatus.loading));
    UniversalData data = await authRepository.signUpUser(
      email: state.email,
      password: state.password,
    );
    if (data.error.isEmpty) {
      emit(state.copyWith(status: FormStatus.authenticated));
    } else {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          statusMessage: data.error,
        ),
      );
    }
    emit(state.copyWith(status: FormStatus.pure));
  }
  User? currentUser;

  Future<void> logIn(context) async {
    emit(state.copyWith(status: FormStatus.loading));
    UniversalData data = await authRepository.loginUser(
      email: state.email,
      password: state.password,
    );
    if (data.error.isEmpty) {
      emit(state.copyWith(status: FormStatus.authenticated));
    } else {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          statusMessage: data.error,
        ),
      );
    }
    emit(state.copyWith(status: FormStatus.pure));
  }
}
