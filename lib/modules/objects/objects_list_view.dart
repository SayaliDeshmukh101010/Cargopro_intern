import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cargopro_intern_app/data/models/object_model.dart';
import 'package:cargopro_intern_app/controllers/object_controller.dart';

class ObjectsListView extends StatelessWidget {
  final ObjectController objectController = Get.put(ObjectController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Objects List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Get.toNamed('/object_form'),
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Add logout functionality here
              Get.offAllNamed('/login');
            },
          ),
        ],
      ),
      body: Obx(() {
        if (objectController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        
        return RefreshIndicator(
          onRefresh: () => objectController.fetchObjects(),
          child: ListView.builder(
            itemCount: objectController.objects.length,
            itemBuilder: (context, index) {
              ApiObject object = objectController.objects[index];
              return ListTile(
                title: Text(object.name ?? 'No Name'),
                subtitle: Text(object.id),
                onTap: () {
                  Get.toNamed('/object_detail', arguments: object);
                },
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _showDeleteDialog(object.id),
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/object_form'),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showDeleteDialog(String id) {
    Get.defaultDialog(
      title: 'Delete Object',
      content: Text('Are you sure you want to delete this object?'),
      confirm: ElevatedButton(
        onPressed: () {
          objectController.deleteObject(id);
          Get.back();
        },
        child: Text('Yes'),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: Text('No'),
      ),
    );
  }
}