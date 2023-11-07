import 'package:asistencia_app/local/db/database.dart';

mixin ConexionDB {
  Future<AppDatabase> conetion() async {
    return await $FloorAppDatabase.databaseBuilder('app_eventos.db').build();
  }
}
