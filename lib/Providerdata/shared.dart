import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AppStatus extends ChangeNotifier{
  bool isStorageGranted=true;
  bool isRegistered=false;

  AppStatus(){
_alreadyRegistered();
  }
  CheckPermission()async{
    var status=await Permission.storage.request();
    if(status.isGranted){
      await Registeruser();
      isRegistered=true;
      notifyListeners();
    }else{
      var currentstatus=await Permission.storage.status;
      if(currentstatus.isPermanentlyDenied){
        isStorageGranted=false;
        notifyListeners();
      }
    }

  }
  setemail(String emailid)async{//to Create a collection of registered emailid

    SharedPreferences preferences=await SharedPreferences.getInstance();
    await preferences.setString('Email',emailid );
  }

  Registeruser() async{
SharedPreferences preferences=await SharedPreferences.getInstance();
var uuid=new Uuid();
await preferences.setString('devices-id', uuid.v1());

  }
  _alreadyRegistered()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    var deviceid=preferences.getString('device-id');
    if(deviceid!=null){
      isRegistered=true;
      notifyListeners();
    }
}
}