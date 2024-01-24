import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:image_picker/image_picker.dart';

class TakePicture extends StatefulWidget {
  TakePicture({Key? key}) : super(key: key);

  @override
  State<TakePicture> createState() => _TakePictureState();
}

class _TakePictureState extends State<TakePicture> {
//   File? _image;

//   final imagePicker = ImagePicker();

//   Future getImage() async {
//     final image = await imagePicker.getImage(
//       source.ImageSource.camera
//     )
// setState(
//   (){
//     _image = File(image.path)
//   }
// )
//   }

  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   throw UnimplementedError();
  // }
  // end tutor 2
  late CameraController controller;
  Future<void> initialCamera() async {
    var camera = await availableCameras();
    controller = CameraController(camera.last, ResolutionPreset.max);
    await controller.initialize();
  }

  Future<File> takePicture() async {
    Directory root = await getTemporaryDirectory();
    String dirRoot = '${root.path}/Guide_Camera';
    await Directory(dirRoot).create(recursive: true);
    String filePath = '$dirRoot/${DateTime.now()}.jpg';
    print('take pic');
    print(filePath);
    try {
      await controller.takePicture();
    } catch (e) {
      // return;
    }

    var filePresent = await Directory(dirRoot).exists();
    if (filePresent) {
      print('file present');
    } else {
      print('file not present');
    }

    return File(filePath);
    // return filePath;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: initialCamera(),
        builder: (_, snapshot) =>
            (snapshot.connectionState == ConnectionState.done)
                ? Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height /
                                controller.value.aspectRatio,
                            child: CameraPreview(controller),
                          ),
                          Container(
                            width: 70,
                            height: 70,
                            margin: EdgeInsets.only(top: 50),
                            // child: RaisedButton(
                            //   onPressed: () async {
                            //     if (!controller.value.isTakingPicture) {
                            //       File result = await takePicture();
                            //       // print(result);
                            //       Navigator.pop(context, result);
                            //     }
                            //   },
                            //   shape: const CircleBorder(),
                            //   color: Colors.blue,
                            // ),
                          ),
                        ],
                      )
                    ],
                  )
                : Center(
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    ),
                  ),
      ),
    );
  }
}
