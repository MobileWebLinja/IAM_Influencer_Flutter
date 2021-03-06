// import 'package:flutter/material.dart';
// import 'package:flutter_app_kazee5/utils/color.dart';
// import 'dart:io';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
//
// class submit_content extends StatefulWidget {
//   submit_content() : super();
//
//   final String title = "Upload Image Demo";
//
//   @override
//   _submit_content createState() => _submit_content();
// }
//
// class _submit_content extends State<submit_content> with AutomaticKeepAliveClientMixin<submit_content> {
//   @override
//   bool get wantKeepAlive => true;
//   static final String uploadEndPoint =
//       'http://localhost/flutter_test/upload_image.php';
//   Future<File> file;
//   String status = '';
//   String base64Image;
//   File tmpFile;
//   String errMessage = 'Error Uploading Image';
//
//   chooseImage() {
//     setState(() {
//       file = ImagePicker.pickImage(source: ImageSource.gallery);
//     });
//     setStatus('');
//   }
//
//   setStatus(String message) {
//     setState(() {
//       status = message;
//     });
//   }
//
//   startUpload() {
//     setStatus('Uploading Image...');
//     if (null == tmpFile) {
//       setStatus(errMessage);
//       return;
//     }
//     String fileName = tmpFile.path.split('/').last;
//     upload(fileName);
//   }
//
//   upload(String fileName) {
//     http.post(uploadEndPoint, body: {
//       "image": base64Image,
//       "name": fileName,
//     }).then((result) {
//       setStatus(result.statusCode == 200 ? result.body : errMessage);
//     }).catchError((error) {
//       setStatus(error);
//     });
//   }
//
//   Widget showImage() {
//     return FutureBuilder<File>(
//       future: file,
//       builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
//         if (snapshot.connectionState == ConnectionState.done &&
//             null != snapshot.data) {
//           tmpFile = snapshot.data;
//           base64Image = base64Encode(snapshot.data.readAsBytesSync());
//           return Flexible(
//             child: Image.file(
//               snapshot.data,
//               fit: BoxFit.fill,
//             ),
//           );
//         } else if (null != snapshot.error) {
//           return const Text(
//             'Error Picking Image',
//             textAlign: TextAlign.center,
//           );
//         } else {
//           return const Text(
//             'No Image Selected',
//             textAlign: TextAlign.center,
//           );
//         }
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar:  AppBar(
//           centerTitle: true,
//           title:Text("Submit Content",style:TextStyle(fontWeight:FontWeight.bold,fontSize: size.width/22)),
//           flexibleSpace: Container(
//             decoration: BoxDecoration(gradient: kLinearGradient),
//           ),
//           actions: [
//           ],
//         ),
//       body: Container(
//         padding: EdgeInsets.all(30.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             OutlineButton(
//               onPressed: chooseImage,
//               child: Text('Choose Image'),
//             ),
//             SizedBox(
//               height: 20.0,
//             ),
//             showImage(),
//             SizedBox(
//               height: 20.0,
//             ),
//             OutlineButton(
//               onPressed: startUpload,
//               child: Text('Upload Image'),
//             ),
//             SizedBox(
//               height: 20.0,
//             ),
//             Text(
//               status,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.green,
//                 fontWeight: FontWeight.w500,
//                 fontSize: 20.0,
//               ),
//             ),
//             SizedBox(
//               height: 20.0,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }