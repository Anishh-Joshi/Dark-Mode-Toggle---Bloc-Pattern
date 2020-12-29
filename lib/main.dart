import 'package:bloc_providernew/provider.dart';
import 'package:bloc_providernew/widgets/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/color.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => PreferenceProvider(),
        child: Consumer<PreferenceProvider>(
          builder: (context, provider, child) {
            return StreamBuilder<Brightness>(
              stream: provider.bloc.brightness,
              builder: (context, snapshot) {
                return StreamBuilder<ColorModel>(
                  stream: provider.bloc.color,
                  builder: (context, snapshotPrimarycolor) {
                    if(!snapshotPrimarycolor.hasData){
                      return Container();
                    }
                    return MaterialApp(
                      title: "Flutter Provider",
                      theme: ThemeData(
                        primaryColor: snapshotPrimarycolor.data.color,
                        brightness: snapshot.data,
                      ),
                      home: Home(),
                    );
                  }
                );
              }
            );
          },
        ));
  }
}
