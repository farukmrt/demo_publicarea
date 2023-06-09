import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class UUIDProvider extends ChangeNotifier {
  String _uniqueId = '';

  String get uniqueId => _uniqueId;

  void generateUniqueId() {
    Uuid uuid = const Uuid();
    _uniqueId = uuid.v4();
    notifyListeners();
  }
}
