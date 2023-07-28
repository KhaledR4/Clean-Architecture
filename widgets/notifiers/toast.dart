import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const errorColor = Colors.red;
const successColor = Colors.green;
const neutralColor = Colors.grey;

class Toast{
  static const networkErrorMessage = "Please check your connection.";
  static const serverErrorMessage = "Server Error, Try again later.";

  static void toast(String message, Color color){
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor: Colors.black,
    );
  }

  static void errorToast(String message){
    toast(message, errorColor);
  }

  static void successToast(String message){
    toast(message, successColor);
  }

  static void neutralToast(String message){
    toast(message, neutralColor);
  }

  static void networkErrorToast(){
    toast(networkErrorMessage, errorColor);
  }

  static void serverErrorToast(){
    toast(serverErrorMessage, errorColor);
  }
}

