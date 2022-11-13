import 'package:bloc/bloc.dart';
import 'package:flutter_demo/core/helpers.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/validate_credentials_use_case.dart';
import 'package:flutter_demo/features/auth/login/login_navigator.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';

class LoginPresenter extends Cubit<LoginViewModel> {
  LoginPresenter(
    LoginPresentationModel super.model,
    this._navigator,
    this._validateCredentialsUseCase,
  );

  final LoginNavigator _navigator;
  final ValidateCredentialsUseCase _validateCredentialsUseCase;

  // ignore: unused_element
  LoginPresentationModel get _model => state as LoginPresentationModel;

  void onUsernameChanged(String username) => emit(
        _model.copyWith(
          username: username,
          isLoginEnabled: _validateCredentialsUseCase.execute(
            username: username,
            password: _model.password,
          ),
        ),
      );

  void onPasswordChanged(String password) => emit(
        _model.copyWith(
          password: password,
          isLoginEnabled: _validateCredentialsUseCase.execute(
            username: _model.username,
            password: password,
          ),
        ),
      );

  void onLogin() => doNothing();
}
