import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_kazee5/login_splash.dart';
import 'package:flutter_app_kazee5/utils/color.dart';
import 'package:flutter_app_kazee5/utils/value.dart';
import 'CustomDialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
class edit_profile extends StatefulWidget {
  @override
  _edit_profile createState() => _edit_profile();
}
class _edit_profile extends State<edit_profile> {
  String formstep_url="http://36.37.120.131/iam-mobile/api/influencer/form-step";
  String kota_url="http://36.37.120.131/iam-mobile/api/influencer/get-kota";
  var currentSelectedcity;
  int currentSelectedcity_id;
  var currentSelectedprovinsi;
  int currentSelectedprovinsi_id;
  var currentSelectedreligion;
  var currentSelectedgender;

  _edit_profile(){
    full_nameFilter.addListener(full_nameListen);
    no_handphoneFilter.addListener(no_handphoneListen);
    id_provinsiFilter.addListener(id_provinsiListen);
    id_kotaFilter.addListener(id_kotaListen);
    addressFilter.addListener(addressListen);
    workFilter.addListener(workListen);
    emailFilter.addListener(emailListen);
    genderFilter.addListener(genderLiisten);
  }
  final TextEditingController full_nameFilter = new TextEditingController();
  String full_name = "";
  void full_nameListen() {
    if (full_nameFilter.text.isEmpty) {
      full_name = "";
    } else {
      full_name = full_nameFilter.text;
    }
  }
  final TextEditingController addressFilter = new TextEditingController();
  String address = "";
  void addressListen() {
    if (addressFilter.text.isEmpty) {
      address = "";
    } else {
      address = addressFilter.text;
    }
  }
  final TextEditingController workFilter = new TextEditingController();
  String work = "";
  void workListen() {
    if (full_nameFilter.text.isEmpty) {
      work = "";
    } else {
      work = workFilter.text;
    }
  }
  final TextEditingController emailFilter = new TextEditingController();
  String email="";
  void emailListen() {
    if (emailFilter.text.isEmpty) {
      email = "";
    } else {
      email = emailFilter.text;
    }
  }
  final TextEditingController no_handphoneFilter = new TextEditingController();
  String no_handphone = "";
  void no_handphoneListen() {
    if (no_handphoneFilter.text.isEmpty) {
      no_handphone = "";
    } else {
      no_handphone = no_handphoneFilter.text;
    }
  }
  final TextEditingController id_provinsiFilter = new TextEditingController();
  String id_provinsi = "";
  void id_provinsiListen() {
    if (id_provinsiFilter.text.isEmpty) {
      id_provinsi = "";
    } else {
      id_provinsi = id_provinsiFilter.text;
    }
  }
  final TextEditingController id_kotaFilter = new TextEditingController();
  String id_kota = "";
  void id_kotaListen() {
    if (id_kotaFilter.text.isEmpty) {
      id_kota = "";
    } else {
      id_kota = id_kotaFilter.text;
    }
  }
  final TextEditingController genderFilter = new TextEditingController();
  String id_gender = "";
  void genderLiisten() {
    if (genderFilter.text.isEmpty) {
      id_gender= "";
    } else {
      id_gender = genderFilter.text;
    }
  }
  final TextEditingController religionFilter = new TextEditingController();
  String current_religion = "";
  void religionLiisten() {
    if (religionFilter.text.isEmpty) {
      current_religion= "";
    } else {
      current_religion = religionFilter.text;
    }
  }





  void initState(){
    super.initState();
  }

  Future<String> getJsonData_kota(String url,int id_provinsi) async {
    http.post(Uri.encodeFull(url), body: {
      "id_provinsi":id_provinsi.toString(),
    }).then((response) {
      if(response.statusCode==200){  var convertDataToJson = jsonDecode(response.body);
      data_kota = convertDataToJson['data'];}
      for(int i=0;i<data_kota.length;i++){kota.add(data_kota[i]['name']);}

    });
    return "Success";
  }
  final _formKey = GlobalKey<FormState>();
  bool _validate = false;
  String validateFullname(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "* Full name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "* Full name must be a-z and A-Z";
    }
    return null;
  }
  String validatework(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "* Workplace,school or university are Required";
    } else if (!regExp.hasMatch(value)) {
      return "* Workplace,school or university must be a-z and A-Z";
    }
    return null;
  }

  String validateemail(String value) {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    if (value.length == 0) {
      return "* Username is Required";
    }else{
      if(regExp.hasMatch(value)){
        return "*Email type invalid.";
      }
    }
    return null;
  }
  String validateHandphone_number(String value) {
    if (value.length == 0) {
      return "* Handphone number is Required";
    }
    return null;
  }
  String validategender(String value) {
    if (currentSelectedgender==null ) {
      return "      * Gender is Required";
    }
    return null;
  }
  String validateaddress(String value) {
    if (value.length==0 ) {
      return "* Current address location is Required";
    }
    return null;
  }
  String validatereligion(String value) {
    if ((currentSelectedreligion==null)) {
      return "      * Religion is Required";
    }
    return null;
  }
  String validateProvinsi_city(String value) {
    if ((currentSelectedprovinsi==null) | (currentSelectedcity==null)) {
      return "       * Province and city are Required";
    }
    return null;
  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const Color red = Color(0xFFef5642);
    const Color light_red = Color(0xFFf23367);
    const Color light_white = Color(0xFFf7c8b6);
    const Color text_color = Color(0xFFfbd5d6);
    const Color blue = Color(0xFF0035b3);
    const Color next = Color(0xFF674575);
    const Color checkbox_white = Color(0xFFffffff);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:Text("Edit Profile",style:TextStyle(fontWeight:FontWeight.bold,fontSize: size.width/22)),
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: kLinearGradient),
          ),
          actions: [
          ],
        ),
        body: Form(
          key: _formKey,
          autovalidate: _validate,
          child: Center(
              child:Container(
                width: size.width,height: size.height,

                child:  ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    SizedBox(height: size.height/20),
                    Row( children:[SizedBox(width: size.width/10),Text("Nama Lengkap",style: TextStyle(fontStyle: FontStyle.normal,fontSize: size.height/50, color: Colors.black87),), ]),
                    Container(
                      height:  50,
                      margin:EdgeInsets.only(top: size.height/60, left: size.width/10, right:size.width/10,),
                      child: TextFormField(
                        validator: validateFullname,
                        autovalidate: _validate,
                        controller: full_nameFilter,
                        style: TextStyle(fontSize: size.height/45, color: Colors.black54),
                        cursorColor: Colors.black54,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            errorStyle: TextStyle(color: Colors.red),
                            filled: true,
                            fillColor: Colors.black12,
                            contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8, top: 8),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),)

                        ),

                      ),
                    ),

                    SizedBox(height: size.height/70),
                    Row( children:[SizedBox(width: size.width/10),Text("Jenis Kelamin",style: TextStyle(fontStyle: FontStyle.normal,fontSize: size.height/50, color: Colors.black87),), ]),
                    Container(
                      margin: EdgeInsets.only(top: size.height/60,left: size.width/10,right: size.width/10),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                contentPadding:const EdgeInsets.only(left: 14.0),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10.0))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: currentSelectedgender,
                                isDense: true,
                                onChanged: (newValue) {
                                  setState(() {
                                    currentSelectedgender=newValue;
                                  });
                                },
                                items: gender.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,style: TextStyle(fontStyle: FontStyle.normal,fontSize: 12, color: Colors.black54)),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(height: size.height/40,
                      margin:EdgeInsets.only(top: size.height/60, left: size.width/10, right:size.width/10,),
                      child: TextFormField(
                        validator: validategender,
                        autovalidate: _validate,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorStyle: TextStyle(color: Colors.red,fontSize: 11)
                        ),
                      ),),

                    SizedBox(height: size.height/70),
                    Row( children:[SizedBox(width: size.width/10),Text("Email",style: TextStyle(fontStyle: FontStyle.normal,fontSize: size.height/50, color: Colors.black87),), ]),
                    Container(
                      height: size.height/15,
                      margin:EdgeInsets.only(top: size.height/60, left: size.width/10, right:size.width/10,),
                      child: TextFormField(
                        validator: validateemail,
                        autovalidate: _validate,
                        controller: emailFilter,
                        autofocus: false,
                        style: TextStyle(fontSize: size.height/45, color: Colors.black54),
                        cursorColor: Colors.black54,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            errorStyle: TextStyle(color: Colors.red),
                            filled: true,
                            fillColor: Colors.black12,
                            contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8, top: 8),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),)

                        ),
                      ),
                    ),

                    SizedBox(height: size.height/70),
                    Row( children:[SizedBox(width: size.width/10),Text("No Handphone",style: TextStyle(fontStyle: FontStyle.normal,fontSize: size.height/50, color: Colors.black87),), ]),
                    Container(
                      height: size.height/15,
                      margin:EdgeInsets.only(top: size.height/60, left: size.width/10, right:size.width/10,),
                      child: TextFormField(
                        validator: validateHandphone_number,
                        autovalidate: _validate,
                        controller: no_handphoneFilter,
                        autofocus: false,
                        style: TextStyle(fontSize: size.height/45, color: Colors.black54),
                        cursorColor: Colors.black54,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            errorStyle: TextStyle(color: Colors.red),
                            filled: true,
                            fillColor: Colors.black12,
                            contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8, top: 8),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),)

                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),

                    SizedBox(height: size.height/70),
                    Row( children:[SizedBox(width: size.width/10),Text("Tempat kerja/Sekolah/Universitas",style: TextStyle(fontStyle: FontStyle.normal,fontSize: size.height/50, color: Colors.black87),), ]),
                    Container(
                      height:  50,
                      margin:EdgeInsets.only(top: size.height/60, left: size.width/10, right:size.width/10,),
                      child: TextFormField(
                        validator: validatework,
                        autovalidate: _validate,
                        controller: workFilter,
                        style: TextStyle(fontSize: size.height/45, color: Colors.black54),
                        cursorColor: Colors.black54,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            errorStyle: TextStyle(color: Colors.red),
                            filled: true,
                            fillColor: Colors.black12,
                            contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8, top: 8),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),)

                        ),

                      ),
                    ),

                    SizedBox(height: size.height/70),
                    Row( children:[SizedBox(width: size.width/10),Text("Agama",style: TextStyle(fontStyle: FontStyle.normal,fontSize: size.height/50, color: Colors.black87),), ]),
                    Container(
                      margin: EdgeInsets.only(top: size.height/60,left: size.width/10,right: size.width/10),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                contentPadding:const EdgeInsets.only(left: 14.0),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10.0))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: currentSelectedreligion,
                                isDense: true,
                                onChanged: (newValue) {
                                  setState(() {
                                    currentSelectedreligion=newValue;
                                  });
                                },
                                items: religion.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,style: TextStyle(fontStyle: FontStyle.normal,fontSize: 12, color: Colors.black54)),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(height: size.height/40,
                      margin:EdgeInsets.only(top: size.height/60, left: size.width/10, right:size.width/10,),
                      child: TextFormField(
                        validator: validatereligion,
                        autovalidate: _validate,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorStyle: TextStyle(color: Colors.red,fontSize: 11)
                        ),
                      ),),

                    SizedBox(height: size.height/70),
                    Row( children:[SizedBox(width: size.width/10),Text("Provinsi",style: TextStyle(fontStyle: FontStyle.normal,fontSize: size.height/50, color: Colors.black87),), ]),
                    SizedBox(height: size.height/60),
                    Container(
                      margin: EdgeInsets.only(left: size.width/10,right: size.width/10),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                contentPadding:const EdgeInsets.only(left: 14.0),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10.0))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text("Pilih Provinsi",style: TextStyle(fontSize:14,fontStyle: FontStyle.normal, color: Colors.white)),
                                value: currentSelectedprovinsi,
                                isDense: true,
                                onChanged: (newValue) {
                                  setState(() {
                                    currentSelectedprovinsi=newValue;
                                    currentSelectedprovinsi_id=int.parse(data_provinsi[provinsi.indexOf(currentSelectedprovinsi)]['id_provinsi']);
                                    currentSelectedcity=null;
                                    getJsonData_kota(kota_url,currentSelectedprovinsi_id);
                                  });
                                },
                                items: provinsi.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,style: TextStyle(fontStyle: FontStyle.normal,fontSize: 12, color: Colors.black54)),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: size.height/50),
                    Row( children:[SizedBox(width: size.width/10),Text("Kota",style: TextStyle(fontStyle: FontStyle.normal,fontSize: size.height/50, color: Colors.black87),), ]),
                    SizedBox(height: size.height/60),
                    Container(
                      margin: EdgeInsets.only(left: size.width/10,right: size.width/10),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                contentPadding:const EdgeInsets.only(left: 14.0),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10.0))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text("Pilih Kota",style: TextStyle(fontSize: 14,fontStyle: FontStyle.normal, color: Colors.white)),
                                value: currentSelectedcity,
                                isDense: true,
                                onChanged: (newValue) {
                                  setState(() {
                                    currentSelectedcity= newValue;
                                    currentSelectedcity_id=kota.indexOf(newValue);
                                  });
                                },
                                items: kota.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value:value,
                                    child: Text(value,style: TextStyle(fontStyle: FontStyle.normal,fontSize: 12, color: Colors.black54)),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(height: size.height/40,
                      margin:EdgeInsets.only(top: size.height/60, left: size.width/10, right:size.width/10,),
                      child: TextFormField(
                        validator: validateProvinsi_city,
                        autovalidate: _validate,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorStyle: TextStyle(color: Colors.red,fontSize: 11)
                        ),
                      ),),

                    SizedBox(height: size.height/70),
                    Row( children:[SizedBox(width: size.width/10),Text("Alamat & Lokasi Sekarang",style: TextStyle(fontStyle: FontStyle.normal,fontSize: size.height/50, color: Colors.black87),), ]),
                    Container(
                      height:  50,
                      margin:EdgeInsets.only(top: size.height/60, left: size.width/10, right:size.width/10,),
                      child: TextFormField(
                        validator: validateaddress,
                        autovalidate: _validate,
                        controller: addressFilter,
                        style: TextStyle(fontSize: size.height/45, color: Colors.black54),
                        cursorColor: Colors.black54,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            errorStyle: TextStyle(color: Colors.red),
                            filled: true,
                            fillColor: Colors.black12,
                            contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8, top: 8),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),)

                        ),

                      ),
                    ),


                    SizedBox(height: size.height/30),
                    Row(
                      children: [
                        SizedBox(width: size.width/3),
                        InkWell(onTap: () {
                          if (_formKey.currentState.validate()) {


                          }

                        }, child: Container(
                          height: 40,
                          width: 120,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: pink_red,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(100.0))),
                          child: Text(
                            "Simpan",
                            style: TextStyle(
                                color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
                          ),
                        ),),
                      ],
                    ),


                    SizedBox(height: size.height/20),
                  ],
                ),
              )
          ),
        )
    );

  }
}