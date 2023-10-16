import 'package:chandlier/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlobalTextField extends StatefulWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Widget? prefixIcon;
  final String caption;
  final ValueChanged? onChanged;
  final FocusNode? focusNode;
  final bool readOnly;
  final TextInputFormatter? maskFormatter;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  bool isPassword;
  final bool? obscureText;
  final EdgeInsets? contentPadding;
  final int? maxLines;
  final int? maxLength;
  final TextCapitalization textCapitalization;

   GlobalTextField({
    Key? key,
    required this.hintText,
    this.textCapitalization=TextCapitalization.none,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.prefixIcon,
    this.maxLength,
    this.maxLines=1,
    this.caption = "",
    this.suffixIcon,
    this.isPassword = false,
    this.readOnly = false,
    this.controller,
    this.onChanged,
    this.focusNode,
    this.maskFormatter,
    this.obscureText,
    this.contentPadding,
  }) : super(key: key);

  @override
  State<GlobalTextField> createState() => _GlobalTextFieldState();
}

class _GlobalTextFieldState extends State<GlobalTextField> {
  late TextEditingController _internalController;
  final internalFocusNode = FocusNode();
  Color color = const Color(0xFFFAFAFA);

  @override
  void initState() {
    super.initState();
    _internalController = widget.controller ?? TextEditingController();
    widget.focusNode?.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    widget.focusNode?.removeListener(_onFocusChange);
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (String value) {
        widget.onChanged!(value);
      },
      obscuringCharacter: '●',
      readOnly: widget.readOnly,
      style: TextStyle(
        fontFamily: "Urbanist",
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color:  AppColors.white,
        height: 20 / 14,
      ),
      controller: _internalController,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      textCapitalization: widget.textCapitalization,
      focusNode: widget.focusNode ?? internalFocusNode,
      inputFormatters:widget.maskFormatter !=null ? [widget.maskFormatter!] : [],
      obscureText: widget.keyboardType == TextInputType.visiblePassword
          ? !widget.isPassword
          : false,
      decoration: InputDecoration(
        counterText: '',
        hintStyle: TextStyle(
          fontFamily: "Urbanist",
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color:  AppColors.white,
          height: 20 / 14,
        ),
        contentPadding:widget.contentPadding,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.keyboardType == TextInputType.visiblePassword
            ? IconButton(
          splashRadius: 1,
          icon: Icon(
            widget.isPassword
                ? Icons.visibility
                : Icons.visibility_off,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              widget.isPassword = !widget.isPassword;
            });
          },
        )
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color:  Color(0xFF674D3F),
              width: 1),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:  const BorderSide(color: Color(0xFF674D3F), width: 1),
          borderRadius: BorderRadius.circular(30),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF674D3F), width: 1),
          borderRadius: BorderRadius.circular(30),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF674D3F), width: 1),
          borderRadius: BorderRadius.circular(30),
        ),
        fillColor: const Color(0xFF674D3F),
        filled: true,
      ),
      // style: TextStyle(color: AppColors.dark3, fontSize: 16.sp),
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
    );
  }
}
