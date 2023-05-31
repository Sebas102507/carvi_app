import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:carvi/api/Carvi_Api.dart';
import 'package:carvi/constant/assetImages.dart';
import 'package:carvi/constant/own_icons_icons.dart';
import 'package:carvi/themes/colors.dart';
import 'package:carvi/ui/generic_widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import '../../constant/strings.dart';



class TakePictureScreen extends StatefulWidget {
  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  Future<void>? _initializeControllerFuture;
  double _currentZoom = 1.0;
  CarviApi carviApi=CarviApi();

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    availableCameras().then((cameras){
      print(cameras);
      setState(() {
        _controller = CameraController(
          cameras.first,
          ResolutionPreset.ultraHigh,
        );
        _controller.setFlashMode(FlashMode.off);
        _initializeControllerFuture = _controller.initialize();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFlash() async {
    if (!_controller.value.isInitialized) return;

    try {
      final newFlashMode = _controller.value.flashMode == FlashMode.off
          ? FlashMode.torch
          : FlashMode.off;
      await _controller.setFlashMode(newFlashMode);
    } catch (e) {
      print('Error toggling flash: $e');
    }
  }

  void _handleZoomUpdate(ScaleUpdateDetails details) {
    double zoom = _currentZoom * details.scale;
    // Define a sensitivity value to control the zoom speed
    double sensitivity = 0.15;
    // Calculate the new zoom level based on the details.scale value
    double newZoom = zoom.clamp(1.0, 5);
    // Adjust the zoom level incrementally based on the sensitivity
    double adjustedZoom = (_currentZoom + (newZoom - _currentZoom) * sensitivity)
        .clamp(1.0, 5);
    // Set the new zoom level to the camera controller
    _controller.setZoomLevel(adjustedZoom);
    // Update the current zoom level
    _currentZoom = adjustedZoom;
  }

  void _handleFocusPoint(Offset focalPoint) {
    if (!_controller.value.isInitialized) return;

    final x = focalPoint.dx / context.size!.width;
    final y = focalPoint.dy / context.size!.height;
    final focusPoint = Offset(x, y);
    setState(() {
      _controller.setFocusPoint(focusPoint);
    });
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return  _initializeControllerFuture==null?
            LoadingWidget()
                :
            FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Stack(
                    children: [
                      SizedBox(
                        width: size.width,
                        height: double.infinity,
                        child:  GestureDetector(
                          onScaleUpdate: (details) {
                            _handleZoomUpdate(details);
                          },
                          onTapDown: (details) {
                            _handleFocusPoint(details.localPosition);
                          },
                          child: CameraPreview(_controller),
                        ),
                      ),
                      const Center(
                        child: Icon(
                          Icons.control_point,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),

                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: size.width,
                            height: 100,
                            color: Colors.black12,
                            child: Align(
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: ()async{
                                  try {

                                    // Get the current phone orientation
                                    if (orientation == Orientation.portrait) {
                                      print("Is portrait");
                                      // Portrait orientation
                                      // Handle your logic for portrait orientation here
                                    } else {
                                      print("Is Landscape");
                                      // Landscape orientation
                                      // Handle your logic for landscape orientation here
                                    }



                                    await _initializeControllerFuture;

                                   final image = await _controller.takePicture();

                                    if (!mounted) return;

                                    confirmAddProduct(image);

                                    /*await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => DisplayPictureScreen(
                                        imagePath: image.path,
                                      ),
                                    ),
                                  );*/
                                  } catch (e) {
                                    print('Error taking picture: $e');
                                  }
                                },
                                child: const Icon(
                                  OwnIcons.radio_button_checked,
                                  color: lightRed,
                                  size: 80,
                                ),
                              ),
                            ),
                          )
                      ),

                      Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                              padding: const EdgeInsets.only(
                                  left: 15,
                                  right: 15
                              ),
                              width: size.width,
                              height: 60,
                              child: Row(
                                children: [
                                   Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: InkWell(
                                          child:  const Icon(
                                            Icons.arrow_back_ios_sharp,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                          onTap: (){
                                            Navigator.pop(context);
                                          },
                                        )
                                      )
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      //color: Colors.blue,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      //color: Colors.amber,
                                    ),
                                  )
                                ],
                              )
                          )
                      )

                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          },
        ),
      )
    );
  }


  void confirmAddProduct(XFile image) async{
    
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          insetPadding: const EdgeInsets.all(10),
          contentPadding: const EdgeInsets.all(0),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          content: Builder(
            builder: (context) {
              return findingCarCard(image);
            },
          ),
        );
      },
    );
  }

  Widget findingCarCard(XFile image){

    return Container(
      width: 300,
      height: 400,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: lightGrey,
          borderRadius: BorderRadius.all(Radius.circular(12.0))
      ),
      child: FutureBuilder<dynamic>(
          future: carviApi.getCarModel(File(image.path)),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(!snapshot.hasData || snapshot.hasError){
              return Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.cancel_outlined,
                          color: Colors.red,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Image.file(File(image.path)),
                            ),
                            Container(
                              color: lightGrey.withOpacity(0.7),
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 20
                                  ),
                                  width: 150,
                                  height: 150,
                                  child: RiveAnimation.asset(
                                    AssetImages.loadingAnimation,
                                  ),
                                )
                            )
                          ],
                        )
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.center,
                      child:  Text(
                          Strings.searchingCarText,
                          style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: mainBlue
                          )
                      ),
                    ),
                  )
                ],
              );
            }else{

              print("Receiving image");

              var jsonResponse = snapshot.data;

              print(jsonResponse["seg_image"].runtimeType);
              return Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.cancel_outlined,
                          color: Colors.red,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: 200,
                        height: 200,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Transform.rotate(
                                angle: 90 * 3.1415926535 / 180, // Rotate by -90 degrees (convert degrees to radians)
                                child: Image.memory(
                                  base64Decode(jsonResponse["seg_image"]),
                                ),
                              )
                            ),
                          ],
                        )
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 30
                      ),
                      child: Column(
                        children: [
                          carData("Modelo:", jsonResponse["model"]),
                          carData("Fabricante:", jsonResponse["make"]),
                          carData("Año", jsonResponse["year"].toString()),
                          carData("Tipo combustible:", jsonResponse["fuel_type"]),
                          carData("Cilindros:", jsonResponse["cylinders"].toString()),
                        ],
                      ),
                    )
                  )
                ],
              );
            }
          }
      )
    );

  }


  Widget carData(String title, String value){
    return  Padding(
      padding: const EdgeInsets.all(5),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                    title,
                    style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: lightRed
                    )
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                    value,
                    style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: mainBlue
                    )
                ),
              )
            ],
          )
      ),
    );
  }
  
  
}

