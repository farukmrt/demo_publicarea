import 'package:uuid/uuid.dart';

class UniqueId {
  static String generate() {
    Uuid uuid = const Uuid();
    return uuid.v4();
  }
}
