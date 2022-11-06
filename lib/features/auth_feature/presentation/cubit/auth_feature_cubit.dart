import 'package:bloc/bloc.dart';
import 'package:ebutler_task/core/error/failures.dart';
import 'package:ebutler_task/core/network/auth_request.dart';
import 'package:ebutler_task/core/utils/app_strings.dart';
import 'package:ebutler_task/features/auth_feature/domain/usecases/login_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

part 'auth_feature_state.dart';

class AuthFeatureCubit extends Cubit<AuthFeatureState> {
  AuthFeatureCubit(this._loginOrRegister) : super(AuthFeatureInitial());
  final LoginOrRegister _loginOrRegister;

  Future<void> loginOrRegister(AuthRequest authRequest) async {
    emit(AuthFeatureLoading());
    final Either<Failure, bool> response = await _loginOrRegister(authRequest);
    response.fold(
      (failure) => emit(AuthFeatureFail(errorMessage: failure.message)),
      (isLogin) => emit(
        AuthFeatureSuccesss(
          successsMessage: isLogin
              ? AppStrings.welcomeAgainKey
              : AppStrings.successRegisterKey,
        ),
      ),
    );
   
  }
}
