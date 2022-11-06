import 'package:ebutler_task/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:ebutler_task/core/network/auth_request.dart';
import 'package:ebutler_task/core/usecases/usecase.dart';
import 'package:ebutler_task/features/auth_feature/domain/repositories/auth_repository.dart';

class LoginOrRegister implements BaseUseCase<AuthRequest, bool> {
  final AuthRepository authRepository;

  LoginOrRegister({required this.authRepository});
  @override
  Future<Either<Failure, bool>> call(AuthRequest input) =>
      authRepository.loginOrRegister(input);
}
