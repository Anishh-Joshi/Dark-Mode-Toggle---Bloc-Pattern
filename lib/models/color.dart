import 'package:flutter/material.dart';
class ColorModel {

  final double index;
  final Color color;
  final String name;
  ColorModel({this.index,this.name,this.color});


  set ind(double ind){
    ind=index;
  }
  set color(Color color){
    color=color;
  }
  set name(String name){
    name=name;
  }

}