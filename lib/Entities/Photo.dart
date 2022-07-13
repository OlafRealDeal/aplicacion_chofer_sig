class Photo{
  String id='';
  dynamic image;
  String bus_id='';


  //Photo({constructor});

  Map toMapAll(){
    return {'id':this.id,'image':this.image,'bus_id':this.bus_id};
  }

  Map toMapStore(){
    return {'bus_id':this.bus_id};
  }

  Map toMapUpdate(){
    return {'id':this.id,'bus_id':this.bus_id};
  }
}