import 'dart:io';

import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class AjaxCall {
  static AjaxCall ajaxCall;
  String _baseUrl;

  static get getInstance {
    if (ajaxCall == null) {
      ajaxCall = AjaxCall._internal();
    }

    return ajaxCall;
  }

  get getBaseUrl {
    if (!Configuration.isDoctor)
      _baseUrl = "http://iseniorcare1.healthygx.com/api/";
    else
      _baseUrl = "http://imobicloud1.healthygx.com/api/";
    return _baseUrl;
  }

  AjaxCall._internal();

  Map<String, String> postHeader() {
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      //'Authorization': '<Your token>'
    };
  }

  Future<dynamic> post(String url, dynamic data) async {
    print('Url: ${this.getBaseUrl}, Request: ${json.encode(data)}');
    try {
      http.Response response = await http.post(this.getBaseUrl + url,
          headers: this.postHeader(), body: json.encode(data));
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Response: ${response.body}');
        return response.body;
      } else {
        print('Post request failed.');
        return null;
      }
    } catch (e) {
      print('Post request failed. $e');
      return null;
    }
  }

  Widget getImage(String imageUrl) {
    Image image = Image.asset("assets/img/noun_Doctor_1880476.svg");
    try {
      image = Image.network(imageUrl);
      final ImageStream stream = image.image.resolve(ImageConfiguration.empty);

      stream.addListener(ImageStreamListener((info, call) {
        //you can also handle image loading
        //example: loading = false;//that's mean image is loaded
      }, onError: (dynamic exception, StackTrace stackTrace) {
        print('Image file not found.');
        image = Image.asset("assets/img/noun_Doctor_1880476.svg");
      }));
    } catch (e) {
      print('Fail to load image');
    }
    return image;
  }

  Future<String> get(String url) async {
    http.Response response = await http.get(this.getBaseUrl + url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Response: ${response.body}');
      return response.body;
    } else {
      print('Get request failed: $response');
      return null;
    }
  }

  Future<String> submit(File imageFile, String uri) async {
    print('Uri: $uri');
    var request =
        http.MultipartRequest('POST', Uri.parse(this.getBaseUrl + uri));
    request.fields['Id'] = '';
    request.files.add(
      await http.MultipartFile.fromPath('UploadedImage', imageFile.path),
    );
    var res = await request.send();
    print('Image status code: ${res.statusCode}');
    return res.reasonPhrase;
  }
}
