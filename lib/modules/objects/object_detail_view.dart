import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cargopro_intern_app/data/models/object_model.dart';

class ObjectDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ApiObject object = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(object.name ?? 'Object Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Get.toNamed('/object_form', arguments: object),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${object.id}', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Name: ${object.name ?? "N/A"}'),
            SizedBox(height: 8),
            Text('Data:', style: TextStyle(fontWeight: FontWeight.bold)),
            if (object.data != null)
              ...object.data!.entries.map((entry) => 
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text('${entry.key}: ${entry.value}'),
                )
              ).toList(),
          ],
        ),
      ),
    );
  }
}