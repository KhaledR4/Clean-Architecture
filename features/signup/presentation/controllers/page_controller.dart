import 'package:get/get.dart';

class SignupPageController extends GetxController{
  RxInt currentIndex = RxInt(0);
  RxBool loading = RxBool(false);

  setIndex(int index){
    currentIndex.value = index;
  }

  setLoading(){
    loading.value = true;
  }

  stopLoading(){
    loading.value = false;
  }

  goToGymForm(){
    setIndex(2);
  }

  goToUserForm(){
    setIndex(1);
  }

  goToInitialForm(){
    setIndex(0);
  }
}