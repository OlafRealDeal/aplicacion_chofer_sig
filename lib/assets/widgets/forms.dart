import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../assets/widgets/styles.dart';

import 'package:file_picker/file_picker.dart';

Widget idDropdown(BuildContext context,String id,List<String> list,Map text,Function(String?) onChanged){
  return SizedBox(
    child: DropdownButton<String>(
      isExpanded: true,
      value: id,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.black, fontSize: 20),
      underline: Container(
        height: 2,
        color: Style().uiColor(),
      ),
      onChanged: (String? newValue) {
        onChanged(newValue);
      },
      items: list
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(text[value]),
          alignment: Alignment.center,
        );
      }).toList(),
    ),
    width: MediaQuery.of(context).size.width*0.5,
  );
}

Future<dynamic> uploadFile() async{
  FilePickerResult? result=await FilePicker.platform.pickFiles(
    //allowMultiple: false,
    //type: FileType.image,
    //allowedExtensions: ['jpg', 'png', 'jpeg', 'bmp']
  );

  if (result != null) {
    if (!kIsWeb){
      return result.files.single.path.toString();
    }
    if (kIsWeb){
      return result.files.first.bytes as Uint8List;
    }
  } else {
    // User canceled the picker
  }
}

Future<dynamic> uploadImage() async{
  FilePickerResult? result;
  if (!kIsWeb){
    result=await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
      //allowedExtensions: ['jpg', 'png', 'jpeg', 'bmp']
    );
  }
  if (kIsWeb){
    result = await FilePicker.platform.pickFiles(
      //allowMultiple: false,
      //type: FileType.image,
      //allowedExtensions: ['jpg', 'png', 'jpeg', 'bmp']
    );
  }

  if (result != null) {
    if (!kIsWeb){
      return result.files.single.path.toString();
    }
    if (kIsWeb){
      return result.files.first.bytes as Uint8List;
    }
  } else {
    // User canceled the picker
  }
}

Future<String> getTime(BuildContext context) async {
  TimeOfDay? _newTime=await showTimePicker(context: context,initialTime: TimeOfDay.now());
  if (_newTime!=null){
    String hour='${_newTime.hour}';
    String min='${_newTime.minute}';
    if (hour.length==1){
      hour='0'+hour;
    }
    if (min.length==1){
      min='0'+min;
    }
    return hour+':'+min;
  }
  return '';
}

Future<String> getDate(BuildContext context) async {
  DateTime? _newDate=await showDatePicker(context: context, initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime(3000));
  if (_newDate!=null){
    return '${_newDate.year}-${_newDate.month}-${_newDate.day}';
  }
  return '';
}
