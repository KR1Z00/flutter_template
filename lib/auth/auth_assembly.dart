import 'package:flutter_template/app/dependency_injection.dart';
import 'package:flutter_template/auth/bloc/login_bloc.dart';
import 'package:flutter_template/auth/bloc/register_bloc.dart';
import 'package:flutter_template/auth/repository/auth_repository.dart';
import 'package:get_it/get_it.dart';

class AuthAssembly extends DependencyAssembly {
  @override
  void registerDependencies(GetIt locator) {
    locator.registerSingleton(
      AuthRepository.instance,
    );

    locator.registerFactory(
      () => LoginBloc(
        authRepository: locator(),
      ),
    );

    locator.registerFactory(
      () => RegisterBloc(
        authRepository: locator(),
      ),
    );
  }
}
