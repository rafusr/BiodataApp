import 'package:flutter/material.dart';
import 'package:tog_technical_test/database_helper.dart';
import 'package:tog_technical_test/entity/data.dart';

class DbProvider extends ChangeNotifier {
  List<Data> _datas = [];
  late DatabaseHelper _dbHelper;

  List<Data> get datas => _datas;

  DbProvider() {
    _dbHelper = DatabaseHelper();
    _getAllDatas;
  }

  Future<void> addData(Data data) async {
    await _dbHelper.insertData(data);
    _getAllDatas();
  }

  void _getAllDatas() async {
    _datas = await _dbHelper.getDatas();
    notifyListeners();
  }
}
