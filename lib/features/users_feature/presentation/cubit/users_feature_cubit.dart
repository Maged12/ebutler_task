import 'package:bloc/bloc.dart';
import 'package:ebutler_task/core/network/paginated_user_request.dart';
import 'package:ebutler_task/features/users_feature/domain/entities/user.dart';
import 'package:ebutler_task/features/users_feature/domain/repositories/users_repository.dart';
import 'package:equatable/equatable.dart';

part 'users_feature_state.dart';

class UsersFeatureCubit extends Cubit<UsersFeatureState> {
  final UsersRepository usersRepository;

  UsersFeatureCubit({required this.usersRepository})
      : super(UsersFeatureInitial());

  Future<void> getUsers(PaginatedUserRequest paginatedUserRequest,
      {List<User>? oldUsersList}) async {
    emit(UsersFeatureLoading());
    final response = await usersRepository.getAllUsers(paginatedUserRequest);
    response.fold(
      (failure) => emit(
        UsersFeatureError(
          errorMessage: failure.message,
          paginatedUserRequest: paginatedUserRequest,
        ),
      ),
      (usersList) => emit(
        UsersFeatureLoaded(
          usersList: oldUsersList == null
              ? usersList
              : [...oldUsersList, ...usersList],
          hasMore:
              usersList.length % int.parse(paginatedUserRequest.limit) == 0,
          paginatedUserRequest: paginatedUserRequest,
        ),
      ),
    );
  }

  Future<void> loadMoreUsers(PaginatedUserRequest paginatedUserRequest,
      List<User> oldUsersList) async {
    final response = await usersRepository.getAllUsers(paginatedUserRequest);
    response.fold(
      (failure) => emit(
        UsersFeatureError(
          errorMessage: failure.message,
          paginatedUserRequest: paginatedUserRequest,
        ),
      ),
      (usersList) => emit(
        UsersFeatureLoaded(
          usersList: [...oldUsersList, ...usersList],
          hasMore:
              usersList.length % int.parse(paginatedUserRequest.limit) == 0,
          paginatedUserRequest: paginatedUserRequest,
        ),
      ),
    );
  }

  void getMoreUsers() {
    if (state is UsersFeatureLoaded && (state as UsersFeatureLoaded).hasMore) {
      final paginatedUserRequest =
          (state as UsersFeatureLoaded).paginatedUserRequest;
      final oldList = (state as UsersFeatureLoaded).usersList;
      loadMoreUsers(
        PaginatedUserRequest(
          page: "${int.parse(paginatedUserRequest.page) + 1}",
          limit: paginatedUserRequest.limit,
        ),
        oldList,
      );
    }
  }
}
