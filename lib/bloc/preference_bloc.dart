import 'dart:async';
import 'package:bloc_providernew/models/color.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preference{
  final _brightness = BehaviorSubject<Brightness>();
  final _color = BehaviorSubject<ColorModel>();
  final _colors=[
    ColorModel(color: Colors.blue,name:"Blue",index: 0.0),
    ColorModel(color: Colors.green,name:"green",index: 1.0),
    ColorModel(color: Colors.red,name:"red",index: 2.0),
    ColorModel(color: Colors.black,name:"black",index: 3.0),

  ];
  // Getters
  Stream<Brightness> get brightness=>_brightness.stream;
  Stream<ColorModel> get color=>_color.stream;
  //Setters
  Function(Brightness) get brightnessSink=>_brightness.sink.add;
  Function(ColorModel) get colorSink=>_color.sink.add;

  indexToPrimaryColor(double index){
    return _colors.firstWhere((x) => x.index==index);
  }
  savePreferences() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(_brightness.value == Brightness.light){
      await prefs.setBool("dark", false);
    }
    else{
      await prefs.setBool("dark", true);
    }
    await prefs.setDouble("colorIndex", _color.value.index);
  }
  loadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool darkMode=prefs.get('dark');
    double colorIndex=prefs.get('colorIndex');

    if(darkMode!=null){
      (darkMode==false) ? brightnessSink(Brightness.light):brightnessSink(Brightness.dark);
    }
    else{
      brightnessSink(Brightness.light);
    }

    if(colorIndex != null){
      colorSink(indexToPrimaryColor(colorIndex));
    }
    else{
      colorSink(ColorModel(color: Colors.blue,name:"Blue",index: 0.0));
    }
  }

  void dispose(){
    _color.close();
    _brightness.close();

}
  

}