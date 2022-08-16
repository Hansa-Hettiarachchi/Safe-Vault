class Usermodel{
  String? uid;
  String? email;
  String? username;
  String? password;
  String? mobileNO;

  Usermodel({this.uid, this.email,this.username, this.password,this.mobileNO});

  //get data
  factory Usermodel.fromMap(map){
    return Usermodel(
      uid: map['uid'],
      email: map['email'],
      username: map['username'],
      password: map['password'],
      mobileNO: map['mobileNO'],
    );
  }

  //send data
  Map<String, dynamic> toMap(){
    return{
      'uid': uid,
      'email': email,
      'username': username,
      'password': password,
      'mobileNo': mobileNO,
    };
  }

}