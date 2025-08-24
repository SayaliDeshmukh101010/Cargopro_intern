import 'package:get/get.dart';
import 'package:cargopro_intern_app/data/models/object_model.dart';
import 'package:cargopro_intern_app/services/api_service.dart';

class ObjectController extends GetxController {
  var objects = <ApiObject>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchObjects();
  }

  Future<void> fetchObjects() async {
    try {
      isLoading.value = true;
      final fetchedObjects = await ApiService.getObjects();
      objects.assignAll(fetchedObjects);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch objects: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createObject(ApiObject object) async {
    try {
      isLoading.value = true;
      await ApiService.createObject(object);
      await fetchObjects(); // Refresh the list
      Get.back();
      Get.snackbar('Success', 'Object created successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to create object: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateObject(String id, ApiObject object) async {
    try {
      isLoading.value = true;
      await ApiService.updateObject(id, object);
      await fetchObjects(); // Refresh the list
      Get.back();
      Get.snackbar('Success', 'Object updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update object: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteObject(String id) async {
    try {
      isLoading.value = true;
      await ApiService.deleteObject(id);
      objects.removeWhere((obj) => obj.id == id);
      Get.snackbar('Success', 'Object deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete object: $e');
    } finally {
      isLoading.value = false;
    }
  }
}