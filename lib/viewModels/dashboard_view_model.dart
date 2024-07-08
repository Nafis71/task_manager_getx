import 'package:get/get.dart';

class DashboardViewModel extends GetxController {
  int _index = 0;

  int get index => _index;

  set setIndex(int index) {
    _index = index;
    update();
  }

  void refreshViewModel() {
    update();
  }
}
