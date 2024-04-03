import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:texatube/utils/app_styles.dart';
import 'package:texatube/utils/snackbar_util.dart';

class CustomTextField extends StatefulWidget {
  final int maxLength;
  final int? maxLines;
  final String hintText;
  final TextEditingController controller;
  const CustomTextField(
      {super.key,
      required this.maxLength,
      this.maxLines,
      required this.hintText,
      required this.controller});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void copyClipboardData(context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    SnackBarUtils.showSnackbar(
        context, Icons.content_copy_rounded, 'copied text');
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      controller: widget.controller,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      keyboardType: TextInputType.multiline,
      cursorColor: AppTheme.blue,
      style: AppTheme.inputStyle,
      decoration: InputDecoration(
          hintStyle: AppTheme.hintStyle,
          hintText: widget.hintText,
          suffixIcon: _copyIcon(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.blue),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.medium),
          ),
          counterStyle: AppTheme.counterStyle),
    );
  }

  IconButton _copyIcon() {
    return IconButton(
        // onPressed: () {},
        onPressed: widget.controller.text.isNotEmpty
            ? () => copyClipboardData(context, widget.controller.text)
            : null,
        color: AppTheme.blue,
        splashRadius: 20,
        splashColor: AppTheme.blue,
        icon: const Icon(Icons.content_copy_rounded));
  }
}
