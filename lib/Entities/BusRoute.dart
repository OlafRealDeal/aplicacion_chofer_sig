class BusRoute{
  String id='';
  String line='';


  //BusRoute({constructor});

  Map toMapAll(){
    return {'id':this.id,'line':this.line};
  }

  Map toMapStore(){
    return {'line':this.line};
  }

  Map toMapUpdate(){
    return {'id':this.id,'line':this.line};
  }
}