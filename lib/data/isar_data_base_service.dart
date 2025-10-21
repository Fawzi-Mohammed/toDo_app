import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/user_model.dart';

class IsarService {
  static late Isar _isar;

  static Future<void> init() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      _isar = await Isar.open(
        [TaskSchema, UserModelSchema], 
        directory: dir.path,
      );
    } else {
      _isar = Isar.getInstance()!;
    }
  }

  static Isar get isar => _isar;
}
