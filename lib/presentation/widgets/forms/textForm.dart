import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';

class TxtForm extends StatefulWidget {
  final String title;
  final String placeholder;
  final InputType inputType;
  final TextEditingController controller;
  final String errorMessage;
  final int maxLength;
  final Icon prefixIcon;
  final Icon sufixIcon;
  final Color txtColor;
  const TxtForm(
      {Key key,
      this.title,
      this.controller,
      this.inputType,
      this.placeholder = '',
      this.errorMessage,
      this.maxLength,
      this.prefixIcon,
      this.sufixIcon,
      this.txtColor = txtPrimary})
      : super(key: key);

  @override
  State<TxtForm> createState() => _txtFormState();


}

class _txtFormState extends State<TxtForm> {
  final FocusNode _focus = FocusNode();
  bool focused = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      focused = _focus.hasFocus;
    });
    debugPrint("Focus: ${_focus.hasFocus.toString()}");
  }

  bool _isValidate = true;
  String validationMessage = '';
  bool visibility = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.title != null
            ? Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.title ?? '',
                  style: GoogleFonts.sourceCodePro(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: widget.txtColor,
                      decoration: TextDecoration.none),
                ))
            : Container(),
        Material(
          color: Colors.transparent,
          child: TextField(
            focusNode: _focus,
            cursorColor: greenPrimary,
            controller: widget.controller,
            decoration: InputDecoration(
              errorText: _isValidate ? null : validationMessage,
              border: getBorder(false),
              enabledBorder: getBorder(false),
              focusedBorder: getBorder(true),
              filled: true,
              fillColor: Colors.white,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.sufixIcon ?? getSuffixIcon(),
              labelText: widget.placeholder,
              labelStyle: GoogleFonts.sourceCodePro(
                color: focused ? greenPrimary : greySoft,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            onSubmitted: checkValidation,
            keyboardType: getInputType(),
            obscureText: widget.inputType == InputType.Password && !visibility,
          ),
        )
      ],
    );
  }

  getSuffixIcon() {
    if (widget.inputType == InputType.Password) {
      return IconButton(
        onPressed: () {
          visibility = !visibility;
          setState(() {});
        },
        icon: Icon(
          visibility ? Icons.visibility : Icons.visibility_off,
          color: focused ? greenPrimary.withOpacity(0.5) : greySoft,
        ),
      );
    }
  }

  //get border of textinput filed
  OutlineInputBorder getBorder(bool focused) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(30.0)),
      borderSide:
          BorderSide(width: 2, color: focused ? greenPrimary : greySoft),
      gapPadding: 2,
    );
  }

  // input validations
  void checkValidation(String textFieldValue) {
    if (widget.inputType == InputType.Email) {
      //email validation
      _isValidate = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(textFieldValue);
      validationMessage = widget.errorMessage ?? 'Email no es valido';
      _isValidate = textFieldValue.isNotEmpty;
      validationMessage = widget.errorMessage ?? 'Dato obligatorio';
    } else if (widget.inputType == InputType.Number) {
      //contact number validation
      _isValidate = textFieldValue.length == widget.maxLength;
      validationMessage = widget.errorMessage ?? 'Numero no es valido';
      _isValidate = textFieldValue.isNotEmpty;
      validationMessage = widget.errorMessage ?? 'Dato obligatorio';
    } else if (widget.inputType == InputType.Password) {
      //password validation
      _isValidate =
          RegExp(r'^(=.*[A-Z])(=.*[a-z])(=.*[0-9])(=.*[!@#\$&*~]).{8,}$')
              .hasMatch(textFieldValue);
      validationMessage = widget.errorMessage ?? 'Contraseña no es valido';
      _isValidate = textFieldValue.isNotEmpty;
      validationMessage = widget.errorMessage ?? 'Dato obligatorio';
    } else if(widget.inputType == InputType.Default){
      _isValidate = textFieldValue.isNotEmpty;
      validationMessage = widget.errorMessage ?? 'Dato obligatorio';
    }
  }

  // return input type for setting keyboard
  TextInputType getInputType() {
    switch (widget.inputType) {
      case InputType.Default:
        return TextInputType.text;
      case InputType.Email:
        return TextInputType.emailAddress;
      case InputType.Number:
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }
}

//input types
enum InputType { Default, Email, Number, Password, PaymentCard }
