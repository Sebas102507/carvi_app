import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class CarviApi{

  final String mainPath="http://192.168.20.27:9010";



  testCommunication()async{
    var url = Uri.parse("${mainPath}/carvi-ai/sayHi/");
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

  }

  Future<dynamic> getCarModel(File image) async {
    print("GETTING MODEL");
    var url = Uri.parse("${mainPath}/carvi-ai/getCarModel/");
    var request = http.MultipartRequest('POST', url);

    print(request);

    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        image.path,
        contentType: MediaType('image', 'jpeg'),
      ),
    );

    var response = await request.send();

    print(response.statusCode);

    if (response.statusCode == 200) {
      // File uploaded successfully
      var responseBody = await response.stream.bytesToString();
      //print('Response body: ${responseBody}');
      // Parse the response JSON if needed
      var jsonResponse = json.decode(responseBody);
      // Handle the JSON data accordingly

      // Decode the base64 string to a Uint8List
      Uint8List decodedImage = base64Decode(jsonResponse["seg_image"]);


      return jsonResponse;


    } else {
      // Error occurred while uploading the file
      print('Error uploading file');
    }
  }


}