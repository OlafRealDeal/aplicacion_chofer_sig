class ExitPoint{
  String id='';
  String lat='';
  String long='';
  String bus_route_id='';


  //ExitPoint({constructor});

  Map toMapAll(){
    return {'id':this.id,'lat':this.lat,'long':this.long,'bus_route_id':this.bus_route_id};
  }

  Map toMapStore(){
    return {'lat':this.lat,'long':this.long,'bus_route_id':this.bus_route_id};
  }

  Map toMapUpdate(){
    return {'id':this.id,'lat':this.lat,'long':this.long,'bus_route_id':this.bus_route_id};
  }
}