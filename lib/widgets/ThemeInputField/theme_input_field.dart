import 'package:flutter/material.dart';

class ThemeInputField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final bool isPasswordInput;
  final bool isEmailInput;
  final bool disabled;
  final String variant;
  final Widget? suffixIcon;
  final bool hidePasswordVisibilityIcon;
  final bool isValid;
  final String? errorText;
  final Function(String)? onChanged;

  const ThemeInputField({
    required this.controller,
    required this.focusNode,
    required this.hintText,
    this.isPasswordInput = false,
    this.isEmailInput = false,
    this.disabled = false,
    this.variant = 'primary',
    this.suffixIcon,
    this.hidePasswordVisibilityIcon = false,
    required this.isValid,
    this.errorText,
    this.onChanged,
    super.key,
  });

  @override
  ThemeInputFieldState createState() => ThemeInputFieldState();
}

class ThemeInputFieldState extends State<ThemeInputField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        filled: true,
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontSize: 15.5,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        errorText: widget.isValid ? null : widget.errorText,
        suffixIcon: widget.isPasswordInput && !widget.hidePasswordVisibilityIcon
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: widget.disabled
                    ? null
                    : () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
              )
            : widget.suffixIcon,
      ),
      obscureText: widget.isPasswordInput && !_isPasswordVisible,
      enabled: !widget.disabled,
      onTap: widget.disabled ? null : () {},
    );
  }
}
