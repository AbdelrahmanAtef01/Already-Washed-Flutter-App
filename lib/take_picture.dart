import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/cubit/cubit.dart';
import '/order_photo_preview.dart';
import 'package:path_provider/path_provider.dart';
import 'constants.dart';
import 'cubit/state.dart';

File? imageFile;

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  bool _isCameraInitialized = false;
  final resolutionPresets = ResolutionPreset.values;
  ResolutionPreset currentResolutionPreset = ResolutionPreset.high;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _currentZoomLevel = 1.0;
  late int currentZoom = _currentZoomLevel.toInt();
  double _minAvailableExposureOffset = 0.0;
  double _maxAvailableExposureOffset = 0.0;
  double _currentExposureOffset = 0.0;
  FlashMode? _currentFlashMode;
  bool _isRearCameraSelected = true;


  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;
    // Instantiating the camera controller
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    // Dispose the previous controller
    await previousCameraController?.dispose();

    // Replace with the new controller
    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    // Initialize controller
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    // Update the Boolean
    if (mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }

    cameraController
        .getMaxZoomLevel()
        .then((value) => _maxAvailableZoom = value);

    cameraController
        .getMinZoomLevel()
        .then((value) => _minAvailableZoom = value);

    cameraController
        .getMinExposureOffset()
        .then((value) => _minAvailableExposureOffset = value);

    cameraController
        .getMaxExposureOffset()
        .then((value) => _maxAvailableExposureOffset = value);

    _currentFlashMode = controller!.value.flashMode;
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }
    try {
      XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      print('Error occured while taking picture: $e');
      return null;
    }
  }

  // To store the retrieved files
  List<File> allFileList = [];

  refreshAlreadyCapturedImages() async {
    // Get the directory
    final directory = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> fileList = await directory.list().toList();
    allFileList.clear();

    List<Map<int, dynamic>> fileNames = [];

    // Searching for all the image and video files using
    // their default format, and storing them
    fileList.forEach((file) {
      if (file.path.contains('.jpg')) {
        allFileList.add(File(file.path));

        String name = file.path.split('/').last.split('.').first;
        fileNames.add({0: int.parse(name), 1: file.path.split('/').last});
      }
    });

    // Retrieving the recent file
    if (fileNames.isNotEmpty) {
      final recentFile =
          fileNames.reduce((curr, next) => curr[0] > next[0] ? curr : next);
      String recentFileName = recentFile[1];
      imageFile = File('${directory.path}/$recentFileName');

      setState(() {});
    }
  }

  @override
  void initState() {
    // Hide the status bar
    SystemChrome.setEnabledSystemUIOverlays([]);

    onNewCameraSelected(cameras[0]);
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      onNewCameraSelected(cameraController.description);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: _isCameraInitialized
                ? Container(
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 1 / controller!.value.aspectRatio,
                          child: controller!.buildPreview(),
                        ),
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            color: Colors.white30,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: DropdownButton<ResolutionPreset>(
                                dropdownColor: Colors.white30,
                                underline: Container(),
                                value: currentResolutionPreset,
                                items: [
                                  for (ResolutionPreset preset
                                      in resolutionPresets)
                                    DropdownMenuItem(
                                      child: Text(
                                        preset
                                            .toString()
                                            .split('.')[1]
                                            .toUpperCase(),
                                        style: const TextStyle(color: Colors.black),
                                      ),
                                      value: preset,
                                    )
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    currentResolutionPreset = value!;
                                    _isCameraInitialized = false;
                                  });
                                  onNewCameraSelected(controller!.description);
                                },
                                hint: const Text("Select item"),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 15,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.zoom_in_outlined,
                                      color: Colors.white,
                                    ),
                                    Slider(
                                      value: _currentZoomLevel,
                                      min: _minAvailableZoom,
                                      max: _maxAvailableZoom,
                                      activeColor: Colors.white,
                                      inactiveColor: Colors.white30,
                                      onChanged: (value) async {
                                        setState(() {
                                          _currentZoomLevel = value;
                                          currentZoom = value.toInt();
                                        });
                                        await controller!.setZoomLevel(value);
                                      },
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '$currentZoom' + 'x',
                                          style: const TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        setState(() {
                                          _currentFlashMode = FlashMode.off;
                                        });
                                        await controller!.setFlashMode(
                                          FlashMode.off,
                                        );
                                      },
                                      child: Icon(
                                        Icons.flash_off,
                                        color:
                                            _currentFlashMode == FlashMode.off
                                                ? Colors.amber
                                                : Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        setState(() {
                                          _currentFlashMode = FlashMode.auto;
                                        });
                                        await controller!.setFlashMode(
                                          FlashMode.auto,
                                        );
                                      },
                                      child: Icon(
                                        Icons.flash_auto,
                                        color:
                                            _currentFlashMode == FlashMode.auto
                                                ? Colors.amber
                                                : Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        setState(() {
                                          _currentFlashMode = FlashMode.torch;
                                        });
                                        await controller!.setFlashMode(
                                          FlashMode.torch,
                                        );
                                      },
                                      child: Icon(
                                        Icons.highlight,
                                        color:
                                            _currentFlashMode == FlashMode.torch
                                                ? Colors.amber
                                                : Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    /*Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                        image: imageFile != null
                                            ? DecorationImage(
                                                image: FileImage(imageFile!),
                                                fit: BoxFit.cover,
                                              )
                                            : null,
                                      ),
                                    ),*/
                                    space60Horizontal(context),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          4.5,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        XFile? rawImage = await takePicture();
                                        File imageFile = File(rawImage!.path);
                                        refreshAlreadyCapturedImages();
                                        int currentUnix = DateTime.now()
                                            .millisecondsSinceEpoch;
                                        final directory =
                                            await getApplicationDocumentsDirectory();
                                        String fileFormat =
                                            imageFile.path.split('.').last;

                                        await imageFile.copy(
                                          '${directory.path}/$currentUnix.$fileFormat',
                                        );
                                        navigateTo(context, photoPreview());
                                      },
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          const Icon(Icons.circle,
                                              color: Colors.white38, size: 80),
                                          const Icon(Icons.circle,
                                              color: Colors.white, size: 65),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          4.5,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        setState(() {
                                          _isCameraInitialized = false;
                                        });
                                        onNewCameraSelected(
                                          cameras[
                                              _isRearCameraSelected ? 1 : 0],
                                        );
                                        setState(() {
                                          _isRearCameraSelected =
                                              !_isRearCameraSelected;
                                        });
                                      },
                                      child: Icon(
                                        Icons.flip_camera_ios_outlined,
                                        color: _currentFlashMode ==
                                                FlashMode.always
                                            ? Colors.amber
                                            : Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height / 3,
                          right: 10.0,
                          child: Column(
                            children: [
                              RotatedBox(
                                quarterTurns: 3,
                                child: Slider(
                                  value: _currentExposureOffset,
                                  min: _minAvailableExposureOffset,
                                  max: _maxAvailableExposureOffset,
                                  activeColor: Colors.white,
                                  inactiveColor: Colors.white30,
                                  onChanged: (value) async {
                                    setState(() {
                                      _currentExposureOffset = value;
                                    });
                                    await controller!.setExposureOffset(value);
                                  },
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _currentExposureOffset.toStringAsFixed(1) +
                                        'x',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
          );
        });
  }
}


class photoPreview extends StatefulWidget{
  @override
  _photoPreviewState createState() => _photoPreviewState();
}

class _photoPreviewState extends State<photoPreview> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Stack(
        children: [
             Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius:
                BorderRadius.circular(10.0),
                border: Border.all(
                    color: Colors.white, width: 2),
                image: imageFile != null
                    ? DecorationImage(
                  image: FileImage(imageFile!),
                  fit: BoxFit.cover,
                )
                    : null,
              ),
            ),
             Positioned(
            top: 10,
            left:10 ,
            child: Container(
              height:40 ,
              width:40 ,
              child: FloatingActionButton(
                  onPressed: (){navigateAndFinish(context, CameraScreen(),);},
                  backgroundColor: Colors.white30,
                  foregroundColor: Colors.black,
                child : const Icon(Icons.arrow_back_ios_new)
              ),
            ),
          ),
             Align(
            alignment: Alignment.bottomCenter,
                child:TextFormField(
                    controller:controller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).scaffoldBackgroundColor,
/*
                      prefixIcon: IconButton(icon:Icon(Icons.note_add_outlined),
                        onPressed: (){
                         AppBloc.get(context).images.add(imageFile!);
                         AppBloc.get(context).comments.add(controller.text);
                         Fluttertoast.showToast(msg: 'photo added successfully :)',backgroundColor: Colors.green);
                         navigateAndFinish(context, CameraScreen(),);
                         },),
*/
                      suffixIcon: IconButton(icon:const Icon(Icons.send,color: Colors.teal,),
                      onPressed: (){
                        AppBloc.get(context).images.add(imageFile!);
                        AppBloc.get(context).comments.add(controller.text);
                        Fluttertoast.showToast(msg: 'photo added successfully :)',backgroundColor: Colors.green);
                        navigateTo(context, const orderPhotoPreview(),);
                        },),
                      border : const OutlineInputBorder(),
                      hintText: 'Add Note...',
                    ),
                  ),

          ),

        ],
      ),


    );
  }
}
