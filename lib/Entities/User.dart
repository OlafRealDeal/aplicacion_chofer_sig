class User{
  String id='';
  String name='';
  String email='';
  String password='';
  String token='';

  //User({required this.id,required this.name,required this.email,required this.token});
  
  Map toMapUpdate(){
    return {'id':this.id,'name':this.name,'email':this.email,'password':this.password};
  }

}