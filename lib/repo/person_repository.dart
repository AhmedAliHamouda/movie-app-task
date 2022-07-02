import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:movies_app_task/models/person_detail_model.dart';
import 'package:movies_app_task/models/person_images_model.dart';
import 'package:movies_app_task/models/popular_people_model.dart';
import 'package:movies_app_task/network/service_urls.dart';

class PersonsRepository {
  static Map<String, String> headers() {
    Map<String, String> headerMap = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    return headerMap;
  }


  static  Future<PersonImagesModel?> getPersonImages(int personId)async{
    var params = {
      'api_key': ServicesURLs.apiKey,
    };
    final uri=Uri.parse(ServicesURLs.personUrl+'/$personId/images').replace(queryParameters: params);
    try {
      final response = await http.get(uri, headers: headers(),);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final finalResponse = jsonDecode(response.body) as Map<String,dynamic>;
        log(finalResponse.toString());
        return PersonImagesModel.fromJson(finalResponse);
      } else {
        print('response code${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('error ${error.toString()}');
      return null;
    }

  }



  static  Future<PersonDetailModel?> getPersonDetail(int personId)async{

    var params = {
      'api_key': ServicesURLs.apiKey,
    };
    final uri=Uri.parse(ServicesURLs.personUrl+'/$personId').replace(queryParameters: params);
    try {
      final response = await http.get(uri, headers: headers(),);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final finalResponse = jsonDecode(response.body) as Map<String,dynamic>;
        log(finalResponse.toString());
        return PersonDetailModel.fromJson(finalResponse);
      } else {
        print('response code${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('error ${error.toString()}');
      return null;
    }

  }

  static Future<PopularPeopleModel?> getPopularPeople(int page) async {
    var params = {
      'api_key': ServicesURLs.apiKey,
      'page':page.toString(),
    };
    final uri=Uri.parse(ServicesURLs.popularPeopleUrl).replace(queryParameters: params);
    try {
      final response = await http.get(uri, headers: headers(),);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final finalResponse = jsonDecode(response.body) as Map<String,dynamic>;
        log(finalResponse.toString());
        return PopularPeopleModel.fromJson(finalResponse);
      } else {
        print('response code${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('error ${error.toString()}');
      return null;
    }
  }

}
