import 'package:fajrApp/main.dart';
import 'package:fajrApp/ui/screens/auth_screens/auth_view_model.dart';
import 'package:fajrApp/ui/widgets/app.button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:stacked/stacked.dart';

class LoginView extends ViewModelWidget<AuthViewModel> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, AuthViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: $styles.insets.l, vertical: $styles.insets.m),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/images/login.svg'),
          Gap($styles.insets.xxl),
          phoneNumberInputWidget(viewModel: viewModel),
          Gap($styles.insets.m),
        ],
      ),
    );
  }
}

Widget phoneNumberInputWidget({required AuthViewModel viewModel}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      InternationalPhoneNumberInput(
        textFieldController: viewModel.phoneController,
        onInputChanged: (value) {
          viewModel.inputChanged(value);
        },
        selectorConfig: const SelectorConfig(
          trailingSpace: false,
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          setSelectorButtonAsPrefixIcon: true,
          leadingPadding: 18,
        ),
        initialValue: viewModel.initialPhoneNumber,
        autoValidateMode: AutovalidateMode.disabled,
        formatInput: true,
        keyboardType: TextInputType.phone,
        cursorColor: const Color(0xff49526A),
        textStyle: $styles.text.titleLarge.copyWith(
          color: const Color(0xff49526A),
          fontWeight: FontWeight.w500,
          fontSize: 20.sp,
        ),
        inputDecoration: InputDecoration(
          filled: true,
          fillColor: $styles.colors.secondary,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular($styles.corners.sm),
            borderSide: const BorderSide(color: Color(0xff49526A)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular($styles.corners.sm),
            borderSide: const BorderSide(color: Color(0xff49526A)),
          ),
          hintStyle: $styles.text.titleMedium.copyWith(
            color: $styles.colors.white,
          ),
        ),
        hintText: 'Enter Mobile Number',
        selectorTextStyle: $styles.text.titleMedium.copyWith(
          color: $styles.colors.greyLight.withOpacity(0.7),
        ),
      ),
      Gap($styles.insets.s),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: viewModel.checkBoxValue,
            onChanged: (value) => viewModel.changeCheckBoxValue(
              value: value!,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.w),
            ),
            checkColor: const Color(0xff49526A),
            side: BorderSide(
              color: const Color(0xff9BA4BA),
              width: 2.w,
            ),
            activeColor: $styles.colors.greyLight,
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(top: $styles.insets.s),
              child: Text(
                'I agree to the Terms of Use of the service, as well as to the transfer and processing of my data to Fajr. I confirm that I am of legal age and responsible for posting an advertisement.',
                style: $styles.text.labelMedium.copyWith(
                  color: const Color(0xff9BA4BA),
                ),
              ),
            ),
          ),
        ],
      ),
      Gap($styles.insets.m),
      AppBtn(
        'Log In',
        isDisabled: true,
      ),
    ],
  );
}
