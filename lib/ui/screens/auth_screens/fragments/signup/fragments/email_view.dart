import 'package:baseproject/config/color_config.dart';
import 'package:baseproject/ui/widgets/custom_button.dart';
import 'package:baseproject/utils/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailView extends StatefulWidget {
  String email = "";
  Function(String enteredMail) mailSubmitCallback;
  TextEditingController _emailController = TextEditingController();

  EmailView(this.email,this.mailSubmitCallback, {Key? key}) : super(key: key);

  @override
  State<EmailView> createState() => _EmailViewState();
}

class _EmailViewState extends State<EmailView> {
  bool isContinueBtnActive = false;


  @override
  void initState() {
    widget._emailController = TextEditingController(text: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    if(AppUtils().isValidEmail(widget._emailController.text)){
        isContinueBtnActive = true;
    }else{
        isContinueBtnActive = false;
    }
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5.h,
            ),
            const Text(
              "What's your email?",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87),
            ),
            SizedBox(
              height: 2.h,
            ),
            TextFormField(
              onChanged: (text) {
                if(AppUtils().isValidEmail(text)){
                  setState(() {
                    isContinueBtnActive = true;
                  });
                }else{
                  setState(() {
                    isContinueBtnActive = false;
                  });
                }
              },
              controller: widget._emailController,
              decoration: InputDecoration(
                hintText: "Email",
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.only(left: 16, right: 4, top: 12, bottom: 12),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black38, width: 1.0),
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
            Container(
              height: 8.h,
            ),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text:  const TextSpan(
                  children: [
                     TextSpan(
                      text: 'By tapping continue, I accept Vocal Gauge’s\n',
                      style:  TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins",
                          height: 1.4),
                    ),
                    TextSpan(
                      text: 'Terms of Use  ',
                      style:  TextStyle(
                        color: Colors.blue,
                        fontFamily: "Poppins",
                      ),
                    ),
                    TextSpan(
                      text: 'and',
                      style:  TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins",
                          height: 1.4),
                    ),
                    TextSpan(
                      text: '  Privacy Policy',
                      style:  TextStyle(
                        color: Colors.blue,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 3.h,
            ),
            CustomButton(
              "Continue",
              backgroundColor: ColorConfig.accentColor,
              height: 44,
              fontSize: 16,
              isDisabled: !isContinueBtnActive,
              buttonPressed: (){
                if(isContinueBtnActive){
                  widget.mailSubmitCallback(widget._emailController.text.trim());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}


