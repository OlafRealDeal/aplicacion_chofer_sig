import 'package:aplicacion_chofer_sig/Data/DataResponse.dart';
import 'package:aplicacion_chofer_sig/Data/PhotoData.dart';
import 'package:aplicacion_chofer_sig/Entities/Photo.dart';
import 'package:aplicacion_chofer_sig/env.dart';
import 'package:aplicacion_chofer_sig/Session/UserSession.dart';


class PhotoBusiness{
  PhotoData photoData=new PhotoData();


  Future<DataResponse> index() async{
    String bus_id='';

    DataResponse dataResponse=await photoData.index(UserSession.user.token ,bus_id);
    return dataResponse;
  }

  Future<DataResponse> store(image,bus_id) async{
    Photo photo=new Photo();
    photo.image=image;
    photo.bus_id=bus_id;

    DataResponse dataResponse=await photoData.store(UserSession.user.token,photo);
    return dataResponse;
  }

  Future<DataResponse> update(Photo photo) async{
    DataResponse dataResponse=await photoData.update(UserSession.user.token,photo);
    return dataResponse;
  }

  Future<DataResponse> delete(String id) async{
    return await photoData.delete(UserSession.user.token,id);
  }


}