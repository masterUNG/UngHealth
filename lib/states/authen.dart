import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unghealth/model/user_model.dart';
import 'package:unghealth/utility/my_constant.dart';
import 'package:unghealth/utility/my_dialog.dart';
import 'package:unghealth/widgets/show_image.dart';
import 'package:unghealth/widgets/show_title.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool redEye = true;
  final formKey = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Container(
          decoration: MyConstant().gradienBox(),
          child: Center(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildImage(),
                    buildAppName(),
                    buildUser(),
                    buildPassword(),
                    buildSignIn(),
                    buildCreateAccount(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row buildCreateAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShowTitle(title: 'No Account ?'),
        TextButton(
          onPressed: () =>
              Navigator.pushNamed(context, MyConstant.routeCreateAccount),
          child: ShowTitle(
            title: ' Create Account',
            textStyle: MyConstant().h2Style(),
          ),
        ),
      ],
    );
  }

  Container buildSignIn() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      width: 300,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: MyConstant.primary),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            checkAuthen();
          }
        },
        child: Text('Sign In'),
      ),
    );
  }

  Future<Null> checkAuthen() async {
    String apiCheckUser =
        '${MyConstant.domain}/getUserWhereUserUng.php?isAdd=true&user=${userController.text}';
    await Dio().get(apiCheckUser).then(
      (value) async {
        print('value = $value');
        if (value.toString() == 'null') {
          MyDialog().normalDialog(
              context, 'User False ?', 'ไม่มี User นี่ใน ฐานข้อมูลของเรา');
        } else {
          for (var item in json.decode(value.data)) {
            UserModel model = UserModel.fromMap(item);
            if (model.password == passwordController.text) {
              String typeUser = model.typeUser;
              print('typeUser = $typeUser');

              List<String> datas = [];
              datas.add(model.user);
              datas.add(model.typeUser);

              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.setStringList('data', datas).then((value) {
                 switch (typeUser) {
                case 'user':
                  Navigator.pushNamedAndRemoveUntil(
                      context, MyConstant.routeUserService, (route) => false);
                  break;
                case 'nurse':
                  Navigator.pushNamedAndRemoveUntil(
                      context, MyConstant.routeNurseService, (route) => false);
                  break;
                default:
              }
              });

             
            } else {
              MyDialog().normalDialog(
                  context, 'Password False ?', 'Please Try Again');
            }
          }
        }
      },
    );
  }

  Container buildUser() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 300,
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Fill User';
          } else {
            return null;
          }
        },
        controller: userController,
        style: MyConstant().h3Style(),
        decoration: InputDecoration(
          labelStyle: MyConstant().h3Style(),
          labelText: 'User :',
          prefixIcon: Icon(
            Icons.perm_identity,
            color: MyConstant.dart,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.dart),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.light),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 300,
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Fill Password';
          } else {
            return null;
          }
        },
        controller: passwordController,
        obscureText: redEye,
        style: MyConstant().h3Style(),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                redEye = !redEye;
              });
            },
            icon: Icon(
              Icons.remove_red_eye,
              color: MyConstant.primary,
            ),
          ),
          labelStyle: MyConstant().h3Style(),
          labelText: 'Password :',
          prefixIcon: Icon(
            Icons.lock_outline,
            color: MyConstant.dart,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.dart),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.light),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }

  ShowTitle buildAppName() {
    return ShowTitle(
      title: 'Ung Health',
      textStyle: MyConstant().h1Style(),
    );
  }

  Container buildImage() {
    return Container(
      width: 250,
      child: ShowImage(
        path: 'images/image3.png',
      ),
    );
  }
}
