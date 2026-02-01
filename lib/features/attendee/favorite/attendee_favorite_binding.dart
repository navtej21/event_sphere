import 'package:event_sphere/features/attendee/favorite/attendee_favorite_controller.dart';
import 'package:get/get.dart';



class AttendeeFavoriteBinding extends Bindings{

  void dependencies(){
    Get.lazyPut<AttenndeeFavoriteController>(()=>AttenndeeFavoriteController());
  }
}

