import 'package:event_sphere/models/event_model.dart';
import 'package:event_sphere/services/event_service.dart';
import 'package:event_sphere/services/favorite_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttenndeeFavoriteController extends GetxController{

  final isloading=true.obs;

  final favoriteEvents=<EventModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // TODO: implement onInit
    super.onInit();
    fetchFavoriteEvents();
  }


  Future<void> fetchFavoriteEvents() async{
    try{
      isloading.value=true;

      final result=await FavoriteService.getFavoriteEvents();
      favoriteEvents.assignAll(result ?? []);
    }
    catch(e)
    {
      Get.snackbar("error","something went wrong");
      
    }
    finally{
      isloading.value=false;
    }

    
  }



}