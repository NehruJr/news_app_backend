import 'package:dotenv/dotenv.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDB {
  static Db? _db;
  static bool _initialized = false;

  static Future<Db> getInstance() async {
    if (!_initialized) {
      final env = DotEnv()..load();
      final uri = env['MONGO_URI']!;
      _db = await Db.create(uri);
      await _db!.open();
      _initialized = true;
      print('✅ MongoDB connected');
    }
    return _db!;
  }
}
