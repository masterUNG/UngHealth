import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unghealth/bodys/list_job_nurse.dart';
import 'package:unghealth/bodys/my_profile_nurse.dart';
import 'package:unghealth/model/user_model.dart';
import 'package:unghealth/utility/my_constant.dart';
import 'package:unghealth/utility/my_dialog.dart';
import 'package:unghealth/widgets/build_signout.dart';
import 'package:unghealth/widgets/show_draw_header.dart';
import 'package:unghealth/widgets/show_progress.dart';
import 'package:unghealth/widgets/show_title.dart';

class NurseService extends StatefulWidget {
  const NurseService({Key? key}) : super(key: key);

  @override
  _NurseServiceState createState() => _NurseServiceState();
}

class _NurseServiceState extends State<NurseService> {
  UserModel? userModel;
  List<Widget> widgets = [];
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUserModel();
  }

  Future<Null> findUserModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> datas = preferences.getStringList('data')!;

    String apiGetUser =
        '${MyConstant.domain}/getUserWhereUserUng.php?isAdd=true&user=${datas[0]}';
    await Dio().get(apiGetUser).then((value) {
      for (var item in json.decode(value.data)) {
        setState(() {
          userModel = UserModel.fromMap(item);
          widgets.add(ListJobNurse());
          widgets.add(MyProfileNurse());

          if (userModel!.status.isEmpty) {
            MyDialog().warnAddProfie(context, MyConstant.routeAddEditProfileNurse);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
        title: Text('Nurse'),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            BuildSignOut(),
            Column(
              children: [
                userModel == null
                    ? SizedBox()
                    : ShowDrawerHeader(
                        userModel: userModel!,
                      ),
                menuListJob(),
                menuMyProfile(),
              ],
            ),
          ],
        ),
      ),
      body: widgets.length == 0 ? ShowProgress() : widgets[index],
    );
  }

  ListTile menuListJob() {
    return ListTile(
      onTap: () {
        setState(() {
          index = 0;
        });
        Navigator.pop(context);
      },
      leading: Icon(
        Icons.filter_1,
        size: 36,
        color: MyConstant.dart,
      ),
      title: ShowTitle(
        title: 'List Job',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(title: 'รายการงานทั้งหมด'),
    );
  }

  ListTile menuMyProfile() {
    return ListTile(
      onTap: () {
        setState(() {
          index = 1;
        });
        Navigator.pop(context);
      },
      leading: Icon(
        Icons.filter_2,
        size: 36,
        color: MyConstant.dart,
      ),
      title: ShowTitle(
        title: 'My Profile',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(title: 'จัดการ และ บริหาร Profile ของฉัน'),
    );
  }
}
