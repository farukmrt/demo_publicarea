import 'package:demo_publicarea/models/building.dart' as model;
import 'package:demo_publicarea/models/user.dart' as model;
import 'package:demo_publicarea/models/userData.dart';
import 'package:demo_publicarea/providers/building_provider.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserDataProvider extends ChangeNotifier {
  Future<UserData> getUserData() async {
    model.UserModel? user = await UserProvider().getCurrentUser(
      FirebaseAuth.instance.currentUser != null
          ? FirebaseAuth.instance.currentUser!.uid
          : null,
    );

    model.BuildingModel? building = await BuildingProvider().fetchBuilding(
      user!.buildingId,
    );

    return UserData(user: user, building: building);
  }
}
