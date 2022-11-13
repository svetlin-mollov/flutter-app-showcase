import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/validate_credentials_use_case.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/features/auth/login/login_presenter.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/auth_mock_definitions.dart';
import '../mocks/auth_mocks.dart';

void main() {
  late LoginPresentationModel model;
  late LoginPresenter presenter;
  late MockLoginNavigator navigator;
  late ValidateCredentialsUseCase validateCredentialsUseCase;
  late LogInUseCase logInUseCase;

  test(
    'GIVEN username is empty THEN isLoginEnabled is false',
    () {
      // GIVEN
      presenter.onUsernameChanged('');
      presenter.onPasswordChanged('password');

      // THEN
      expect(presenter.state.isLoginEnabled, isFalse);
    },
  );

  test(
    'GIVEN password is empty THEN isLoginEnabled is false',
    () {
      // GIVEN
      presenter.onUsernameChanged('username');
      presenter.onPasswordChanged('');

      // THEN
      expect(presenter.state.isLoginEnabled, isFalse);
    },
  );

  test(
    'GIVEN username and password are non-empty THEN isLoginEnabled is true',
    () {
      // GIVEN
      presenter.onUsernameChanged('username');
      presenter.onPasswordChanged('password');

      // THEN
      expect(presenter.state.isLoginEnabled, isTrue);
    },
  );

  setUp(() {
    model = LoginPresentationModel.initial(const LoginInitialParams());
    navigator = MockLoginNavigator();
    validateCredentialsUseCase = const ValidateCredentialsUseCase();
    logInUseCase = AuthMocks.logInUseCase;
    presenter = LoginPresenter(
      model,
      navigator,
      validateCredentialsUseCase,
      logInUseCase,
    );
  });
}
