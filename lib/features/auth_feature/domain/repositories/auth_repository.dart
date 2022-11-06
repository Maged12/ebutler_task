import 'package:dartz/dartz.dart';
import 'package:ebutler_task/core/error/failures.dart';
import 'package:ebutler_task/core/network/auth_request.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> loginOrRegister(AuthRequest authRequest);
}
