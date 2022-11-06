import 'package:dartz/dartz.dart';
import 'package:ebutler_task/core/error/failures.dart';
import 'package:ebutler_task/core/network/paginated_user_request.dart';
import 'package:ebutler_task/core/usecases/usecase.dart';
import 'package:ebutler_task/features/users_feature/domain/entities/user.dart';
import 'package:ebutler_task/features/users_feature/domain/repositories/users_repository.dart';

class GetUsers extends BaseUseCase<PaginatedUserRequest, List<User>> {
  final UsersRepository usersRepository;

  GetUsers({required this.usersRepository});

  @override
  Future<Either<Failure, List<User>>> call(PaginatedUserRequest input) async {
    return await usersRepository.getAllUsers(input);
  }
}
