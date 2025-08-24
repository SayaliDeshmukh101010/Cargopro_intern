import 'package:cargopro_intern_app/modules/auth/login_view.dart';
import 'package:cargopro_intern_app/modules/objects/object_detail_view.dart';
import 'package:cargopro_intern_app/modules/objects/object_form_view.dart';
import 'package:cargopro_intern_app/modules/objects/objects_list_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => ObjectsListView(),
    ),
    GetPage(
      name: Routes.OBJECT_DETAIL,
      page: () => ObjectDetailView(),
    ),
    GetPage(
      name: Routes.OBJECT_FORM,
      page: () => ObjectFormView(),
    ),
  ];
}