class Bus{
  String id='';
  String placa='';
  String modelo='';
  String cantidad_asientos='';
  String fecha_asignacion='';
  String fecha_baja='';
  String numero_interno='';
  String esta_en_recorrido='0';
  String user_id='';
  String bus_route_id='';


  //Bus({constructor});

  Map toMapAll(){
    return {'id':this.id,'placa':this.placa,'modelo':this.modelo,'cantidad_asientos':this.cantidad_asientos,'fecha_asignacion':this.fecha_asignacion,'fecha_baja':this.fecha_baja,'numero_interno':this.numero_interno,'esta_en_recorrido':this.esta_en_recorrido,'user_id':this.user_id,'bus_route_id':this.bus_route_id};
  }

  Map toMapStore(){
    return {'placa':this.placa,'modelo':this.modelo,'cantidad_asientos':this.cantidad_asientos,'fecha_asignacion':this.fecha_asignacion,'fecha_baja':this.fecha_baja,'numero_interno':this.numero_interno,'esta_en_recorrido':this.esta_en_recorrido,'user_id':this.user_id,'bus_route_id':this.bus_route_id};
  }

  Map toMapUpdate(){
    return {'id':this.id,'placa':this.placa,'modelo':this.modelo,'cantidad_asientos':this.cantidad_asientos,'fecha_asignacion':this.fecha_asignacion,'fecha_baja':this.fecha_baja,'numero_interno':this.numero_interno,'esta_en_recorrido':this.esta_en_recorrido,'user_id':this.user_id,'bus_route_id':this.bus_route_id};
  }
}