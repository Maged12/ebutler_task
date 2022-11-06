part of 'users_feature_cubit.dart';

abstract class UsersFeatureState extends Equatable {
  const UsersFeatureState();

  @override
  List<Object> get props => [];
}

class UsersFeatureInitial extends UsersFeatureState {}

class UsersFeatureLoading extends UsersFeatureState {}

class UsersFeatureLoaded extends UsersFeatureState {
  final List<User> usersList;
  final bool hasMore;
  final PaginatedUserRequest paginatedUserRequest;

  const UsersFeatureLoaded({
    required this.usersList,
    required this.hasMore,
    required this.paginatedUserRequest,
  });

  @override
  List<Object> get props => [
        usersList,
        hasMore,
        paginatedUserRequest,
      ];
}

class UsersFeatureError extends UsersFeatureState {
  final String errorMessage;
  final PaginatedUserRequest paginatedUserRequest;

  const UsersFeatureError({
    required this.errorMessage,
    required this.paginatedUserRequest,
  });

  @override
  List<Object> get props => [errorMessage];
}
