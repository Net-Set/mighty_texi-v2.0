import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:taxi_driver/model/ContactNumberListModel.dart';
import 'package:taxi_driver/utils/Extensions/StringExtensions.dart';
import '../../network/RestApis.dart';
import '../main.dart';
import '../utils/Colors.dart';
import '../utils/Common.dart';
import '../utils/Extensions/AppButtonWidget.dart';
import '../utils/Extensions/ConformationDialog.dart';
import '../utils/Extensions/app_common.dart';

class EmergencyContactScreen extends StatefulWidget {
  @override
  EmergencyContactScreenState createState() => EmergencyContactScreenState();
}

class EmergencyContactScreenState extends State<EmergencyContactScreen> {
  ScrollController scrollController = ScrollController();

  final FlutterContactPicker _contactPicker = new FlutterContactPicker();
  Contact? _contact;

  int page = 1;
  int currentPage = 1;
  int totalPage = 1;

  List<ContactModel> contactNumber = [];

  @override
  void initState() {
    super.initState();
    init();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (currentPage < totalPage) {
          currentPage++;

          appStore.setLoading(true);
          setState(() {});
          init();
        }
      }
    });
    afterBuildCreated(() => appStore.setLoading(true));
  }

  void init() async {
    appStore.setLoading(true);
    await getSosList().then((value) {
      appStore.setLoading(false);
      currentPage = value.pagination!.currentPage!;
      totalPage = value.pagination!.totalPages!;

      if (currentPage == 1) {
        contactNumber.clear();
      }
      contactNumber.addAll(value.data!);
      setState(() {});
    }).catchError((error) {
      appStore.setLoading(false);

      log(error.toString());
    });
  }

  Future<void> addContact({String? name, String? contactNumber}) async {
    appStore.setLoading(true);
    Map req = {
      "title": name,
      "contact_number": contactNumber,
    };
    await saveSOS(req).then((value) {
      appStore.setLoading(false);
      init();
      toast(value.message);
    }).catchError((error) {
      appStore.setLoading(false);
      log(error.toString());
    });
  }

  Future<void> delete({required int id}) async {
    appStore.setLoading(true);
    await deleteSosList(id: id).then((value) {
      init();
      appStore.setLoading(false);
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
        title: Text(language.emergencyContact, style: boldTextStyle(color: Colors.white)),
      ),
      body: Observer(builder: (context) {
        return Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: contactNumber.length,
                itemBuilder: (_, index) {
                  return Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: primaryColor),
                        child: Text(contactNumber[index].title![0], style: boldTextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(contactNumber[index].title.validate(), style: boldTextStyle()),
                            SizedBox(height: 4),
                            Text(contactNumber[index].contactNumber.validate(), style: boldTextStyle()),
                          ],
                        ),
                      ),
                      inkWellWidget(
                        onTap: () async {
                          showConfirmDialogCustom(context,  title: language.areYouSureYouWantDeleteThisNumber, positiveText: language.yes, negativeText: language.no, dialogType: DialogType.DELETE,
                              onAccept: (c) async {
                            await delete(id: contactNumber[index].id!);
                          }, primaryColor: primaryColor);
                        },
                        child: Icon(Icons.delete_outline),
                      )
                    ],
                  );
                },
                separatorBuilder: (_, index) {
                  return Divider();
                },
              ),
            ),
            Visibility(
              visible: appStore.isLoading,
              child: loaderWidget(),
            ),
            !appStore.isLoading && contactNumber.isEmpty ? emptyWidget() : SizedBox(),
          ],
        );
      }),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: AppButtonWidget(
          width: MediaQuery.of(context).size.width,
          text: language.addContact,
          textStyle: boldTextStyle(color: Colors.white),
          color: primaryColor,
          onTap: () async {
            Contact? contact = await _contactPicker.selectContact();
            setState(() {
              _contact = contact;
            });
            if (_contact != null) addContact(name: _contact!.fullName.validate(), contactNumber: _contact!.phoneNumbers!.first);
          },
        ),
      ),
    );
  }
}
