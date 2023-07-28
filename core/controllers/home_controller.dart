import 'package:get/get.dart';

class HomePageController extends GetxController{
  RxInt bottomPageIndex = RxInt(0);

  void setBottomIndex(int index){
    bottomPageIndex.value = index;
  }
}