import 'package:ebutler_task/core/app/app_prefs.dart';
import 'package:ebutler_task/core/error/failures.dart';
import 'package:ebutler_task/core/network/auth_request.dart';
import 'package:ebutler_task/core/error/error_handler.dart';
import 'package:ebutler_task/features/auth_feature/data/models/auth_model.dart';

abstract class AuthLocalDataSource {
  Future<bool> loginOrRegister(AuthRequest authRequest);

  Future<bool> register(AuthRequest authRequest, List<AuthModel> cashedEmails);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final AppPreferences prefs;

  AuthLocalDataSourceImpl({required this.prefs});

  @override
  Future<bool> loginOrRegister(AuthRequest authRequest) async {
    try {
      final allSavedEmails = prefs.getAllUsers();
      final emailIndex = allSavedEmails
          .indexWhere((element) => element.email == authRequest.email);
      // Register new Email
      if (emailIndex == -1) {
        await register(authRequest, allSavedEmails);
        await prefs.setLastActive();
        return false;
      }
      // Login
      if (allSavedEmails[emailIndex].password == authRequest.password) {
        await prefs.setLastActive();
        return true;
      }
      throw ErrorHandler.handle(
          const Failure(ResponseCode.CACHE_ERROR, "Wrong Password"));
    } on ErrorHandler {
      rethrow;
    } catch (_) {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<bool> register(
      AuthRequest authRequest, List<AuthModel> cashedEmails) async {
    cashedEmails.add(
      AuthModel(
        email: authRequest.email,
        password: authRequest.password,
      ),
    );
    return await prefs.setAllUsers(cashedEmails);
  }
}
