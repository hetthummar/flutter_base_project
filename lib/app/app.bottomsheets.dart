import 'package:fajrApp/app/locator.dart';
import 'package:fajrApp/const/enums/bottom_sheet_enums.dart';
import 'package:fajrApp/main.dart';
import 'package:fajrApp/ui/bottomsheets/auth_bottomsheet/auth_bottomsheet_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:stacked_services/stacked_services.dart';

void setUpBototmSheet() {
  final bottomSheetService = locator<BottomSheetService>();
  final builders = {
    BottomSheetEnum.basic: (context, sheetRequest, completer) => _BasicDialog(
          request: sheetRequest,
          completer: completer,
        ),
    BottomSheetEnum.error: (context, sheetRequest, completer) => _ErrorDilog(
          request: sheetRequest,
          completer: completer,
        ),
    BottomSheetEnum.noInternet: (context, sheetRequest, completer) => _NoInternetDilog(
          request: sheetRequest,
          completer: completer,
        ),
    BottomSheetEnum.auth: (context, sheetRequest, completer) => AuthBottomSheet(
          request: sheetRequest,
          completer: completer,
        ),
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}

class _BasicDialog extends StatelessWidget {
  final SheetRequest request;
  final Function(DialogResponse) completer;

  const _BasicDialog({required this.request, required this.completer});

  @override
  Widget build(BuildContext context) {
    return const Dialog(child: Text("Basic"));
  }
}

class _ErrorDilog extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const _ErrorDilog({
    required this.request,
    required this.completer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            request.title ?? "",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            request.description ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => completer(SheetResponse(confirmed: true)),
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                    child: Text(
                  request.mainButtonTitle ?? "OK",
                  style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _NoInternetDilog extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const _NoInternetDilog({
    required this.request,
    required this.completer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            request.title ?? "",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          Gap($styles.insets.xs),
          Text(
            request.description ?? "",
            textAlign: TextAlign.center,
            style: $styles.text.labelMedium.copyWith(
              color: $styles.colors.greyStrong,
            ),
          ),
          Gap($styles.insets.m),
          GestureDetector(
            onTap: () => completer(SheetResponse(confirmed: true)),
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    request.mainButtonTitle ?? "OK",
                    style: $styles.text.labelLarge.copyWith(
                      color: $styles.colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AuthBottomSheet extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const AuthBottomSheet({
    super.key,
    required this.request,
    required this.completer,
  });

  @override
  Widget build(BuildContext context) {
    return AuthBottomSheetView(
      completer: completer,
      request: request,
    );
  }
}
