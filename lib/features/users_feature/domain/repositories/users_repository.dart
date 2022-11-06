import 'package:dartz/dartz.dart';
import 'package:ebutler_task/core/error/failures.dart';
import 'package:ebutler_task/core/network/add_user_request.dart';
import 'package:ebutler_task/core/network/paginated_user_request.dart';
import 'package:ebutler_task/features/users_feature/domain/entities/user.dart';

abstract class UsersRepository {
  Future<Either<Failure, List<User>>> getAllUsers(
      PaginatedUserRequest paginatedUserRequest);
  Future<Either<Failure, bool>> addUsers(AddUserRequest addUserRequest);
  // Future<Either<Failure, bool>> editUsers(UserRequest userRequest);
}
