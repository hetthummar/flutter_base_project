import 'package:baseproject/app/locator.dart';
import 'package:baseproject/const/enums/bottom_sheet_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked_services/stacked_services.dart';

void setUpBototmSheet() {
  final bottomSheetService = locator<BottomSheetService>();
  final builders = {
    bottomSheetEnum.basic: (context, sheetRequest, completer) =>
        _BasicDialog(request: sheetRequest, completer: completer),
    bottomSheetEnum.error: (context, sheetRequest, completer) =>
        _ErrorDilog(request: sheetRequest, completer: completer),
    bottomSheetEnum.noInternet: (context, sheetRequest, completer) =>
        _NoInternetDilog(request: sheetRequest, completer: completer),
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}


class _BasicDialog extends StatelessWidget {
  final SheetRequest request;
  final Function(DialogResponse) completer;

  const _BasicDialog({required this.request, required this.completer});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      child: Text("Basic"),
    ));
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
      margin: EdgeInsets.all(25),
      padding: EdgeInsets.all(25),
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
          SizedBox(height: 4),
          Text(
            request.description ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () => completer(SheetResponse(confirmed: true)),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                    child: Text(
                  request.mainButtonTitle ?? "OK",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
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
      margin: EdgeInsets.all(25),
      padding: EdgeInsets.all(25),
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
          SizedBox(height: 4),
          Text(
            request.description ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () => completer(SheetResponse(confirmed: true)),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    request.mainButtonTitle ?? "OK",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
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
