import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:unghealth/utility/my_constant.dart';
import 'package:unghealth/utility/my_dialog.dart';
import 'package:unghealth/widgets/show_title.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String? typeUser;
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Container buildName() {
    return Container(
      margin: EdgeInsets.only(top: 48),
      width: 300,
      child: TextFormField(
        controller: nameController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Fill Name ?';
          } else {}
        },
        style: MyConstant().h3Style(),
        decoration: InputDecoration(
          labelStyle: MyConstant().h3Style(),
          labelText: 'Name :',
          prefixIcon: Icon(
            Icons.fingerprint,
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

  Container buildUser() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 300,
      child: TextFormField(
        controller: userController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Fill User ?';
          } else {}
        },
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
        controller: passwordController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Fill Password ?';
          } else {}
        },
        style: MyConstant().h3Style(),
        decoration: InputDecoration(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Account'),
        backgroundColor: MyConstant.primary,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 50),
            children: [
              buildName(),
              Container(
                padding: EdgeInsets.only(bottom: 16),
                margin: EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: MyConstant.dart),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildTitle(),
                    radioUser(),
                    radioNurse(),
                  ],
                ),
              ),
              buildUser(),
              buildPassword(),
              buildCreateAccount(),
            ],
          ),
        ),
      ),
    );
  }

  Container buildCreateAccount() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      width: 300,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: MyConstant.primary),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            if (typeUser == null) {
              MyDialog().normalDialog(
                  context, 'No Type User ?', 'Please Choose Type User');
            } else {
              checkUserAndCreateAccount();
            }
          }
        },
        child: Text('Create Account'),
      ),
    );
  }

  Future<Null> checkUserAndCreateAccount() async {
    String name = nameController.text;
    String user = userController.text;
    String password = passwordController.text;
    print(
        'name = $name, user = $user, password = $password, typeUser = $typeUser');

    String apiCheckUser =
        '${MyConstant.domain}/getUserWhereUserUng.php?isAdd=true&user=$user';
    await Dio().get(apiCheckUser).then((value) async {
      print('value = $value');
      if (value.toString() == 'null') {
        String apiInsertUser =
            '${MyConstant.domain}/insertUserUng.php?isAdd=true&name=$name&typeUser=$typeUser&user=$user&password=$password';
        await Dio().get(apiInsertUser).then((value) {
          if (value.toString() == 'true') {
            Navigator.pop(context);
          } else {
            MyDialog().normalDialog(
                context, 'Cannot Create Account ?', 'Please Try Again');
          }
        });
      } else {
        MyDialog().normalDialog(
            context, 'User False ?', 'User นี่มีคนอื่นใช้ ไปแล้ว คะ ');
      }
    });
  }

  Container radioUser() {
    return Container(
      width: 250,
      height: 40,
      child: RadioListTile(
        title: ShowTitle(title: 'General User'),
        value: 'user',
        groupValue: typeUser,
        onChanged: (value) {
          setState(() {
            typeUser = value as String?;
          });
        },
      ),
    );
  }

  Container radioNurse() {
    return Container(
      width: 250,
      height: 40,
      child: RadioListTile(
        title: ShowTitle(title: 'Nurse'),
        value: 'nurse',
        groupValue: typeUser,
        onChanged: (value) {
          setState(() {
            typeUser = value as String?;
          });
        },
      ),
    );
  }

  Container radioAmbulane() {
    return Container(
      width: 250,
      height: 40,
      child: RadioListTile(
        title: ShowTitle(title: 'Ambulane'),
        value: 'ambulane',
        groupValue: typeUser,
        onChanged: (value) {
          setState(() {
            typeUser = value as String?;
          });
        },
      ),
    );
  }

  Row buildTitle() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ShowTitle(
            title: 'Type User :',
            textStyle: MyConstant().h2Style(),
          ),
        ),
      ],
    );
  }
}
