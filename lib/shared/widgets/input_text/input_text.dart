import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class InputText extends StatefulWidget {
  final String hint;
  final Widget icon;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType keyboardType;
  final void Function(String value) onChanged;

  const InputText({
    super.key,
    required this.hint,
    required this.icon,
    required this.onChanged,

    this.initialValue,
    this.validator,
    this.controller,
    this.inputFormatters,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  final _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: _isFocused ? AppColors.primary : AppColors.stroke,
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16,
        children: [
          Padding(padding: EdgeInsets.only(left: 16), child: widget.icon),
          VerticalDivider(
            color: _isFocused ? AppColors.primary : AppColors.stroke,
            width: 1,
            thickness: 1,
          ),
          Expanded(
            child: TextFormField(
              focusNode: _focusNode,
              initialValue: widget.initialValue,
              validator: widget.validator,
              controller: widget.controller,
              inputFormatters: widget.inputFormatters,
              keyboardType: widget.keyboardType,
              onChanged: widget.onChanged,

              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                border: InputBorder.none,

                hintText: widget.hint,
                hintStyle: AppTextStyles.textMd.copyWith(
                  color: AppColors.input,
                ),

                labelStyle: AppTextStyles.textMd.copyWith(
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
