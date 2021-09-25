import 'package:flutter/material.dart';
import 'package:unghealth/utility/my_constant.dart';

class MyProfileNurse extends StatefulWidget {
  const MyProfileNurse({Key? key}) : super(key: key);

  @override
  _MyProfileNurseState createState() => _MyProfileNurseState();
}

class _MyProfileNurseState extends State<MyProfileNurse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('This is My Profile'),
      floatingActionButton: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: MyConstant.primary),
          onPressed: () =>
              Navigator.pushNamed(context, MyConstant.routeAddEditProfileNurse),
          child: Text('Add or Edit')),
    );
  }
}
