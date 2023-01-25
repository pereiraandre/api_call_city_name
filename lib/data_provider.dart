import 'package:shared_preferences/shared_preferences.dart';

abstract class TempDataProvider{


  void setTempData(DataTypes key, dynamic data);
  dynamic getTempData(DataTypes key);

}
class MemoryTempDataProvider extends TempDataProvider{

  Map<DataTypes, dynamic> dataMap = {};
  
  @override
  void setTempData(DataTypes key, dynamic data){
    dataMap[key] = data;
  }

  @override
  dynamic getTempData(DataTypes key){
    return dataMap[key];
  }
}

class LocalStorage extends TempDataProvider {


  @override
  void setTempData(DataTypes key, data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key.name, data);
  }

  @override
  getTempData(DataTypes key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key.name) ?? '';

  }
}

 enum DataTypes {
  name,
  temperature
}

