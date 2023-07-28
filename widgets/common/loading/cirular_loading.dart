import 'package:flutter/material.dart';

Widget loadingWidget(){
  return const SizedBox(
                  height: 20,
                  width: 20,
                  child:  
                  Padding(padding: EdgeInsets.symmetric(vertical: 4) ,child: CircularProgressIndicator(strokeWidth:2, color: Colors.white,)),
                );
}