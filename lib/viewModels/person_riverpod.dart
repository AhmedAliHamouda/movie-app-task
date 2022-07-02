import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app_task/helpers/connection_helper.dart';
import 'package:movies_app_task/helpers/db_helper.dart';
import 'package:movies_app_task/models/person_detail_model.dart';
import 'package:movies_app_task/models/person_images_model.dart';
import 'package:movies_app_task/models/popular_people_model.dart';
import 'package:movies_app_task/repo/person_repository.dart';
import 'package:gallery_saver/gallery_saver.dart';

final personRiverPod = ChangeNotifierProvider<PersonRiverPod>((ref) => PersonRiverPod());

class PersonRiverPod extends ChangeNotifier {
  ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();

  bool _loading = true;

  bool get loading => _loading;

  set loading(bool val) {
    _loading = val;
    notifyListeners();
  }

  bool _loadingByPage = false;

  bool get loadingByPage => _loadingByPage;

  set loadingByPage(bool val) {
    _loadingByPage = val;
    notifyListeners();
  }

  bool _loadingPersonDetail = false;

  bool get loadingPersonDetail => _loadingPersonDetail;

  set loadingPersonDetail(bool val) {
    _loadingPersonDetail = val;
    notifyListeners();
  }

  bool _loadingPersonImages = false;

  bool get loadingPersonImages => _loadingPersonImages;

  set loadingPersonImages(bool val) {
    _loadingPersonImages = val;
    notifyListeners();
  }

  bool _loadingPersonData = true;

  bool get loadingPersonData => _loadingPersonData;

  set loadingPersonData(bool val) {
    _loadingPersonData = val;
    notifyListeners();
  }

  bool _loadingSaveImage= false;

  bool get loadingSaveImage => _loadingSaveImage;

  set loadingSaveImage(bool val) {
    _loadingSaveImage = val;
    notifyListeners();
  }

  List<Results>? listActors = [];

  PersonDetailModel? personDetailModel;
  PersonImagesModel? personImagesModel;

  Future<void> getPopularPeopleData(int page) async {
    loading = true;

    final responseStatus= await connectionStatus.getConnectionStatus();
    print('our Status NetWork: $responseStatus');
    if(responseStatus){
      final response = await PersonsRepository.getPopularPeople(page);
      if (response != null) {
        listActors = response.results;
        loading=false;
        await DBHelper.clearData('actors_data');
        _addActorsToDataBase(response.results!);
      }
    }else{
      final dbResponse=await DBHelper.getData('actors_data');
      dbResponse.forEach((element) {
        listActors!.add(Results.fromJson(element));
      });
    }
    loading = false;
  }
  Future<void> getPopularPeopleDataByPage(int page) async {
    loadingByPage = true;
    final response = await PersonsRepository.getPopularPeople(page);
    if (response != null) {
      listActors!.addAll(response.results!);
      loadingByPage = false;
      _addActorsToDataBase(response.results!);
    } else {
      loadingByPage = false;
    }
  }

  Future<void> getPersonDetail(int personId) async {
    loadingPersonDetail = true;
    final response = await PersonsRepository.getPersonDetail(personId);
    if (response != null) {
      personDetailModel = response;
      loadingPersonDetail = false;
    } else {
      personDetailModel=null;
      loadingPersonDetail = false;
    }
  }

  Future<void> getPersonImages(int personId) async {
    loadingPersonImages = true;
    final response = await PersonsRepository.getPersonImages(personId);
    if (response != null) {
      personImagesModel = response;
      loadingPersonImages = false;
    } else {
      loadingPersonImages = false;
    }
  }

  Future<void> getPersonData(int personId) async {
    loadingPersonData = true;
    await getPersonDetail(personId);
    await getPersonImages(personId);
    loadingPersonData = false;
  }

  Future<bool> saveImageToGallery(String imagePath) async {
    loadingSaveImage=true;
    final response = await GallerySaver.saveImage(imagePath);
    loadingSaveImage=false;
    return response??false;
  }

  void _addActorsToDataBase(List<Results> list){
    list.forEach((element) async{
      await DBHelper.insert(table: 'actors_data', data: {
        "id":element.id,
        "known_for_department":element.knownForDepartment,
        "name":element.name,
        "profile_path":element.profilePath,
      });
    });
  }
}
