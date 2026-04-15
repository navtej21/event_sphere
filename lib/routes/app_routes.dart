import 'package:get/get.dart';

import '../modules/auth/auth_binding.dart';
import '../modules/auth/login_view.dart';
import '../modules/booking/booking_binding.dart';
import '../modules/booking/booking_view.dart';
import '../modules/events/event_binding.dart';
import '../modules/events/event_detail_view.dart';
import '../modules/events/event_list_view.dart';

class Routes {
  static const login = '/login';
  static const events = '/events';
  static const eventDetail = '/event-detail';
  static const bookings = '/bookings';
}

class AppRoutes {
  static final pages = <GetPage>[
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.events,
      page: () => const EventListView(),
      bindings: [EventBinding(), BookingBinding()],
    ),
    GetPage(
      name: Routes.eventDetail,
      page: () => const EventDetailView(),
      bindings: [EventBinding(), BookingBinding()],
    ),
    GetPage(
      name: Routes.bookings,
      page: () => const BookingView(),
      binding: BookingBinding(),
    ),
  ];
}
