import 'package:dartz/dartz.dart';
import 'package:ebutler_task/core/error/error_handler.dart';
import 'package:ebutler_task/core/error/failures.dart';
import 'package:ebutler_task/core/network/add_user_request.dart';
import 'package:ebutler_task/core/network/netwok_info.dart';
import 'package:ebutler_task/core/network/paginated_user_request.dart';
import 'package:ebutler_task/features/users_feature/data/datasources/users_remote_data_source.dart';
import 'package:ebutler_task/features/users_feature/domain/entities/user.dart';
import 'package:ebutler_task/features/users_feature/domain/repositories/users_repository.dart';

class UsersRepositoryImpl extends UsersRepository {
  final UsersRemoteDataSource usersRemoteDataSource;

  final NetworkInfo networkInfo;

  UsersRepositoryImpl({
    required this.usersRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, bool>> addUsers(AddUserRequest addUserRequest) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<User>>> getAllUsers(
      PaginatedUserRequest paginatedUserRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await usersRemoteDataSource.getAllUsers(
          paginatedUserRequest,
        );
        return right(response);
      } catch (err) {
        return left(ErrorHandler.handle(err).failure);
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
