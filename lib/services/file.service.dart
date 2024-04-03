import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:texatube/utils/snackbar_util.dart';

class FileService {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController tagsController = TextEditingController();

  bool fieldsNotEmpty = false;
  File? _selectedFile;
  String _selectedDirectory = '';

  void saveContent(context) async {
    final title = titleController.text;
    final description = descriptionController.text;
    final tags = tagsController.text;

    final textContent =
        'Title:\n\n$title\n\nDescription:\n\n$description\n\nTags:\n\n$tags';

    try {
      if (_selectedFile != null) {
        await _selectedFile!.writeAsString(textContent);
      } else {
        final todayDate = getTodayDate();
        String metaDataDirPath = _selectedDirectory;
        if (metaDataDirPath.isEmpty) {
          final directory = await FilePicker.platform.getDirectoryPath();
          _selectedDirectory = metaDataDirPath = directory!;
        }
        final filePath = '$metaDataDirPath/$todayDate - $title - Texatube.txt';
        final newFile = File(filePath);
        await newFile.writeAsString(textContent);
      }
      SnackBarUtils.showSnackbar(
          context, Icons.check_circle_rounded, 'File Saved Successfully');
    } catch (e) {
      SnackBarUtils.showSnackbar(context, Icons.error, 'File not saved');
    }
  }

  void loadFile(context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        File file = File(result.files.single.path!);
        _selectedFile = file;

        final fileContent = await file.readAsString();

        final lines = fileContent.split('\n\n');
        titleController.text = lines[1];
        descriptionController.text = lines[3];
        tagsController.text = lines[5];

        SnackBarUtils.showSnackbar(
            context, Icons.upload_rounded, 'File Uploaded');
      } else {
        SnackBarUtils.showSnackbar(
            context, Icons.error_outline_rounded, 'No File Selected');
      }
    } catch (e) {
      SnackBarUtils.showSnackbar(
          context, Icons.error_outline_rounded, 'No File Selected');
    }
  }

  void newFile(context) {
    _selectedFile = null;
    titleController.clear();
    descriptionController.clear();
    tagsController.clear();
    SnackBarUtils.showSnackbar(
        context, Icons.file_upload_rounded, 'New File Created');
  }

  void changeDirectory(context) async {
    try {
      String? directory = await FilePicker.platform.getDirectoryPath();
      _selectedDirectory = directory!;
      _selectedFile = null;
      SnackBarUtils.showSnackbar(context, Icons.folder, 'New Folder Selected');
    } catch (e) {
      SnackBarUtils.showSnackbar(
          context, Icons.error_outline_rounded, 'No folder Selected');
    }
  }

  static String getTodayDate() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    final formattedDate = formatter.format(now);
    return formattedDate;
  }
}
