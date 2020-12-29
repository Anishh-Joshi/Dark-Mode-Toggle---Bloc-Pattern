import 'package:bloc_providernew/models/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/preference_bloc.dart';

import '../provider.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final blocc=Provider.of<PreferenceProvider>(context).bloc;
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        //Save Settings
        leading: GestureDetector(
          onTap: (){
            blocc.savePreferences();
            Navigator.of(context).pop();
          },
            child: Icon(Icons.arrow_back)
        ),
      ),
      body: Center(child: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Dark Mode'),
              StreamBuilder<Brightness>(
                  stream: blocc.brightness,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Container();
                    return Switch(
                      value: (snapshot.data == Brightness.light) ? false : true,
                      onChanged: (bool value){
                        if (value){
                          blocc.brightnessSink(Brightness.dark);
                        } else {
                          blocc.brightnessSink(Brightness.light);
                        }
                      },
                    );
                  }
              )
            ],),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Primary Color'),
              StreamBuilder<ColorModel>(
                  stream: blocc.color,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Container();
                    return Slider(
                      value: snapshot.data.index,
                      min:0.0,
                      max: 3.0,
                      divisions: 3,
                      label: snapshot.data.name,
                      onChanged: (double value){
                        blocc.colorSink(blocc.indexToPrimaryColor(value));
                      },
                    );
                  }
              )
            ],),
        ),
      ],),),
    );
  }
}
