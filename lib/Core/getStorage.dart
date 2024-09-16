import 'package:get_storage/get_storage.dart';

GetStorage localStorage = GetStorage();

setValueToLocal(String key, dynamic value) {
  localStorage.write(key, value);
}

getValurFromLocal<T>(String key) {
  final val = localStorage.read(key);
  return val;
}

removeValueFromLocal(String key) {
  localStorage.remove(key);
}
