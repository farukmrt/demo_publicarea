import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_publicarea/models/building.dart';
import 'package:flutter/material.dart';

class BuildingProvider with ChangeNotifier {
  final _buildingStreamController = StreamController<BuildingModel>.broadcast();
  Stream<BuildingModel> get buildingStream => _buildingStreamController.stream;

  late BuildingModel currentBuilding;
  final _buildingRef = FirebaseFirestore.instance.collection('building');

  void updateCurrentBuilder(BuildingModel building) {
    if (building.buildingId != "") {
      currentBuilding = building;
    }
    notifyListeners();
  }

  Future<BuildingModel?> getCurrentBuilding(String? buildingId) async {
    if (buildingId != null) {
      final snap = await _buildingRef.doc(buildingId).get();
      if (snap.exists) {
        return BuildingModel.fromFirestore(snap.data()!);
      }
    }
    return null;
  }

  Future<BuildingModel?> fetchBuilding(String buildingId) async {
    var collection = FirebaseFirestore.instance.collection('building');
    var query = collection.where('buildingId', isEqualTo: buildingId).limit(1);

    var querySnapshot = await query.get();
    if (querySnapshot.docs.isNotEmpty) {
      var document = querySnapshot.docs.first;

      var building = BuildingModel(
        buildName: document.data()['buildName'],
        buildingId: document.data()['buildingId'],
        country: document.data()['country'],
        town: document.data()['town'],
        imageUrl: document.data()['imageUrl'],
      );

      updateCurrentBuilder(building);
      notifyListeners();
      return building;
    } else {
      return null;
    }
  }

  static Future<List<BuildingModel>> fetchBuildingList() async {
    var collection = FirebaseFirestore.instance.collection('building');
    var querySnapshot = await collection.get();

    List<BuildingModel> buildingList = [];
    querySnapshot.docs.forEach((document) {
      var building = BuildingModel(
        buildName: document.data()['buildName'],
        buildingId: document.data()['buildingId'],
        country: document.data()['country'],
        imageUrl: document.data()['imageUrl'],
        town: document.data()['town'],
      );
      buildingList.add(building);
    });
    return buildingList;
  }

  Future<String> fetchBuildingId(String buildName) async {
    var collection = FirebaseFirestore.instance.collection('building');
    var query = await collection.where("buildName", isEqualTo: buildName).get();

    if (query.docs.isNotEmpty) {
      String buildingId = await query.docs.first.get("buildingId");
      print('fetch $buildingId');
      return buildingId;
    } else {
      return '0000';
    }
  }

  Future<List<Map<String, dynamic>>> getBuildingList() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('building').get();
    return querySnapshot.docs
        .map((DocumentSnapshot document) =>
            document.data() as Map<String, dynamic>)
        .toList();
  }

  Future<void> signOutBuilding(BuildContext context) async {
    currentBuilding = BuildingModel(
        buildName: '', buildingId: '', country: '', town: '', imageUrl: '');
    notifyListeners();
  }
}
