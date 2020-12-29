import 'package:flutter/cupertino.dart';

import 'bloc/preference_bloc.dart';

class PreferenceProvider with ChangeNotifier{
  Preference _bloc;
  PreferenceProvider(){
    _bloc = Preference();
    _bloc.loadPref();
  }

  Preference get bloc=>_bloc;

}