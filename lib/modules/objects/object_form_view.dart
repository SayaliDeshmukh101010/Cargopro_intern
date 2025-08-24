import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cargopro_intern_app/data/models/object_model.dart';
import 'package:cargopro_intern_app/controllers/object_controller.dart';

class ObjectFormView extends StatefulWidget {
  @override
  _ObjectFormViewState createState() => _ObjectFormViewState();
}

class _ObjectFormViewState extends State<ObjectFormView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dataController = TextEditingController();
  final ObjectController objectController = Get.find<ObjectController>();
  ApiObject? _editingObject;

  @override
  void initState() {
    super.initState();
    _editingObject = Get.arguments as ApiObject?;
    if (_editingObject != null) {
      _nameController.text = _editingObject!.name ?? '';
      _dataController.text = _editingObject!.data != null 
          ? _formatJson(_editingObject!.data!) 
          : '{}';
    } else {
      _dataController.text = '{}';
    }
  }

  String _formatJson(Map<String, dynamic> json) {
    return const JsonEncoder.withIndent('  ').convert(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editingObject != null ? 'Edit Object' : 'Create Object'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Expanded(
                child: TextFormField(
                  controller: _dataController,
                  decoration: InputDecoration(
                    labelText: 'Data (JSON)',
                    alignLabelWithHint: true,
                  ),
                  maxLines: null,
                  expands: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter JSON data';
                    }
                    try {
                      json.decode(value);
                    } catch (e) {
                      return 'Invalid JSON format';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 16),
              Obx(() {
                if (objectController.isLoading.value) {
                  return CircularProgressIndicator();
                }
                return ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _saveObject();
                    }
                  },
                  child: Text(_editingObject != null ? 'Update' : 'Create'),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _saveObject() {
    try {
      final name = _nameController.text;
      final data = json.decode(_dataController.text) as Map<String, dynamic>;
      
      final object = ApiObject(
        id: _editingObject?.id ?? '',
        name: name,
        data: data,
      );
      
      if (_editingObject != null) {
        objectController.updateObject(_editingObject!.id, object);
      } else {
        objectController.createObject(object);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to save object: $e');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dataController.dispose();
    super.dispose();
  }
}