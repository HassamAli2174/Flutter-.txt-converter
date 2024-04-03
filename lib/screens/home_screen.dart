import 'package:flutter/material.dart';
import 'package:texatube/services/file.service.dart';
import 'package:texatube/utils/app_styles.dart';
import 'package:texatube/widgets/custom_textfield.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FileService fileService = FileService();

  @override
  void initState() {
    super.initState();
    _addListeners();
  }

  @override
  void dispose() {
    _removeListeners();
    super.dispose();
  }
// Listen for changes in the text fields and update the `fieldsNotEmpty` flag accordingly
  void _addListeners() {
    List<TextEditingController> controllers = [
      fileService.titleController,
      fileService.descriptionController,
      fileService.tagsController,
    ];

    for (TextEditingController controller in controllers) {
      controller.addListener(_onFieldChange);
    }
  }
 // Remove the listeners when the widget is disposed
  void _removeListeners() {
    List<TextEditingController> controllers = [
      fileService.titleController,
      fileService.descriptionController,
      fileService.tagsController,
    ];

    for (TextEditingController controller in controllers) {
      controller.removeListener(_onFieldChange);
    }
  }

  // Update the `fieldsNotEmpty` flag whenever a text field changes
  void _onFieldChange() {
    setState(() {
      fileService.fieldsNotEmpty =
          fileService.titleController.text.isNotEmpty &&
              fileService.descriptionController.text.isNotEmpty &&
              fileService.tagsController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.dark,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _mainButton(() => fileService.newFile(context), 'New File'),
                  // _mainButton(null, 'Save File'),
                  Row(
                    children: [
                      _actionButton(() => fileService.loadFile(context),
                          Icons.file_upload_rounded),
                      const SizedBox(
                        width: 8,
                      ),
                      _actionButton(() => fileService.changeDirectory(context),
                          Icons.folder),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                maxLength: 100,
                maxLines: 3,
                hintText: 'Enter Video Title',
                controller: fileService.titleController,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                maxLength: 5000,
                maxLines: 6,
                hintText: 'Enter Video Description',
                controller: fileService.descriptionController,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                maxLength: 500,
                maxLines: 4,
                hintText: 'Enter Video Tags',
                controller: fileService.tagsController,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  _mainButton(
                      fileService.fieldsNotEmpty
                          ? () => fileService.saveContent(context)
                          : null,
                      'Save file')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

// Define the style for the main buttons
  ElevatedButton _mainButton(Function()? onPressed, String text) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _buttonStyle(),
      child: Text(text),
    );
  }

// Define the style for the action buttons
  IconButton _actionButton(Function()? onPressed, IconData icon) {
    return IconButton(
      onPressed: onPressed,
      splashRadius: 20,
      color: AppTheme.blue,
      icon: Icon(
        icon,
        color: AppTheme.medium,
      ),
    );
  }

// Define the style for all buttons
  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
        backgroundColor: AppTheme.blue,
        foregroundColor: AppTheme.dark,
        disabledBackgroundColor: AppTheme.disabledbgButtoncolor,
        disabledForegroundColor: AppTheme.disabledfgButtoncolor);
  }
}
