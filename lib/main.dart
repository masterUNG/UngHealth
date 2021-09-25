import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unghealth/states/add_edit_profile_nurse.dart';
import 'package:unghealth/states/authen.dart';
import 'package:unghealth/states/create_account.dart';
import 'package:unghealth/states/nurse_service.dart';
import 'package:unghealth/states/user_service.dart';
import 'package:unghealth/utility/my_constant.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/userService': (BuildContext context) => UserService(),
  '/nurseService': (BuildContext context) => NurseService(),
  '/addEditProfileNurse': (BuildContext context) => AddEditProfilNurse(),
};

String? firstState;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  List<String>? datas = preferences.getStringList('data');
  print('datas on main ==>> $datas');
  if (datas == null) {
    firstState = MyConstant.routeAuthen;
    runApp(MyApp());
  } else {
    switch (datas[1]) {
      case 'user':
        firstState = MyConstant.routeUserService;
        runApp(MyApp());
        break;
      case 'nurse':
        firstState = MyConstant.routeNurseService;
        runApp(MyApp());
        break;
      default:
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: map,
      initialRoute: firstState,
    );
  }
}
