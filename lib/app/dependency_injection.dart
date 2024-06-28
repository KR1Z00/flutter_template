import 'package:flutter_template/auth/auth_assembly.dart';
import 'package:get_it/get_it.dart';

abstract class DependencyAssembly {
  void registerDependencies(GetIt locator);
}

List<DependencyAssembly> assemblies = [
  AuthAssembly(),
];

GetIt locator = GetIt.instance;

void registerDependencies() {
  for (DependencyAssembly assembly in assemblies) {
    assembly.registerDependencies(locator);
  }
}
