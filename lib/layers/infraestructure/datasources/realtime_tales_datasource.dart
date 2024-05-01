import 'package:cuentos_pasantia/layers/domain/entities/tales/tales.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class RealtimeTalesDatasource {
  final _talesData = FirebaseDatabase.instance.ref('content-tales');
  final _dbInstance = FirebaseDatabase.instance;

  void configureDatabase() {
    _dbInstance.setPersistenceEnabled(true);
    _dbInstance.setLoggingEnabled(true);
  }

  void addTaleData(Tales tale) {
    _talesData.child(tale.id).set(tale.dataToJson());
  }

  Future<Tales> getTaleData(String taleId) async {
    final snapshot = await _talesData.child(taleId).get().catchError((error) {
      debugPrint(error.toString());
      throw error;
    });
    return Tales.fromJson(snapshot.value as Map<String, dynamic>);
  }
}
