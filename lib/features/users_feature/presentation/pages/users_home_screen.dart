import 'dart:async';

import 'package:ebutler_task/core/app/app_prefs.dart';
import 'package:ebutler_task/core/app/injection_container.dart';
import 'package:ebutler_task/core/network/paginated_user_request.dart';
import 'package:ebutler_task/core/utils/constants.dart';
import 'package:ebutler_task/features/users_feature/presentation/cubit/users_feature_cubit.dart';
import 'package:flutter/material.dart';
import 'package:ebutler_task/core/widgets/error_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersHomeScreen extends StatefulWidget {
  const UsersHomeScreen({super.key});

  @override
  State<UsersHomeScreen> createState() => _UsersHomeScreenState();
}

class _UsersHomeScreenState extends State<UsersHomeScreen>
    with WidgetsBindingObserver {
  late final Timer _refreshLastActiveTimer;

  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _refreshLastActiveTimer = Timer.periodic(
      const Duration(minutes: 59),
      (_) => instance<AppPreferences>().setLastActive(),
    );
    context.read<UsersFeatureCubit>().getUsers(
          PaginatedUserRequest(page: "1", limit: "15"),
        );
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<UsersFeatureCubit>().getMoreUsers();
      }
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _refreshLastActiveTimer.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        updateActiveTime();
        break;
      case AppLifecycleState.paused:
        updateActiveTime();
        break;
      default:
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  Future<void> updateActiveTime() async {
    if (instance<AppPreferences>().isStillActiveLogin()) {
      await instance<AppPreferences>().setLastActive();
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Users",
          style: Theme.of(context).textTheme.headline1,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocConsumer<UsersFeatureCubit, UsersFeatureState>(
          listener: (context, state) {
        if (state is UsersFeatureError) {
          Constants.showErrorDialog(
            context: context,
            msg: state.errorMessage,
          );
        }
      }, builder: (context, state) {
        if (state is UsersFeatureLoading || state is UsersFeatureInitial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is UsersFeatureError) {
          return CustomErrorWidget(
            onPress: () {
              context
                  .read<UsersFeatureCubit>()
                  .getUsers(state.paginatedUserRequest);
            },
          );
        } else {
          final users = (state as UsersFeatureLoaded).usersList;
          final hasMore = state.hasMore;
          return ListView.builder(
            controller: _scrollController,
            itemBuilder: (context, index) => index == users.length
                ? Visibility(
                    visible: hasMore,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Card(
                    margin: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Center(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                    child: FadeInImage(
                                      height: 100,
                                      width: 100,
                                      placeholder: const NetworkImage(
                                        "https://picsum.photos/200",
                                      ),
                                      imageErrorBuilder:
                                          (context, error, stackTrace) =>
                                              Image.network(
                                        "https://picsum.photos/200",
                                        width: 100,
                                        height: 100,
                                      ),
                                      image: NetworkImage(users[index].avatar),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Text(
                                      users[index].name,
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ),
                                    Text(
                                      users[index].description,
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                      textAlign: TextAlign.center,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {},
                                        child: const Text("Add Location")),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
            itemCount: hasMore ? users.length + 1 : users.length,
          );
        }
      }),
    );
  }
}
