import 'package:ebutler_task/core/network/auth_request.dart';
import 'package:ebutler_task/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:ebutler_task/core/error/error_handler.dart';
import 'package:ebutler_task/core/network/netwok_info.dart';
import 'package:ebutler_task/features/auth_feature/data/datasources/auth_local_data_source.dart';
import 'package:ebutler_task/features/auth_feature/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final NetworkInfo networkInfo;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryImpl({
    required this.networkInfo,
    required this.authLocalDataSource,
  });
  @override
  Future<Either<Failure, bool>> loginOrRegister(AuthRequest authRequest) async {
    try {
      final response = await authLocalDataSource.loginOrRegister(authRequest);
      return Right(response);
    } on ErrorHandler catch (error) {
      return Left(error.failure);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
