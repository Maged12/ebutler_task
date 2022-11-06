// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_feature_cubit.dart';

abstract class AuthFeatureState extends Equatable {
  const AuthFeatureState();

  @override
  List<Object> get props => [];
}

class AuthFeatureInitial extends AuthFeatureState {}

class AuthFeatureLoading extends AuthFeatureState {}

class AuthFeatureSuccesss extends AuthFeatureState {
  final String successsMessage;
  const AuthFeatureSuccesss({
    required this.successsMessage,
  });
  @override
  List<Object> get props => [successsMessage];
}

class AuthFeatureFail extends AuthFeatureState {
  final String errorMessage;
  const AuthFeatureFail({
    required this.errorMessage,
  });
  @override
  List<Object> get props => [errorMessage];
}
