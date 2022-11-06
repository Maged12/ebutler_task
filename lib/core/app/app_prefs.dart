import 'dart:convert';

import 'package:ebutler_task/features/auth_feature/data/models/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefsKeyLastActive = "prefsKeyLastActive";
const String prefsKeyAllUsers = "prefsKeyAllUsers";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<bool> setLastActive() => _sharedPreferences.setInt(
        prefsKeyLastActive,
        DateTime.now().millisecondsSinceEpoch,
      );

  DateTime getLastActiveTime() =>
      DateTime.fromMillisecondsSinceEpoch(_sharedPreferences.getInt(
            prefsKeyLastActive,
          ) ??
          0);

  bool isStillActiveLogin() {
    final lastAvtiveTime = _sharedPreferences.getInt(
      prefsKeyLastActive,
    );
    if (lastAvtiveTime != null) {
      final lastActiveDate =
          DateTime.fromMillisecondsSinceEpoch(lastAvtiveTime);
      return DateTime.now().isBefore(
        lastActiveDate.add(
          const Duration(hours: 1),
        ),
      );
    }
    return false;
  }

  List<AuthModel> getAllUsers() {
    final allUsersList = _sharedPreferences.getString(prefsKeyAllUsers);
    final List<AuthModel> authList = <AuthModel>[];
    if (allUsersList != null) {
      jsonDecode(allUsersList).forEach((element) {
        authList.add(AuthModel.fromMap(element));
      });
    }
    return authList;
  }

  Future<bool> setAllUsers(List<AuthModel> users) async {
    final usersList = users.map((element) => element.toMap()).toList();
    return await _sharedPreferences.setString(
      prefsKeyAllUsers,
      jsonEncode(usersList),
    );
  }
}
