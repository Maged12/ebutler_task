import 'package:ebutler_task/core/app/functions.dart';
import 'package:ebutler_task/core/network/auth_request.dart';
import 'package:ebutler_task/core/routes/app_routes.dart';
import 'package:ebutler_task/core/utils/app_strings.dart';
import 'package:ebutler_task/core/utils/constants.dart';
import 'package:ebutler_task/core/widgets/h100.dart';
import 'package:ebutler_task/core/widgets/h25.dart';
import 'package:ebutler_task/features/auth_feature/presentation/cubit/auth_feature_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";

  // @override
  // void initState() {
  //   super.initState();
  //   final lastActive = DateTime.now()
  //       .subtract(const Duration(minutes: 60));
  //   final now = DateTime.now();
  //   now.isBefore(lastActive.add(const Duration(hours: 1)));
  //   print("now.isBefore(lastActive.add(const Duration(hours: 1))) :${now.isBefore(lastActive.add(const Duration(hours: 1)))}");
  //   // WidgetsBinding.instance.addObserver(this);
  // }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) {
  //     instance<AppPreferences>().setLastActive();
  //   }
  //   super.didChangeAppLifecycleState(state);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.welcomeKey,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Column(
        children: [
          const H100(),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextFormField(
                    validator: emailValidation,
                    onSaved: (newValue) => email = newValue!,
                    decoration: const InputDecoration(
                      hintText: AppStrings.emailHint,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.email_rounded,
                      ),
                    ),
                  ),
                  const H25(),
                  TextFormField(
                    validator: passwordValidation,
                    onSaved: (newValue) => password = newValue!,
                    decoration: const InputDecoration(
                      hintText: AppStrings.passwordHint,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.password_rounded,
                      ),
                    ),
                    obscureText: true,
                  ),
                ],
              ),
            ),
          ),
          const H25(),
          BlocConsumer<AuthFeatureCubit, AuthFeatureState>(
            listener: (context, state) {
              if (state is AuthFeatureFail) {
                Constants.showToast(msg: state.errorMessage);
              } else if (state is AuthFeatureSuccesss) {
                Constants.showToast(msg: state.successsMessage);
                Navigator.of(context).pushNamed(Routes.usersRoute);
              }
            },
            builder: (context, state) {
              if (state is AuthFeatureLoading) {
                return const CircularProgressIndicator();
              }
              return ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState?.save();
                    context.read<AuthFeatureCubit>().loginOrRegister(
                          AuthRequest(
                            email: email,
                            password: password,
                          ),
                        );
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(150, 45),
                ),
                child: const Text(
                  AppStrings.continueKey,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
