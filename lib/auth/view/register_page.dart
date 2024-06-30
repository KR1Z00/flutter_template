import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/app/localization/generated/locale_keys.g.dart';
import 'package:flutter_template/app/theme/custom_button_styles.dart';
import 'package:flutter_template/app/theme/theme_extensions.dart';
import 'package:go_router/go_router.dart';

import '../../generic/view/shadow_outline_view.dart';
import '../bloc/register_bloc.dart';
import 'show_hide_text_field.dart';

/// The page for the user to register a new account
class RegisterPage extends StatelessWidget {
  final _nameTextFieldController = TextEditingController();
  final _emailTextFieldController = TextEditingController();
  final _phoneNumberTextFieldController = TextEditingController();
  final _passwordTextFieldController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: context.colorScheme().surfaceContainerLow,
        body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 40),
          child: Center(
            child: ShadowOutlineView(
              child: SingleChildScrollView(
                child: BlocConsumer<RegisterBloc, RegisterState>(
                  listenWhen: (previous, current) =>
                      (previous.runtimeType != current.runtimeType),
                  listener: (context, state) async {
                    if (state is RegisterSuccessfulState) {
                      await Future.delayed(const Duration(seconds: 2));
                      if (context.mounted) {
                        context.pop();
                      }
                    }
                  },
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // TODO: Add icon

                          Center(
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: context.colorScheme().secondary,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 90,
                            child: Center(
                              child: Text(
                                tr(LocaleKeys.register),
                                style: context.textTheme().displaySmall,
                              ),
                            ),
                          ),
                          TextField(
                            controller: _nameTextFieldController,
                            decoration: InputDecoration(
                              hintText: tr(LocaleKeys.name),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _emailTextFieldController,
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: tr(LocaleKeys.email),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _phoneNumberTextFieldController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: tr(LocaleKeys.phoneNumber),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ShowHideTextField(
                            controller: _passwordTextFieldController,
                            hintText: tr(LocaleKeys.password),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            tr(LocaleKeys.passwordRequirements),
                            style: context.textTheme().bodySmall,
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            height: 40,
                            child: TextButton(
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                BlocProvider.of<RegisterBloc>(
                                  context,
                                ).add(RegisterNewUserEvent(
                                  name: _nameTextFieldController.text,
                                  email: _emailTextFieldController.text,
                                  phoneNumber:
                                      _phoneNumberTextFieldController.text,
                                  password: _passwordTextFieldController.text,
                                ));
                              },
                              style: ButtonStyles.primaryFilled(context),
                              child: Text(tr(LocaleKeys.register)),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 30,
                            child: TextButton(
                              onPressed: () => context.pop(),
                              style: ButtonStyles.primaryText(context),
                              child: Text(tr(LocaleKeys.login)),
                            ),
                          ),
                          if (state is! RegisterInitial)
                            const SizedBox(height: 20),
                          if (state is RegisterProcessingState)
                            const Center(
                              child: SizedBox.square(
                                dimension: 20,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          if (state is RegisterErrorState)
                            Text(
                              state.error.errorDescription,
                              textAlign: TextAlign.center,
                              style: context.textTheme().bodySmall!.copyWith(
                                    color: Colors.red,
                                  ),
                            ),
                          if (state is RegisterSuccessfulState)
                            Text(
                              tr(LocaleKeys.registerSuccess),
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
    );
  }
}
