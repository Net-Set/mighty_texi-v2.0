import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:http/http.dart';
import 'package:taxi_driver/main.dart';
import 'package:taxi_driver/utils/Colors.dart';
import 'package:taxi_driver/utils/Extensions/AppButtonWidget.dart';
import 'package:taxi_driver/utils/Extensions/StringExtensions.dart';
import 'package:taxi_driver/utils/Extensions/app_common.dart';

import '../model/DocumentListModel.dart';
import '../model/DriverDocumentList.dart';
import '../network/NetworkUtils.dart';
import '../network/RestApis.dart';
import '../utils/Common.dart';
import '../utils/Constants.dart';
import '../utils/Extensions/ConformationDialog.dart';
import 'DriverDashboardScreen.dart';

class VerifyDeliveryPersonScreen extends StatefulWidget {
  final bool isShow;

  VerifyDeliveryPersonScreen({this.isShow = false});

  @override
  VerifyDeliveryPersonScreenState createState() => VerifyDeliveryPersonScreenState();
}

class VerifyDeliveryPersonScreenState extends State<VerifyDeliveryPersonScreen> {
  DateTime selectedDate = DateTime.now();

  List<DocumentModel> documentList = [];
  List<DriverDocumentModel> driverDocumentList = [];
  FilePickerResult? filePickerResult;

  List<int> uploadedDocList = [];
  List<String> eAttachments = [];
  List<File>? imageFiles;
  int docId = 0;

  int? isExpire;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2040),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    afterBuildCreated(() async {
      appStore.setLoading(true);
      await getDocument();
      await DriverDocument();
    });
  }

  ///Driver Document List
  Future<void> getDocument() async {
    appStore.setLoading(true);
    await getDocumentList().then((value) {
      documentList.addAll(value.data!);
      appStore.setLoading(false);
      setState(() {});
    }).catchError((error) {
      appStore.setLoading(false);

      log(error.toString());
    });
  }

  ///Document List
  Future<void> DriverDocument() async {
    appStore.setLoading(true);
    await getDriverDocumentList().then((value) {
      driverDocumentList.clear();
      driverDocumentList.addAll(value.data!);
      uploadedDocList.clear();
      driverDocumentList.forEach((element) {
        uploadedDocList.add(element.documentId!);
      });
      appStore.setLoading(false);

      setState(() {});
    }).catchError((error) {
      log(error.toString());
    });
  }

  /// Add Documents
  addDocument(int? docId, int? isExpire, {int? updateId, DateTime? dateTime}) async {
    MultipartRequest multiPartRequest = await getMultiPartRequest(updateId == null ? 'driver-document-save' : 'driver-document-update/$updateId');
    multiPartRequest.fields['driver_id'] = sharedPref.getInt(USER_ID).toString();
    multiPartRequest.fields['document_id'] = docId.toString();
    multiPartRequest.fields['is_verified'] = '0';
    if (isExpire != null) multiPartRequest.fields['expire_date'] = dateTime.toString();
    if (imageFiles != null) {
      multiPartRequest.files.add(await MultipartFile.fromPath("driver_document", imageFiles!.first.path));
    }
    multiPartRequest.headers.addAll(buildHeaderTokens());
    appStore.setLoading(true);
    sendMultiPartRequest(
      multiPartRequest,
      onSuccess: (data) async {
        await DriverDocument();
      },
      onError: (error) {
        toast(error.toString(), print: true);
        appStore.setLoading(false);
      },
    ).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString());
    });
  }

  /// SelectImage
  getMultipleFile(int? docId, int? isExpire, {int? updateId, DateTime? dateTime}) async {
    filePickerResult = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf']);

    if (filePickerResult != null) {
      showConfirmDialogCustom(
        context,
        title: language.uploadFileConfirmationMsg,
        onAccept: (BuildContext context) {
          setState(() {
            imageFiles = filePickerResult!.paths.map((path) => File(path!)).toList();
            eAttachments = [];
          });
          addDocument(docId, isExpire, dateTime: selectedDate, updateId: updateId);
        },
        positiveText: language.yes,
        negativeText: language.no,
        primaryColor: primaryColor,
      );
      if (isExpire == 1) selectDate(context);
    } else {}
  }

  /// Delete Documents
  deleteDoc(int? id) {
    appStore.setLoading(true);
    deleteDeliveryDoc(id!).then((value) {
      toast(value.message, print: true);

      DriverDocument();
      appStore.setLoading(false);
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString());
    });
  }

  Future<void> getDetailAPi() async {
    appStore.setLoading(true);
    await getUserDetail(userId: sharedPref.getInt(USER_ID)).then((value) {
      appStore.setLoading(false);

      sharedPref.setInt(IS_Verified_Driver, value.data!.is_verified_driver!);
      if (sharedPref.getInt(IS_Verified_Driver) == 1) {
        launchScreen(context, DriverDashboardScreen(), isNewTask: true, pageRouteAnimation: PageRouteAnimation.Slide);
      } else {
        toast('${language.userNotApproveMsg}');
      }
    }).catchError((error) {
      appStore.setLoading(false);

      log(error.toString());
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(language.verifyDocument, style: boldTextStyle(color: Colors.white)),
      ),
      body: Observer(builder: (context) {
        return Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(defaultRadius), color: Colors.grey.withOpacity(0.15)),
                          child: DropdownButtonFormField<DocumentModel>(
                            hint: Text(language.selectDocument, style: boldTextStyle()),
                            decoration: InputDecoration.collapsed(hintText: null),
                            isExpanded: true,
                            items: documentList.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e.name.validate() + '${e.isRequired == 1 ? '*' : ''}', style: primaryTextStyle()),
                              );
                            }).toList(),
                            onChanged: (DocumentModel? val) {
                              docId = val!.id!;
                              isExpire = val.hasExpiryDate!;

                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      if (docId != 0)
                        Visibility(
                          visible: !uploadedDocList.contains(docId),
                          child: inkWellWidget(
                            onTap: () {
                              if (isExpire == 1) {
                                getMultipleFile(docId, isExpire == 0 ? null : 1, dateTime: selectedDate);
                              } else {
                                getMultipleFile(docId, isExpire == 0 ? null : 1);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(left: 16),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(defaultRadius), color: Colors.grey.withOpacity(0.15)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.add, color: primaryColor, size: 24),
                                  SizedBox(width: 8),
                                  Text(language.addDocument, style: secondaryTextStyle()),
                                ],
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                  SizedBox(height: 30),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: driverDocumentList.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(driverDocumentList[index].documentName!, style: boldTextStyle()),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(defaultRadius)),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(defaultRadius),
                                  child: commonCachedNetworkImage(driverDocumentList[index].driverDocument!, height: 200, width: MediaQuery.of(context).size.width, fit: BoxFit.cover),
                                ),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    driverDocumentList[index].expireDate != null ? Text(language.expireDate, style: boldTextStyle()) : Text(''),
                                    SizedBox(width: 8),
                                    driverDocumentList[index].expireDate != null
                                        ? Expanded(child: Text(driverDocumentList[index].expireDate.toString(), style: primaryTextStyle()))
                                        : Expanded(
                                            child: Text(''),
                                          ),
                                    Visibility(
                                      visible: driverDocumentList[index].isVerified == 0,
                                      child: inkWellWidget(
                                        onTap: () {
                                          if (isExpire == 1) {
                                            getMultipleFile(docId, isExpire == 0 ? null : 1, dateTime: selectedDate, updateId: driverDocumentList[index].id);
                                          } else {
                                            getMultipleFile(docId, isExpire == 0 ? null : 1, updateId: driverDocumentList[index].id);
                                          }
                                        },
                                        child: Container(
                                          height: 25,
                                          width: 25,
                                          decoration: BoxDecoration(
                                            color: primaryColor.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(4),
                                            border: Border.all(color: primaryColor),
                                          ),
                                          child: Icon(Icons.edit, color: primaryColor, size: 14),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Visibility(
                                      visible: driverDocumentList[index].isVerified == 0,
                                      child: inkWellWidget(
                                        onTap: () async {
                                          showConfirmDialogCustom(
                                            context,
                                            title: language.areYouSureYouWantToDeleteThisDocument,
                                            onAccept: (BuildContext context) async {
                                              await deleteDoc(driverDocumentList[index].id);
                                            },
                                            positiveText: language.yes,
                                            negativeText: language.no,
                                            primaryColor: primaryColor,
                                          );
                                        },
                                        child: Container(
                                          height: 25,
                                          width: 25,
                                          decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(4),
                                            border: Border.all(color: Colors.red),
                                          ),
                                          child: Icon(Icons.delete, color: Colors.red, size: 14),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Visibility(
                                      visible: driverDocumentList[index].isVerified == 1,
                                      child: Icon(Icons.verified_user, color: Colors.green),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (_, index) {
                      return Divider();
                    },
                  )
                ],
              ),
            ),
            Visibility(
              visible: appStore.isLoading,
              child: loaderWidget(),
            ),
            if (!appStore.isLoading && driverDocumentList.isEmpty) emptyWidget()
          ],
        );
      }),
      bottomNavigationBar: driverDocumentList.isNotEmpty
          ? Visibility(
              visible: widget.isShow,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: AppButtonWidget(
                  color: primaryColor,
                  textStyle: boldTextStyle(color: Colors.white),
                  text: language.goDashBoard,
                  onTap: () {
                    getDetailAPi();
                  },
                ),
              ),
            )
          : SizedBox(),
    );
  }
}
