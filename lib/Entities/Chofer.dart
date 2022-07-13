class Chofer{
  String id='';
  String ci='';
  String fecha_nacimiento='';
  String sexo='0';
  String telefono='';
  String categoria_licencia='';
  dynamic foto;
  String user_id='';


  //Chofer({constructor});

  Map toMapAll(){
    return {'id':this.id,'ci':this.ci,'fecha_nacimiento':this.fecha_nacimiento,'sexo':this.sexo,'telefono':this.telefono,'categoria_licencia':this.categoria_licencia,'foto':this.foto,'user_id':this.user_id};
  }

  Map toMapStore(){
    return {'ci':this.ci,'fecha_nacimiento':this.fecha_nacimiento,'sexo':this.sexo,'telefono':this.telefono,'categoria_licencia':this.categoria_licencia,'user_id':this.user_id};
  }

  Map toMapUpdate(){
    return {'id':this.id,'ci':this.ci,'fecha_nacimiento':this.fecha_nacimiento,'sexo':this.sexo,'telefono':this.telefono,'categoria_licencia':this.categoria_licencia,'user_id':this.user_id};
  }
}