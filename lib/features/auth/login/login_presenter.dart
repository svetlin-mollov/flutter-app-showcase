import 'package:bloc/bloc.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/core/utils/either_extensions.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/validate_credentials_use_case.dart';
import 'package:flutter_demo/features/auth/login/login_navigator.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/localization/app_localizations_utils.dart';

class LoginPresenter extends Cubit<LoginViewModel> {
  LoginPresenter(
    LoginPresentationModel super.model,
    this._navigator,
    this._validateCredentialsUseCase,
    this._logInUseCase,
  );

  final LoginNavigator _navigator;
  final ValidateCredentialsUseCase _validateCredentialsUseCase;
  final LogInUseCase _logInUseCase;

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

  Future<void> onLogin() => _logInUseCase
      .execute(
        username: _model.username,
        password: _model.password,
      )
      .observeStatusChanges(
        (result) => emit(_model.copyWith(loginResult: result)),
      )
      .asyncFold(
        (fail) => _navigator.showError(fail.displayableFailure()),
        (success) => _navigator.showAlert(
          title: appLocalizations.loginSuccessTitle,
          message: appLocalizations.loginSuccessMessage,
        ),
      );
}
