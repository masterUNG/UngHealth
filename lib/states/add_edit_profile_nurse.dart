import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unghealth/model/user_model.dart';
import 'package:unghealth/utility/my_constant.dart';
import 'package:unghealth/utility/my_dialog.dart';
import 'package:unghealth/widgets/show_image.dart';
import 'package:unghealth/widgets/show_map.dart';
import 'package:unghealth/widgets/show_progress.dart';

class AddEditProfilNurse extends StatefulWidget {
  const AddEditProfilNurse({Key? key}) : super(key: key);

  @override
  _AddEditProfilNurseState createState() => _AddEditProfilNurseState();
}

class _AddEditProfilNurseState extends State<AddEditProfilNurse> {
  UserModel? userModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  double? lat;
  double? lng;
  File? file;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findProfile();
    findLatLng();
  }

  Future<Null> findLatLng() async {
    Position? position = await findPosition();
    if (position != null) {
      setState(() {
        lat = position.latitude;
        lng = position.longitude;
        print('lat = $lat, lng = $lng');
      });
    }
  }

  Future<Position?> findPosition() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition();
    } catch (e) {
      return null;
    }
    return position;
  }

  Future<Null> findProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> datas = preferences.getStringList('data')!;
    String apiGetUser =
        '${MyConstant.domain}/getUserWhereUserUng.php?isAdd=true&user=${datas[0]}';
    await Dio().get(apiGetUser).then((value) {
      for (var item in json.decode(value.data)) {
        setState(() {
          userModel = UserModel.fromMap(item);
          nameController.text = userModel!.name;
          addressController.text = userModel!.address;
          phoneController.text = userModel!.phone;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () => processSave(), icon: Icon(Icons.save))
          ],
          backgroundColor: MyConstant.primary,
          title: Text('Add or Edit Profile'),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) =>
              userModel == null ? ShowProgress() : buildContent(constraints),
        ));
  }

  Widget buildContent(BoxConstraints constraints) => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            children: [
              fieldName(),
              fieldAddress(),
              fieldPhone(),
              buildAvatar(constraints),
              buildMap(constraints),
              buildSave(),
            ],
          ),
        ),
      );

  ElevatedButton buildSave() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(primary: MyConstant.primary),
      onPressed: () => processSave(),
      icon: Icon(Icons.save),
      label: Text('Save'),
    );
  }

  Future<Null> processSave() async {
    if (formKey.currentState!.validate()) {
      if (file == null) {
        MyDialog().normalDialog(context, 'No Avatar', 'Please Choose Avatar');
      } else {
        String apiSaveFile = '${MyConstant.domain}/saveFileUng.php';
        String nameFile = 'avatar${Random().nextInt(100000)}.jpg';

        Map<String, dynamic> map = {};
        map['file'] =
            await MultipartFile.fromFile(file!.path, filename: nameFile);
        await Dio()
            .post(apiSaveFile, data: FormData.fromMap(map))
            .then((value) => print('Upload Success'));
      }
    }
  }

  Container buildMap(BoxConstraints constraints) {
    return Container(
      child: lat == null ? ShowProgress() : ShowMap(latlng: LatLng(lat!, lng!)),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      margin: EdgeInsets.symmetric(vertical: 32),
      width: constraints.maxWidth * 0.8,
      height: constraints.maxWidth * 0.6,
    );
  }

  Future<Null> processChooseImage(ImageSource source) async {
    try {
      var result = await ImagePicker().pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result!.path);
      });
    } catch (e) {}
  }

  Container buildAvatar(BoxConstraints constraints) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      margin: EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () => processChooseImage(ImageSource.camera),
              icon: Icon(
                Icons.add_a_photo,
                size: 36,
              )),
          Container(
            width: constraints.maxWidth * 0.5,
            height: constraints.maxWidth * 0.5,
            child: file == null
                ? ShowImage(path: 'images/avatar.png')
                : Image.file(file!),
          ),
          IconButton(
              onPressed: () => processChooseImage(ImageSource.gallery),
              icon: Icon(
                Icons.add_photo_alternate,
                size: 36,
              )),
        ],
      ),
    );
  }

  Row fieldName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 36),
          width: 250,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Fill Name';
              } else {
                return null;
              }
            },
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Name :',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row fieldAddress() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: 250,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Fill Address';
              } else {
                return null;
              }
            },
            maxLines: 3,
            controller: addressController,
            decoration: InputDecoration(
              labelText: 'Address :',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row fieldPhone() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: 250,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Fill Phone';
              } else {
                return null;
              }
            },
            controller: phoneController,
            decoration: InputDecoration(
              labelText: 'Phone :',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
