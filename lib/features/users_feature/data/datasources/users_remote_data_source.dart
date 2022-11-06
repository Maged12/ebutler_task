import 'package:ebutler_task/core/api/api_consumer.dart';
import 'package:ebutler_task/core/api/end_points.dart';
import 'package:ebutler_task/core/network/paginated_user_request.dart';
import 'package:ebutler_task/features/users_feature/data/models/user_model.dart';

abstract class UsersRemoteDataSource {
  Future<List<UserModel>> getAllUsers(
      PaginatedUserRequest paginatedUserRequest);
}

class UsersRemoteDataSourceImpl extends UsersRemoteDataSource {
  final ApiConsumer apiConsumer;

  UsersRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<UserModel>> getAllUsers(
      PaginatedUserRequest paginatedUserRequest) async {
    final queryParameters = {
      "page": paginatedUserRequest.page,
      "limit": paginatedUserRequest.limit,
    };
    final response = await apiConsumer.get(EndPoints.usersUrl,
        queryParameters: queryParameters);
    final List<UserModel> usersModelList = <UserModel>[];
    response.forEach((element) {
      usersModelList.add(
        UserModel.fromMap(element),
      );
    });

    return usersModelList;
  }
}
