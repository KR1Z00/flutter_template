import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/app/localization/generated/locale_keys.g.dart';
import 'package:flutter_template/app/router_config.dart';
import 'package:flutter_template/app/theme/custom_button_styles.dart';
import 'package:flutter_template/app/theme/theme_extensions.dart';
import 'package:flutter_template/auth/bloc/login_bloc.dart';

import '../../generic/view/shadow_outline_view.dart';
import 'show_hide_text_field.dart';

/// The page for the user to log in to their account
class LoginPage extends StatelessWidget {
  final _emailTextFieldController = TextEditingController();
  final _passwordTextFieldController = TextEditingController();
  final _passwordRecoveryEmailTextFieldController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessfulState) {
          context.goAppRoute(
            AppRoute.postLogin,
          );
        }
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: context.colorScheme().surface,
          body: SafeArea(
            minimum: const EdgeInsets.symmetric(horizontal: 40),
            child: Center(
              child: ShadowOutlineView(
                backgroundColor: context.colorScheme().surfaceContainer,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return AnimatedSize(
                          duration: const Duration(milliseconds: 200),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // TODO: Add icon
                              Center(
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  color: context.colorScheme().primaryContainer,
                                ),
                              ),

                              // We show a different UI if recovering the user's
                              // password
                              if (state is LoginRecoverPasswordState)
                                _LoginRecoverPasswordColumnContent(
                                  passwordRecoveryEmailTextFieldController:
                                      _passwordRecoveryEmailTextFieldController,
                                ),
                              if (state is! LoginRecoverPasswordState)

                                // If we are not recovering the user's password,
                                // show the ordinary login content
                                _LoginUserColumnContent(
                                  emailTextFieldController:
                                      _emailTextFieldController,
                                  passwordTextFieldController:
                                      _passwordTextFieldController,
                                ),

                              // If the login has had an error, or the user has
                              // now successfully logged in, we show a message
                              // at the bottom
                              if (state.loginError != null ||
                                  state.processing ||
                                  state is LoginSuccessfulState)
                                const SizedBox(height: 20),
                              if (state.loginError != null)
                                Text(
                                  state.loginError!.errorDescription,
                                  textAlign: TextAlign.center,
                                  style:
                                      context.textTheme().bodySmall!.copyWith(
                                            color: Colors.red,
                                          ),
                                ),
                              if (state.processing)
                                const Center(
                                  child: SizedBox.square(
                                    dimension: 20,
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              if (state is LoginSuccessfulState)
                                Text(
                                  tr(LocaleKeys.loginSuccess),
                                  textAlign: TextAlign.center,
                                  style: context.textTheme().bodySmall,
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The content to be shown when logging a user in
class _LoginUserColumnContent extends StatelessWidget {
  final TextEditingController emailTextFieldController;
  final TextEditingController passwordTextFieldController;

  const _LoginUserColumnContent({
    required this.emailTextFieldController,
    required this.passwordTextFieldController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 90,
            child: Center(
              child: Text(
                tr(LocaleKeys.login),
                style: context.textTheme().displaySmall,
              ),
            ),
          ),
          TextField(
            key: const Key("loginPage_email"),
            controller: emailTextFieldController,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: tr(LocaleKeys.email),
            ),
          ),
          const SizedBox(height: 10),
          ShowHideTextField(
            key: const Key("loginPage_password"),
            controller: passwordTextFieldController,
            hintText: tr(LocaleKeys.password),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 40,
            child: TextButton(
              key: const Key("loginPage_login"),
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                BlocProvider.of<LoginBloc>(context).add(
                  LoginUserEvent(
                    email: emailTextFieldController.text,
                    password: passwordTextFieldController.text,
                  ),
                );
              },
              style: ButtonStyles.primaryFilled(context),
              child: Text(tr(LocaleKeys.login)),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 30,
            child: TextButton(
              key: const Key("loginPage_register"),
              onPressed: () => context.pushAppRoute(
                AppRoute.register,
              ),
              style: ButtonStyles.primaryText(context),
              child: Text(tr(LocaleKeys.register)),
            ),
          ),
          SizedBox(
            height: 30,
            child: TextButton(
              key: const Key("loginPage_forgotPassword"),
              onPressed: () => BlocProvider.of<LoginBloc>(context).add(
                const LoginForgotPasswordEvent(),
              ),
              style: ButtonStyles.primaryText(context),
              child: Text(tr(LocaleKeys.forgotPassword)),
            ),
          ),
        ],
      ),
    );
  }
}

/// The content to be shown when recovering a user's password
class _LoginRecoverPasswordColumnContent extends StatelessWidget {
  final TextEditingController passwordRecoveryEmailTextFieldController;

  const _LoginRecoverPasswordColumnContent({
    required this.passwordRecoveryEmailTextFieldController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 90,
            child: Center(
              child: Text(
                tr(LocaleKeys.forgotPassword),
                style: context.textTheme().headlineLarge,
              ),
            ),
          ),
          if (!(state as LoginRecoverPasswordState).emailSent)
            TextField(
              key: const Key("forgotPassword_email"),
              controller: passwordRecoveryEmailTextFieldController,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: tr(LocaleKeys.email),
              ),
            ),
          const SizedBox(height: 20),
          if (state.emailSent)
            Text(
              tr(LocaleKeys.forgotPasswordSuccess),
              style: context.textTheme().bodySmall,
            ),
          if (!state.emailSent)
            Text(
              tr(LocaleKeys.forgotPasswordGuidance),
              style: context.textTheme().bodySmall,
              textAlign: TextAlign.center,
            ),
          if (!state.emailSent)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                height: 40,
                child: TextButton(
                  key: const Key("forgotPassword_resetPassword"),
                  onPressed: () => BlocProvider.of<LoginBloc>(context).add(
                    LoginRecoverPasswordEvent(
                      email: passwordRecoveryEmailTextFieldController.text,
                    ),
                  ),
                  style: ButtonStyles.primaryFilled(context),
                  child: Text(tr(LocaleKeys.resetPassword)),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 30,
              child: TextButton(
                key: const Key("forgotPassword_done"),
                onPressed: () => BlocProvider.of<LoginBloc>(context).add(
                  const LoginForgotPasswordCancelEvent(),
                ),
                style: ButtonStyles.primaryText(context),
                child: Text(tr(LocaleKeys.done)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
